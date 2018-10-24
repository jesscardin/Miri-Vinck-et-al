 function [R] = Mitra01_main_isi_v2()
%%
MitraPaper_info;
global info
global datadir_manuscript
nFiles = length(info);
celltype = {};
cnt = -1;
min_t = -500;
binsize = 20;
t = min_t:binsize:0;
avAll = NaN(167,length(t)-1);
for iFile = 1:nFiles
    iFile
%    keyboard
    if info(iFile).has_rc==1
      fieldSelection = ones(1,5);    
      extractHeader  = 1;
      [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
      info(iFile).base_start = TimeStamp(info(iFile).base_start_pulse+1);
      info(iFile).base_end= TimeStamp(info(iFile).base_end_pulse);
      info(iFile).injection_start = TimeStamp(info(iFile).injection_start_pulse);
      info(iFile).seizure_onset= TimeStamp(info(iFile).seizure_onset_pulse);

      ts1 = info(iFile).injection_start_pulse;
      ts2 = info(iFile).seizure_onset_pulse;    
      info(iFile).seizure_onset  = TimeStamp(ts2) + (50+info(iFile).ictalspike)*10^6;                         
    else
       info(iFile).seizure_onset =  info(iFile).seizure_onset + info(iFile).ictalspike*10^6 + 50*10^6;
    end
    
    ts1 = info(iFile).injection_start;        
    offset = info(iFile).injection_start-info(iFile).seizure_onset;
    [ignore, spike2_seizure] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1,info(iFile).seizure_onset,offset);
    latency(iFile) = -offset - 50*10^6;
    
    cfg = [];
    cfg.binsize = binsize;
    cfg.keeptrials = 'yes';
    cfg.latency    = [min_t 0];
    psth = ft_spike_psth(cfg, spike2_seizure);

    if info(iFile).has_rc==1
        cfg = [];
        cfg.trl(:,1) = TimeStamp(1:end-1);
        cfg.trl(:,2) = TimeStamp(2:end);
        cfg.trl(:,3) = 0;      
                
        cfg.timestampspersecond = 10^6;
        spike2 = ft_spike_maketrials(cfg, spike2_seizure);
        trialsSpontaneous = find((spike2.trialtime(:,2)-spike2.trialtime(:,1))>0.5 & TimeStamp(1:end-1)'>info(iFile).injection_start & TimeStamp(2:end)'<(50*10^6 + info(iFile).seizure_onset));
        times = spike2.trialtime(trialsSpontaneous,:);
        endLatency = max(times(:,2));
        begLatency = 0.5;
        if sum(times(:,2)>1.5)>10
            % figure, plot(times(:,2))
            %pause
            cfg = [];
            cfg.trials = trialsSpontaneous;
            cfg.latency = [begLatency endLatency];
            cfg.keeptrials = 'yes';
            rate = ft_spike_rate(cfg, spike2);

            t = -500:20:0;
            [N,B] = histc(-(info(iFile).seizure_onset-rate.cfg.previous.trl(rate.cfg.trials,1))/1000000,t);
            av = NaN(1,length(t)-1);
            Buns = unique(B);
            Buns(Buns==0) =  [];
            for iB = Buns(:)'
                av(iB) = mean(rate.trial(B==iB));
            end

            avAll(iFile,:) = av;
        else
            avAll(iFile,:) = NaN;
        end
    else
        avAll(iFile,:) = psth.avg;
    end
   celltype{iFile} = info(iFile).neuron_type;  
end
%%
R.avAll = avAll;
R.neurontype   = celltype;
for k = 1:length(R.neurontype)
    if isempty(R.neurontype{k}) || all(isnan(avAll(k,:)))
         R.neurontype{k} = 'Z';
    end
end
    
[a,b,c] = unique(R.neurontype);
R.neurontype_label = a;
R.neurontype_indx  = c;
R.time = psth.time;
R.latency = latency;
outputdir = fullfile(datadir_manuscript, 'rates_over_time');
mkdir(outputdir)
str = ['rates_over_time_'];
filename = fullfile(outputdir, str);    
save(filename, 'R');
    



