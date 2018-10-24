 function [R] = Mitra01_main_isi_v2(nIctalPeriods,bins)
%
if nargin<2
    bins = 0:0.002:1;
end
Mitra01_info;
global info

nFiles = length(info);
%[isi_base, logratio_base, rate_base, isi_ictal, logratio_base, rate_ictal, isi_seizure, logratio_seizure, rate_seizure] = deal([]);
celltype = {};
fsdownsample = 2000;
for iFile = 1:nFiles
    iFile
    if info(iFile).has_rc==0
        
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
        [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
     %   keyboard
        if length(TimeStamp)<2
            [rate_base(iFile)] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), info(iFile).base_start, info(iFile).base_end);
            % first the baseline
            [isi_base(iFile),logratio_base(iFile)] = Mitra01_isi(fullfile(info(iFile).directory, info(iFile).name), bins, info(iFile).base_start, info(iFile).base_end);            
        else
            [isi_base(iFile),logratio_base(iFile)] = Mitra01_isi_spontaneous(fullfile(info(iFile).directory, info(iFile).name), TimeStamp,bins, info(iFile).base_start, info(iFile).base_end);            
            rate_base(iFile) = Mitra01_rate_opto_spontaneous(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).base_start, info(iFile).base_end);
        end
    %    [rate_base(iFile)] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), info(iFile).base_start, info(iFile).base_end);

        % ictal periods
        ts1 = info(iFile).injection_start;
        
        
        
        %% auto seiz det
        
          if info(iFile).exclude_sta==1, fprintf('skipping %s', info(iFile).directory); continue,end
          dataDir       = fullfile(info(iFile).directory_brain);
          dirInfo      = dir(dataDir);  
          fileNames    = {}; names = {};
          cnt2 = 0;
          nFiles2     = length(dirInfo);
          for iFile2 = 1:nFiles2
            if isempty(strfind(dirInfo(iFile2).name, 'LFP')) && isempty(strfind(dirInfo(iFile2).name, 'lfp')), continue,end
            cnt2 = cnt2 + 1;
            names{cnt2}     = dirInfo(iFile2).name;
            fileNames{cnt2} = fullfile(dataDir, dirInfo(iFile2).name);
          end

          % check the nums and only copy those    
          nUnits = length(names);  
          num    = zeros(1,nUnits);
          for iUnit = 1:nUnits
            num(iUnit) = str2num(names{iUnit}(4:5));
          end

          celnum = str2num(info(iFile).name(3));
          beg    = (celnum-1)*4+1;
          ed     = (celnum)*4;

          numbers = beg:ed;
          if ~isempty(info(iFile).munumbers)
              numbers = info(iFile).munumbers;
          end
          selection  = ismember(num, info(iFile).sta_channel(1));
          fileNames = fileNames(selection);
          names     = names(selection);

          % 1check automatically how many timestamps to use and how many to get rid off
          dataAll = []; dataLfp = [];
          T_all   = [];
          for iFile2 = 1%:length(fileNames)

            fieldSelection = ones(1,5);    
            extractHeader  = 1;
            try
              [TimeStamp,B,C,D,data,F] = Nlx2MatCSC(fileNames{iFile2}, fieldSelection,extractHeader, 1);      
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
          for iFile2 = 1%:length(fileNames)

            fieldSelection = ones(1,5);    
            extractHeader  = 1;
            try
              [TimeStamp,B,C,D,data,F] = Nlx2MatCSC(fileNames{iFile2}, fieldSelection,extractHeader, 1);      
            catch
              lasterr
              continue,
            end

            keepStamps = ismember(TimeStamp, goodStamps);
            TimeStamp  = TimeStamp(keepStamps);
            data       = data(:,keepStamps);
            %if any(keepStamps==0), keyboard; end
            % read in the header using FieldTrip
            hdr = ft_read_header(fileNames{iFile2});

            fprintf('Processing %s\n', fileNames{iFile2});

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
            dataLfp.label    = {names{iFile2}(1:end-4)};
            dataLfp.cfg      = [];
            dataLfp.time_timestamp{1} = TimeStamp(:)'; % this is not a standard fieldtrip field but we create it anyway    

            if ~isempty(dataAll)      
              dataAll = ft_appenddata([],dataAll,dataLfp);
            else
              dataAll = dataLfp;
            end
          end        
        iFile
        if info(iFile).has_rc==1
          fieldSelection = ones(1,5);    
          extractHeader  = 1;
          [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
          info(iFile).base_start = TimeStamp(info(iFile).base_start_pulse+1);
          info(iFile).base_end= TimeStamp(info(iFile).base_end_pulse);
          info(iFile).injection_start = TimeStamp(info(iFile).injection_start_pulse);
          info(iFile).seizure_onset= TimeStamp(info(iFile).seizure_onset_pulse);
        end
        
       
        ts1 = info(iFile).base_start    
        ts2 = min(info(iFile).base_start+120*10^6, info(iFile).base_end);
        if ts2>info(iFile).base_end, warning('period extends baseline'); end
    
        
        cfg = [];
        cfg.hpfilter = 'yes';
        cfg.hpfreq   = 0.5;
        cfg.hpinstabilityfix = 'reduce';
%        keyboard
        dataAllNew = ft_preprocessing(cfg, dataAll);
        dataAllNew.time_timestamp = dataAll.time_timestamp;
        dataAll = dataAllNew;
        
%         cfg = [];
        sample1 = nearest(dataAll.time_timestamp{1}, ts1);
        sample2 = nearest(dataAll.time_timestamp{1}, ts2);
        cfg.trl = [sample1 sample2 0];
        dataBase = ft_redefinetrial(cfg, dataAll);
       %  figure, plot(dataBase.time{1}, dataBase.trial{1})
    
        cfg = [];
        erp = ft_timelockanalysis(cfg, dataBase);
        if iFile==17 | iFile==18
            toi = nearest(dataBase.time{1}, 80);
            z = zscore(dataBase.trial{1}(1:toi),1,2);
            mnB = mean(dataBase.trial{1}(1:toi));
            sdB = std(dataBase.trial{1}(1:toi));
            dataBase.time{1} = dataBase.time{1}(1:toi);
            dataBase.trial{1} = dataBase.trial{1}(1:toi);
        elseif iFile>=94 & iFile<98
            toi = nearest(dataBase.time{1}, 50);
            z = zscore(dataBase.trial{1}(toi:end),1,2);
            mnB = mean(dataBase.trial{1}(toi:end));
            sdB = std(dataBase.trial{1}(toi:end));
            dataBase.time{1} = dataBase.time{1}(toi:end);
            dataBase.trial{1} = dataBase.trial{1}(toi:end);            
        else
            z = zscore(dataBase.trial{1},1,2);
            mnB = mean(dataBase.trial{1});
            sdB = std(dataBase.trial{1});
        end
        zAbs = abs(z);
        zMedian = smooth(zAbs,10000);
        for k = 1:10000
            sd_base(k) = std(zMedian(10001+k:10000:end-10000));
        end
        sd_base = nanmean(sd_base);
        mn_base = mean(zMedian(10001:end-10000));
        zMedian2 = smooth(zAbs,20000);
        
        for k = 1:20000
            sd_base2(k) = std(zMedian2(20001+k:20000:end-20000));
        end
        sd_base2 = nanmean(sd_base2);
        mn_base2 = mean(zMedian2(20001:end-20000));
        
%         figure, plot(dataBase.time{1}, (dataBase.trial{1}-mnB)./sdB)
%         hold on
%         plot(dataBase.time{1},zMedian2,'r')
%         hold on        
%          plot(dataBase.time{1}, ones(size(dataBase.time{1}))*(mn_base2 + 1.63*sd_base2),'r')             
%        
        
        offset = ts1-ts2;
        
        [rate_base, spike2_base] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1,ts2,offset);

        
        
        cfg = [];
        cfg.timwin = [-5 5];
        cfg.fsample = 200;
        sdf_base = ft_spikedensity(cfg, spike2_base);
        
%         cfg = [];
%         cfg.topplotfunc = 'line';
%         cfg.errorbars = 'no';
%                 cfg.linewidth = 0.1;
% 
%         figure
%         ft_spike_plot_raster(cfg, spike2_base,sdf_base)
% 
%         
        ts1 = info(iFile).injection_start;    
        ts2 = info(iFile).seizure_onset;
        offset = 0;
        
        [rate_base, spike2_injection] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1,ts2,offset);

        cfg = [];
        cfg.timwin = [-5 5];
        cfg.fsample = 200
        sdf_injection = ft_spikedensity(cfg, spike2_injection);
        
%         cfg = [];
%         cfg.topplotfunc = 'line';
%         cfg.errorbars = 'no';
%                 cfg.linewidth = 0.1;
% 
%         figure
%         ft_spike_plot_raster(cfg, spike2_injection,sdf_injection)
%         
        
        
            ts1 = info(iFile).injection_start;    
        offset = info(iFile).injection_start-(info(iFile).seizure_onset);
        
        [rate_base, spike2_seizure] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1,info(iFile).seizure_onset+120*10^6,offset);

        cfg = [];
        sample1 = nearest(dataAll.time_timestamp{1}, ts1);
        sample2 = nearest(dataAll.time_timestamp{1}, info(iFile).seizure_onset+120*10^6);
        cfg.trl = [sample1 sample2 offset*dataAll.fsample/1000000];
        dataNew = ft_redefinetrial(cfg, dataAll);
        
        cfg = [];
%         try
%         erp = ft_timelockanalysis(cfg, dataNew);
%         end
%         cfg = [];
        cfg.timwin = [-5 5];
        cfg.fsample = 200
        sdf_seizure = ft_spikedensity(cfg, spike2_seizure);
        
        
        
%         cfg = [];
%         cfg.topplotfunc = 'line';
%         cfg.errorbars = 'no';
%         cfg.linewidth = 0.1;
%         try
%         erp.label = spike2_seizure.label;
%         end
%         try
%          figure
%          ft_spike_plot_raster(cfg, spike2_seizure,erp)
%         end
%                                        
%         celltype{iFile} = info(iFile).neuron_type;
%         title(celltype{iFile})
     %    pause
       %  close all
%       

%          cfg = [];
%         cfg.method = 'mtmconvol';
%         cfg.foi    = 1:1:120;
%         cfg.taper = 'hanning';
%         cfg.toi   = dataBase.time{1}(1):0.1:dataBase.time{1}(end);
%         cfg.t_ftimwin = 9./cfg.foi;
%         freq2 = ft_freqanalysis(cfg,dataBase); 
%         w = ones(1,30)./30;
%         
%         cfg = [];
%         cfg.method = 'mtmconvol';
%         cfg.foi    = 1:1:120;
%         cfg.taper = 'hanning';
%         cfg.toi   = dataNew.time{1}(1):0.1:dataNew.time{1}(end);
%         cfg.t_ftimwin = 9./cfg.foi;
%         freq = ft_freqanalysis(cfg,dataNew); 
%         w = ones(1,30)./30;
        
        
%         figure, 
         z = (dataNew.trial{1} - mnB)./sdB;
%         plot(dataNew.time{1}, (z),'k')
         zAbs = abs(z);
         zMedian = smooth(zAbs,10000);
         zMedian2 = smooth(zAbs,20000);        
%         hold on
%         plot(dataNew.time{1}, zMedian,'g')                
%         hold on
%         plot(dataNew.time{1}, zMedian2,'r')                
            
        indx = find(zMedian2'> (ones(size(dataNew.time{1}))*(mn_base2 + 3*sd_base2)));
        jumps = find(diff(indx)>1)+1;
        if ~isempty(indx)
            jumps = [1 jumps];
            start = [indx(jumps) length(zMedian2)];
            clusterSize = [];
            for iJump = 1:length(start)-1
                idx = find(zMedian2(start(iJump):end)'<(ones(size(dataNew.time{1}(start(iJump):end)))*(mn_base2 + 3*sd_base2)),1,'first');
                if isempty(idx)
                    idx = length(zMedian2);
                else
                    idx = idx + start(iJump);
                end            
                clusterSize(iJump) = sum(zMedian2(start(iJump):idx))
            end
            [val,ind] = max(clusterSize);
        else
            ind = [];
        end
        
        if isempty(ind)
            dt = 0;
        elseif iFile==28
            dt = 2;
        elseif iFile>=37 & iFile<=40
            dt = -70;
        elseif iFile>40 & iFile<=47
            dt = 25;
        elseif iFile==55
            dt = -20;
        elseif iFile==58
            dt = -45;
        elseif iFile==108
            dt = -40;
        else
            dt = dataNew.time{1}([start(ind)]);
        end
        %%
                                
               fieldSelection = ones(1,5);    
        extractHeader  = 1;
        [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);

        ts2 = info(iFile).seizure_onset+dt*10^6;    
        ts  = linspace(ts1, ts2, nIctalPeriods+1);    
        for iIctalPeriod = 1:nIctalPeriods

             if length(TimeStamp)<2
                 [rate_ictal(iFile,iIctalPeriod)] = ...
                 Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts(iIctalPeriod), ts(iIctalPeriod+1));
                [isi_ictal(iFile,iIctalPeriod),logratio_ictal(iFile,iIctalPeriod)] = ...
                Mitra01_isi(fullfile(info(iFile).directory, info(iFile).name), bins, ts(iIctalPeriod), ts(iIctalPeriod+1));
             
             else
                [rate_ictal(iFile,iIctalPeriod)] = ...
                 Mitra01_rate_opto_spontaneous(fullfile(info(iFile).directory, info(iFile).name),  TimeStamp,ts(iIctalPeriod), ts(iIctalPeriod+1));                
                [isi_ictal(iFile,iIctalPeriod),logratio_ictal(iFile,iIctalPeriod)] = ...
                Mitra01_isi_spontaneous(fullfile(info(iFile).directory, info(iFile).name), TimeStamp,bins, ts(iIctalPeriod), ts(iIctalPeriod+1));
             
             end
%Mitra01_rate_opto_spontaneous                 
        end

        % seizure
        ts1 = info(iFile).seizure_onset;    
        tsEnd = ts1 + 30*10^6;
        [isi_seizure(iFile),logratio_seizure(iFile)] = Mitra01_isi(fullfile(info(iFile).directory, info(iFile).name), bins, ts1, tsEnd);    
        [rate_seizure(iFile)] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1, tsEnd);    
        
%         keyboard
%         cfg = [];
%         cfg.trl = [info(iFile).injection_start-60*10^6 info(iFile).injection_start+60*10^6 -60*10^6];
%         cfg.timestampspersecond  = 10^6;
%         inp = load(fullfile(info(iFile).directory, info(iFile).name));
%         spike_raw(iFile) = ft_spike_maketrials(cfg, inp.spike);
%         
%         cfg = [];
%         cfg.trl = [info(iFile).seizure_start-60*10^6 info(iFile).seizure_start+60*10^6 -60*10^6];
%         cfg.timestampspersecond  = 10^6;
%         inp = load(fullfile(info(iFile).directory, info(iFile).name));
%         spike_raw(iFile) = ft_spike_maketrials(cfg, inp.spike);
        
        
    else % write something new that produces the same stuff for RC
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
        [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
        
        rate_base(iFile) = Mitra01_rate_opto(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse);
        
        [isi_base(iFile),logratio_base(iFile)] = Mitra01_isi_opto(fullfile(info(iFile).directory, info(iFile).name),bins, TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse);
        
%         %ictal for RC files
         ts1 = info(iFile).injection_start_pulse;
         
        if isempty(ind)
            dt = 0;
        elseif iFile==28
            dt = 2;
        elseif iFile>=37 & iFile<=40
            dt = -70;
        elseif iFile>40 & iFile<=47
            dt = 25;
        elseif iFile==55
            dt = -20;
        elseif iFile==58
            dt = -45;
        elseif iFile==108
            dt = -40;
        else
            dt = dataNew.time{1}([start(ind)]);
        end
         ts2 = info(iFile).seizure_onset_pulse;    
         ts2  = TimeStamp(ts2) + dt*10^6;                  
         ts2 = nearest(TimeStamp,ts2);
         
         ts  = round(linspace(ts1, ts2, nIctalPeriods+1)); 
         for iIctalPeriod = 1:nIctalPeriods
              [rate_ictal(iFile,iIctalPeriod)] = ...
              Mitra01_rate_opto(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,ts(iIctalPeriod), ts(iIctalPeriod+1));
          
              [isi_ictal(iFile,iIctalPeriod),logratio_ictal(iFile,iIctalPeriod)] = ...
              Mitra01_isi_opto(fullfile(info(iFile).directory, info(iFile).name), bins, TimeStamp, info(iFile).nlevels,ts(iIctalPeriod), ts(iIctalPeriod+1));    
         end
    end        
    celltype{iFile} = info(iFile).neuron_type;
end

% concatenate all the data and give it back as a result structure
R.rate_base = cat(1,rate_base(:).avg);
R.isi_base  = cat(1,isi_base(:).avg);
R.lv_base   = cat(1,isi_base(:).lv);
R.logratio_base = logratio_base;
R.isi_ictal = [];
for iFile = 1:nFiles
   nISI_base(iFile) = sum(~isnan(isi_base(iFile).isi{1}));
end
for ii = 1:nIctalPeriods
    R.isi_ictal(:,:,ii) = cat(1,isi_ictal(:,ii).avg);
    R.lv_ictal(:,ii)    = cat(1,isi_ictal(:,ii).lv);
    R.rate_ictal(:,ii)  = cat(1,rate_ictal(:,ii).avg);
    for iFile = 1:nFiles
        nISI_ictal(iFile,ii) = sum(~isnan(isi_ictal(iFile,ii).isi{1}));
    end
end
R.nISI_base      = nISI_base;
R.nISI_ictal     = nISI_ictal;
R.logratio_ictal = logratio_ictal;
R.rate_seizure = cat(1,rate_seizure(:).avg);
R.isi_seizure  = cat(1,isi_seizure(:).avg);
R.lv_seizure   = cat(1, isi_seizure(:).lv);
R.isi_time     = isi_base(1).time;
R.logratio_seizure = logratio_seizure;
R.neurontype   = celltype;
keyboard
% make some marker of the neuron type
[a,b,c] = unique(R.neurontype);
R.neurontype_label = a;
R.neurontype_indx  = c;


    
    



