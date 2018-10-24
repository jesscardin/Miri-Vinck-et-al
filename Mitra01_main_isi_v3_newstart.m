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
for iFile = 1:nFiles
    info(iFile)
    if info(iFile).has_rc==0
        
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
        try
            [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
        catch
            TimeStamp = [];
        end
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
        ts2 = info(iFile).seizure_onset+info(iFile).ictalspike*1000000;    
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
        ts1 = info(iFile).seizure_onset+info(iFile).ictalspike*1000000;    
        tsEnd = ts1 + 60*10^6;
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
          if sum(diff(TimeStamp)>3*10^6)<10, continue,end      
      
                %ictal for RC files
         ts1 = info(iFile).injection_start_pulse;
         ts2 = info(iFile).seizure_onset_pulse;    
         ts2  = TimeStamp(ts2) + info(iFile).ictalspike*10^6;                  
         ts2 = nearest(TimeStamp,ts2);
%       
%             figure, plot(TimeStamp,'ko')
%          hold on
%          plot(ts1,TimeStamp(ts1),'ro')
%          title(iFile)
%          pause
%          close
         
        iFile
        
%         %ictal for RC files
%         ts1 = info(iFile).injection_start_pulse;
%         ts2 = info(iFile).seizure_onset_pulse;    
          Mitra01_rate_opto_03(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,TimeStamp(ts1),TimeStamp(ts2));
          
         ts  = round(linspace(ts1, ts2, nIctalPeriods+1)); 
         for iIctalPeriod = 1:nIctalPeriods
              [rate_ictal(iFile,iIctalPeriod)] = ...
              Mitra01_rate_opto_04(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,ts(iIctalPeriod), ts(iIctalPeriod+1));
          
              [isi_ictal(iFile,iIctalPeriod),logratio_ictal(iFile,iIctalPeriod)] = ...
              Mitra01_isi_opto_04(fullfile(info(iFile).directory, info(iFile).name), bins, TimeStamp, info(iFile).nlevels,ts(iIctalPeriod), ts(iIctalPeriod+1));    
         end
         
%          figure, plot(TimeStamp,'ko')
%          hold on
%          plot(ts1,TimeStamp(ts1),'ro')
%          title(iFile)
%          pause
%          close
    end        
    celltype{iFile} = info(iFile).neuron_type;
end
keyboard
% concatenate all the data and give it back as a result structure
R.rate_base = cat(1,rate_base(:).avg);
R.isi_base  = cat(1,isi_base(:).avg);
R.lv_base   = cat(1,isi_base(:).lv);
R.logratio_base = logratio_base;
R.isi_ictal = [];
for iFile = 1:nFiles
   nISI_base(iFile) = sum(~isnan(isi_base(iFile).isi{1}));
end

for k = 1:length(info)
    if isempty(rate_ictal(k,1).avg)
       for ii = 1:nIctalPeriods
        rate_ictal(k,ii).avg = NaN;
       end
       for ii = 1:nIctalPeriods
        isi_ictal(k,ii).avg = NaN(1,100);
        isi_ictal(k,ii).lv = NaN;
       end
    end
end
%R.isi_ictal= isi_ictal;
%R.rate_ictal = rate_ictal;

for ii = 1:nIctalPeriods
    R.isi_ictal(:,:,ii) = cat(1,isi_ictal(:,ii).avg);
    R.lv_ictal(:,ii)    = cat(1,isi_ictal(:,ii).lv);
    R.rate_ictal(:,ii)  = cat(1,rate_ictal(:,ii).avg);
%    for iFile = 1:nFiles
%        nISI_ictal(iFile,ii) = sum(~isnan(isi_ictal(iFile,ii).isi{1}));
   % end
end
%R.nISI_base      = nISI_base;
%R.nISI_ictal     = nISI_ictal;
R.logratio_ictal = logratio_ictal;

for k = 1:length(info)
    if isempty(rate_seizure(k).avg)
%       for ii = 1:nIctalPeriods
        rate_seizure(k).avg = NaN;
 %      end
     %  for ii = 1:nIctalPeriods
        isi_seizure(k).avg = NaN(1,100);
        isi_seizure(k).lv = NaN;
     %  end
    end
end
     
R.rate_seizure = cat(1,rate_seizure(:).avg);
R.isi_seizure  = cat(1,isi_seizure(:).avg);
R.lv_seizure   = cat(1, isi_seizure(:).lv);

R.isi_time     = isi_base(1).time;
R.logratio_seizure = logratio_seizure;
R.neurontype   = celltype;
% make some marker of the neuron type
for k = 1:length(R.neurontype)
    if isempty(R.neurontype{k}) | isnan(R.neurontype{k})
        R.neurontype{k} = 'Z';
    end
end
[a,b,c] = unique(R.neurontype);
R.neurontype_label = a;
R.neurontype_indx  = c;


    
    



