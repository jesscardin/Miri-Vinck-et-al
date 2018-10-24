function [] = Mitra01_plot_sta(dirsel, overwrite,nIctalPeriods)

%%
Mitra01_info;
global info
global figuredir
outputDir = fullfile(figuredir,'sta_examples');
mkdir(outputDir);

fsdownsample = 10000;

% loop over the various directories and read in the spike files
nDirs = length(info);
if nargin<1
  dirsel = 1:nDirs;
end
%
for iDir = dirsel
  %
  if info(iDir).exclude_sta==1, fprintf('skipping %s', info(iDir).directory); continue,end
  dataDir       = fullfile(info(iDir).directory_brain);
  dirInfo      = dir(dataDir);  
  fileNames    = {}; names = {};
  cnt = 0;
  nFiles     = length(dirInfo);
  for iFile = 1:nFiles
    if isempty(strfind(dirInfo(iFile).name, 'LFP')) && isempty(strfind(dirInfo(iFile).name, 'lfp')), continue,end
    cnt = cnt + 1;
    names{cnt}     = dirInfo(iFile).name;
    fileNames{cnt} = fullfile(dataDir, dirInfo(iFile).name);
  end
  
  % check the nums and only copy those    
  nUnits = length(names);  
  num    = zeros(1,nUnits);
  for iUnit = 1:nUnits
    num(iUnit) = str2num(names{iUnit}(4:5));
  end
  
  celnum = str2num(info(iDir).name(3));
  beg    = (celnum-1)*4+1;
  ed     = (celnum)*4;
    
  numbers = beg:ed;
  if ~isempty(info(iDir).munumbers)
      numbers = info(iDir).munumbers;
  end
  selection  = ismember(num, info(iDir).sta_channel(1));
  fileNames = fileNames(selection);
  names     = names(selection);
  
  % 1check automatically how many timestamps to use and how many to get rid off
  dataAll = []; dataLfp = [];
  T_all   = [];
  for iFile = 1:length(fileNames)
  
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    try
      [TimeStamp,B,C,D,data,F] = Nlx2MatCSC(fileNames{iFile}, fieldSelection,extractHeader, 1);      
    catch
      lasterr
      continue,
    end
    T_all = [T_all TimeStamp];
  end  
  
  % do the histogram on the timestamps to see which channels have the common timestamps
  [A,B,C] = unique(T_all);
  N = histc(T_all, A);
  hasAllChans = N==max(N);
  fprintf('keeping %d out of %d timestamps for %s', sum(hasAllChans), length(N), dataDir);
  goodStamps = A(hasAllChans);
  
  dataAll = [];
  for iFile = 1:length(fileNames)
  
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    try
      [TimeStamp,B,C,D,data,F] = Nlx2MatCSC(fileNames{iFile}, fieldSelection,extractHeader, 1);      
    catch
      lasterr
      continue,
    end

    keepStamps = ismember(TimeStamp, goodStamps);
    TimeStamp  = TimeStamp(keepStamps);
    data       = data(:,keepStamps);
    %if any(keepStamps==0), keyboard; end
    % read in the header using FieldTrip
    hdr = ft_read_header(fileNames{iFile});

    fprintf('Processing %s\n', fileNames{iFile});

    % extract information frmo the data
    Fs        = hdr.Fs;
    NRecords  = length(TimeStamp); % number of blocks of 512
    blockSize = size(data,1);
    if blockSize~=512, error('the expected block size was 512, something changed in Neuralynx format, please check'); end

    % see if there are any gaps in the data
    d = double(TimeStamp(2:end)-TimeStamp(1:end-1));
    d = d(:);
    maxJump  = ceil(10^6./(Fs-1))*blockSize;
    gapCorrectedTimeStampPerSample =  nanmean(d(d<maxJump),1)/512;    
    ts1 = TimeStamp(1);
    tsE = TimeStamp(end);  

    % check if some block has a wrong timestamp
    minJump = min(d);
    ts_range_predicted = (NRecords-1)*blockSize*gapCorrectedTimeStampPerSample;
    ts_range_observed  = double(tsE-ts1);
    if abs(ts_range_predicted-ts_range_observed)>minJump
       warning('discontinuous recording, predicted number of timestamps and observed number of timestamps differ by %2.2f \n Please consult the wiki on http://fieldtrip.fcdonders.nl/getting_started/neuralynx?&#discontinuous_recordings',...
         abs(ts_range_predicted-ts_range_observed) );       
    end

    % sort the timestamps, sometimes the blocks get out of order with neuralynx
    [val,indx] = sort(TimeStamp);
    [A,I] = unique(val); % consider only the unique values
    indx = indx(I);

    % create subsubsample interleave to 2kHz to save space, we don't need 40k for this analysis
    subSampleInterLeave = hdr.Fs/fsdownsample;
    data         = data(:,indx);
    TimeStamp    = TimeStamp(indx);
    data         = data(:); % make a vector from the data
    data         = data(1:subSampleInterLeave:end);

    % interpolate the timestamps within each block and get one timestamp per sample from this
    TimeStamp = repmat(TimeStamp, [blockSize 1]); 
    TimeStampPerSecond = 10^6; % this is always the case with the digital lynx
    addTs      = [0:(TimeStampPerSecond/hdr.Fs):(blockSize-1)*(TimeStampPerSecond/hdr.Fs)]';
    addTs      = repmat(addTs,[1 size(TimeStamp,2)]);
    TimeStamp = TimeStamp + addTs; % add the interpolated number of timestamps per block timestamp
    TimeStamp = TimeStamp(:);
    TimeStamp = TimeStamp(1:subSampleInterLeave:end);

    % do the interpolation if something goes wrong here
    if any(unique(diff(TimeStamp))~=(25*subSampleInterLeave)) % sampling frequency
      % do interpolation
      newTs = TimeStamp(1):(1000000/fsdownsample):TimeStamp(end);
      data = interp1(TimeStamp, data, newTs);
      TimeStamp = newTs;
      disp('correcting the timestamps')
    end
    
    % rewrite the header to account for the subsampling
    hdr.nSamples           = length(data);    
    hdr.TimeStampPerSample = gapCorrectedTimeStampPerSample;
    hdr.TimeStampPerSample = double(hdr.TimeStampPerSample)*subSampleInterLeave;
    hdr.Fs                 = fsdownsample;
    
    % constrct a raw fieldtrip structure to save the wheel data to the disk and do further
    % analysis
    dataLfp.time{1}  = [0:hdr.nSamples-1]./hdr.Fs;
    dataLfp.trial{1} = data(:)';
    dataLfp.hdr      = hdr;
    dataLfp.fsample  = hdr.Fs;
    dataLfp.label    = {names{iFile}(1:end-4)};
    dataLfp.cfg      = [];
    dataLfp.time_timestamp{1} = TimeStamp(:)'; % this is not a standard fieldtrip field but we create it anyway    
    
    if ~isempty(dataAll)      
      dataAll = ft_appenddata([],dataAll,dataLfp);
    else
      dataAll = dataLfp;
    end
  end
  dataAll.cfg.trl = [0 length(dataLfp.time{1})-1 0];
  dataAll.hdr = dataLfp.hdr;
  inp = load(fullfile(info(iDir).directory, [info(iDir).name]));
  
  % separate the baseline and the ictal periods
  clear spike_ictal
  if info(iDir).has_rc==0       
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
    spike_ictal(1) = Mitra01_select_baseline(fullfile(info(iDir).directory, info(iDir).name), info(iDir).base_start, info(iDir).base_end,inp.spike);    
        
    ts1 = info(iDir).injection_start;
    ts2 = info(iDir).seizure_onset;    
    ts  = linspace(ts1, ts2, nIctalPeriods+1);    
    for iIctalPeriod = 1:nIctalPeriods
        spike_ictal(iIctalPeriod+1) = Mitra01_select_baseline(fullfile(info(iDir).directory, info(iDir).name), ts(iIctalPeriod), ts(iIctalPeriod+1),inp.spike);    
    end
    if length(TimeStamp)>1
        for iIctalPeriod = 1:nIctalPeriods+1
            indx = 0;
            for iPulse = 1:length(TimeStamp)
             indx = indx + double(spike_ictal(iIctalPeriod).timestamp{1}>TimeStamp(iPulse) & spike_ictal(iIctalPeriod).timestamp{1}<(TimeStamp(iPulse)+0.05*10^6));
            end
            indx = logical(indx);
            spike_ictal(iIctalPeriod).timestamp{1} = spike_ictal(iIctalPeriod).timestamp{1}(~indx);
            spike_ictal(iIctalPeriod).waveform{1}  = spike_ictal(iIctalPeriod).waveform{1}(:,:,~indx);
            spike_ictal(iIctalPeriod).time{1}      = spike_ictal(iIctalPeriod).time{1}(~indx);
            spike_ictal(iIctalPeriod).trial{1}     = spike_ictal(iIctalPeriod).trial{1}(~indx);
            spike_ictal(iIctalPeriod).unit{1}      = spike_ictal(iIctalPeriod).unit{1}(~indx);        
        end
    end
  else
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iDir).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);           
    spike_ictal(1) = Mitra01_opto_select_baseline(fullfile(info(iDir).directory, info(iDir).name), TimeStamp, info(iDir).nlevels,info(iDir).base_start_pulse, info(iDir).base_end_pulse,inp.spike);
    for iIctalPeriod = 1:nIctalPeriods
        ts1 = info(iDir).injection_start_pulse;
        ts2 = info(iDir).seizure_onset_pulse;    
        ts  = round(linspace(ts1, ts2, nIctalPeriods+1));              
        spike_ictal(iIctalPeriod+1) = Mitra01_opto_select_baseline(fullfile(info(iDir).directory, info(iDir).name), TimeStamp, info(iDir).nlevels,ts1,ts2,inp.spike);
    end
  end

% spike_base = rmfield(spike_base, 'time')
% spike_base = rmfield(spike_base, 'trial')
% spike_base = rmfield(spike_base, 'trialtime')
 spike_ictal = rmfield(spike_ictal, 'time');
 spike_ictal = rmfield(spike_ictal, 'trial');
 spike_ictal = rmfield(spike_ictal, 'trialtime');

% keyboard
 %
 for iIctalPeriod = 1:nIctalPeriods+1

     [N,B] = histc(spike_ictal(iIctalPeriod).timestamp{1}, dataLfp.time_timestamp{1});

      spikeAppend = ft_appendspike([], dataAll, spike_ictal(iIctalPeriod));
      spikeAppend.trial{1}(end,:) = N;

      cfg = [];
      cfg.method = 'cubic';
      cfg.timwin = [-0.001 0.002];
      cfg.channel = spikeAppend.label{1};
      cfg.spikechannel = spikeAppend.label{2};
      spikeAppend = ft_spiketriggeredinterpolation(cfg, spikeAppend);

      % select only baseline spontaneous firing 
      cfg = [];
      cfg.timwin = [-2 2];
      cfg.spikechannel = inp.spike.label;
      cfg.channel = dataAll.label;
      sta = ft_spiketriggeredaverage(cfg, spikeAppend);

      cfg = [];
      cfg.method = 'mtmfft';
      cfg.foilim = [1 150];
      cfg.timwin = [-0.5 0.5];
      cfg.taper  = 'hanning';
      sts_lf = ft_spiketriggeredspectrum(cfg, spikeAppend);

      cfg = [];
      cfg.method = 'mtmfft';
      cfg.foilim = [4 150];
      cfg.timwin = [-0.125 0.125];
      cfg.taper  = 'hanning';
      sts_hf = ft_spiketriggeredspectrum(cfg, spikeAppend);

      cfg = [];
      cfg.method = 'ppc0';
      stat_lf = ft_spiketriggeredspectrum_stat(cfg, sts_lf);

      cfg = [];
      cfg.method = 'ppc0';
      stat_hf = ft_spiketriggeredspectrum_stat(cfg, sts_hf);

%       figure, 
%       subplot(4,1,1)
%       plot(stat_lf.freq, stat_lf.ppc0)
%       xlabel.('frequency')
%       ylabel('ppc')  
%       subplot(4,1,2)
%       plot(stat_hf.freq, stat_hf.ppc0)
%       xlabel('frequency')
%       ylabel('ppc')
%       subplot(4,1,3)
%       plot(sta.time, sta.avg)
%       xlabel('time')
%       ylabel('sta')      
%       title(sprintf('%d and %d', iIctalPeriod, iFile))
%         subplot(4,1,4)
%       plot(sta.time, sta.avg)
%       xlabel('time')
%       ylabel('sta')
%       xlim([-0.2 0.2])
%       pause
%       close 
 %     title(info(iDir).neuron_type);
      stat_lf_all(iDir,iIctalPeriod) = stat_lf;
      stat_hf_all(iDir,iIctalPeriod) = stat_hf;
      sta_all(iDir,iIctalPeriod) = sta;
      neurontype{iDir} = info(iDir).neuron_type;
     end
    iDir
end
%%  
keyboard
%%
ct_all = [];
cors = {'b', 'r', 'c', 'g'}; % baseline, four ictal periods
for iIctalPeriod = 1:nIctalPeriods + 1
    n = [];
    sel=strcmp(neurontype,'PV')% & repor(:)'>-0.35
    for k = find(sel)
        if ~isempty(stat_hf_all(k,iIctalPeriod).nspikes)
            n(k,:) = stat_hf_all(k,iIctalPeriod).nspikes;
        end
    end
    sel(n(:,10)<50) = false;
    %
    ct = cat(1,stat_hf_all(sel,iIctalPeriod).ppc0);
    ct(~isfinite(ct)) = NaN;

  %  figure, plot(stat_lf.freq, nanmean(ct(:,:)))
    ct = cat(1,sta_all(sel,iIctalPeriod).avg);
 %  figure, plot(sta_all(1,iIctalPeriod).time, nanmean(ct(:,:)))

     ct = cat(1,stat_hf_all(sel,iIctalPeriod).ppc0);
    ct(~isfinite(ct)) = NaN;

    figure(101),
    hold on
    p = plot(stat_hf.freq, nanmean(ct(:,:)))
    set(p,'Color', cors{iIctalPeriod})
    title('PV')
    ct2 = cat(1,sta_all(sel,iIctalPeriod).avg);
%   figure, plot(sta_all(1,iIctalPeriod).time, nanmean(ct2(:,:)))
    
   
   ct_all(iIctalPeriod,sel,:) = ct;
end

ct_all(ct_all==0) = NaN;
ct_all = ct_all-repmat(ct_all(1,:,:),[4 1 1]);

%
%ct_all(:,2,:) = nanmean(ct_all(:,2:end,:),2);
%
figure, 
title('PV')

plot(stat_hf.freq,squeeze(nanmean(ct_all,2))')
%
hold on
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))+squeeze(nanstd(ct_all,[],2)./sqrt(sum(~isnan(ct_all),2))),'--')
hold on
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))-squeeze(nanstd(ct_all,[],2)./sqrt(sum(~isnan(ct_all),2))),'--')
%%




ct_all = [];
cors = {'b', 'r', 'c', 'g'};
for iIctalPeriod = 1:nIctalPeriods + 1
    n = [];
    sel=strcmp(neurontype,'SOM') & repor(:)'>-0.35
    for k = find(sel)
        if ~isempty(stat_hf_all(k,iIctalPeriod).nspikes)
            n(k,:) = stat_hf_all(k,iIctalPeriod).nspikes;
        end
    end
    sel(n(:,10)<50) = false;
    %
    ct = cat(1,stat_hf_all(sel,iIctalPeriod).ppc0);
    ct(~isfinite(ct)) = NaN;

    %figure, plot(stat_lf.freq, nanmean(ct(:,:)))
    ct = cat(1,sta_all(sel,iIctalPeriod).avg);
   %figure, plot(sta_all(1,iIctalPeriod).time, nanmean(ct(:,:)))

     ct = cat(1,stat_hf_all(sel,iIctalPeriod).ppc0);
    ct(~isfinite(ct)) = NaN;

    figure(102),
    hold on
    p = plot(stat_hf.freq, nanmean(ct(:,:)))
    set(p,'Color', cors{iIctalPeriod})
    title('SOM')
    ct2 = cat(1,sta_all(sel,iIctalPeriod).avg);
   %figure, plot(sta_all(1,iIctalPeriod).time, nanmean(ct2(:,:)))
    
   
   ct_all(iIctalPeriod,sel,:) = ct;
end

ct_all(ct_all==0) = NaN;
ct_all = ct_all-repmat(ct_all(1,:,:),[4 1 1]);

%
%ct_all(:,2,:) = nanmean(ct_all(:,2:end,:),2);
%
figure, 
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))')
%0
title('SOM')
hold on
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))+squeeze(nanstd(ct_all,[],2)./sqrt(sum(~isnan(ct_all),2))),'--')
hold on
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))-squeeze(nanstd(ct_all,[],2)./sqrt(sum(~isnan(ct_all),2))),'--')
%%

ct_all = [];
cors = {'b', 'r', 'c', 'g'};
for iIctalPeriod = 1:nIctalPeriods + 1
    n = [];
    sel=strcmp(neurontype,'RS') %& repor(:)'<-0.35
    for k = find(sel)
        if ~isempty(stat_hf_all(k,iIctalPeriod).nspikes)
            n(k,:) = stat_hf_all(k,iIctalPeriod).nspikes;
        end
    end
    sel(n(:,10)<50) = false;
    %
    ct = cat(1,stat_hf_all(sel,iIctalPeriod).ppc0);
    ct(~isfinite(ct)) = NaN;

    %figure, plot(stat_lf.freq, nanmean(ct(:,:)))
    ct = cat(1,sta_all(sel,iIctalPeriod).avg);
   %figure, plot(sta_all(1,iIctalPeriod).time, nanmean(ct(:,:)))

     ct = cat(1,stat_hf_all(sel,iIctalPeriod).ppc0);
    ct(~isfinite(ct)) = NaN;

    figure(103),
    hold on
    p = plot(stat_hf.freq, nanmean(ct(:,:)))
    set(p,'Color', cors{iIctalPeriod})
    title('RS')
    ct2 = cat(1,sta_all(sel,iIctalPeriod).avg);
   %figure, plot(sta_all(1,iIctalPeriod).time, nanmean(ct2(:,:)))
    
   
   ct_all(iIctalPeriod,sel,:) = ct;
end
%
% ct_all = ct_all-repmat(ct_all(1,:,:),[4 1 1]);
ct_all(ct_all==0) = NaN;
ct_all = ct_all-repmat(ct_all(1,:,:),[4 1 1]);

%
%ct_all(:,2,:) = nanmean(ct_all(:,2:end,:),2);
%
figure, 
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))')
title('RS')
%
hold on
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))+squeeze(nanstd(ct_all,[],2)./sqrt(sum(~isnan(ct_all),2))),'--')
hold on
plot(stat_hf.freq,squeeze(nanmean(ct_all,2))-squeeze(nanstd(ct_all,[],2)./sqrt(sum(~isnan(ct_all),2))),'--')








