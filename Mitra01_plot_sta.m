function [] = Mitra01_plot_sta(dirsel, overwrite)

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

for iDir = dirsel
  %%
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
  selection  = ~ismember(num, numbers);
%  names = names(selection);
%  fileNames = fileNames(selection);
  
  
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
      newTs = TimeStamp(1):500:TimeStamp(end);
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
  
  if info(iDir).has_rc==0    
    spike_base = Mitra01_select_baseline(fullfile(info(iDir).directory, info(iDir).name), info(iDir).base_start, info(iDir).seizure_onset,inp.spike);    
  else
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iDir).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);        
    spike_base = Mitra01_opto_select_baseline(fullfile(info(iDir).directory, info(iDir).name), TimeStamp, info(iDir).nlevels,info(iDir).base_start_pulse, info(iDir).seizure_onset_pulse,inp.spike);
  end

 spike_base = rmfield(spike_base, 'time')
 spike_base = rmfield(spike_base, 'trial')
 spike_base = rmfield(spike_base, 'trialtime')
 
 [N,B] = histc(spike_base.timestamp{1}, dataLfp.time_timestamp{1});

  spikeAppend = ft_appendspike([], dataAll, spike_base);
  spikeAppend.trial{1}(end,:) = N;
  
  % select only baseline spontaneous firing 
  cfg = [];
  cfg.timwin = [-2 2];
  cfg.spikechannel = inp.spike.label;
  cfg.channel = dataAll.label;
  sta = ft_spiketriggeredaverage(cfg, spikeAppend);
  %%  
  for iChannel = 1:length(sta.label)
      figure, 
      plot(sta.time, sta.avg(iChannel,:),'-')
      title(sta.label{iChannel})      
      [a,b] = fileparts(info(iDir).directory);          
      mkdir(fullfile(outputDir, b, info(iDir).name))
      filename = fullfile(outputDir, b, info(iDir).name, [sta.label{iChannel} 'long.jpeg']);
      saveas(gcf,filename)      
      figure, 
      plot(sta.time, sta.avg(iChannel,:),'o-')
      set(gca,'XTick', -0.005:0.001:0.005)
      xlim([-0.005 0.005])
      title(sta.label{iChannel})
       filename = fullfile(outputDir, b, info(iDir).name, [sta.label{iChannel} 'short.jpeg']);
      saveas(gcf,filename)
  end
  close all
end
  
  
  
  
  


