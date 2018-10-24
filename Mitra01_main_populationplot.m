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
cnt = -1;
for iFile = 1:nFiles
        iFile
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
       %          ts2 = nearest(TimeStamp,ts2);
          info(iFile).seizure_onset  = TimeStamp(ts2) + (50+info(iFile).ictalspike)*10^6;                         
        else
           info(iFile).seizure_onset =        info(iFile).seizure_onset + info(iFile).ictalspike*10^6 + 50*10^6;
        end        
 
    
        ts1 = info(iFile).base_start    
        ts2 = min(info(iFile).base_start+120*10^6, info(iFile).base_end);
        if ts2>info(iFile).base_end, warning('period extends baseline'); end
    
        
        
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
     %   ts1 = info(iFile).injection_start;    
      %  ts2 = info(iFile).seizure_onset;%+info(iFile).ictalspike+50*10^6;
      %  offset = 0;
        
       % [rate_base, spike2_injection] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1,ts2,offset);

      %  cfg = [];
     %   cfg.timwin = [-5 5];
     %   cfg.fsample = 200
     %   sdf_injection = ft_spikedensity(cfg, spike2_injection);
        
%         cfg = [];
%         cfg.topplotfunc = 'line';
%         cfg.errorbars = 'no';
%                 cfg.linewidth = 0.1;
% 
%         figure
%         ft_spike_plot_raster(cfg, spike2_injection,sdf_injection)
%         
        
        
            ts1 = info(iFile).injection_start;    
        offset = info(iFile).injection_start-info(iFile).seizure_onset;
        
        [rate_base, spike2_seizure] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1,info(iFile).seizure_onset,offset);

        cfg = [];
        cfg.timwin = [-5 5];
        cfg.fsample = 200
        sdf_seizure = ft_spikedensity(cfg, spike2_seizure);
        
        cfg = [];
        cfg.topplotfunc = 'line';
        cfg.errorbars = 'no';
        cfg.linewidth = 0.1;
%         figure
%         ft_spike_plot_raster(cfg, spike2_seizure,sdf_seizure)
%                                        
%         celltype{iFile} = info(iFile).neuron_type;
%         title(celltype{iFile})
%         pause
%         close all
%       
        
        if info(iFile).has_rc==1
        %bins = [TimeStamp TimeStamp+0.5*10^6];
        %bins = sort(bins);
            [N,todel] = histc(spike2_seizure.timestamp{1},bins);
            todel = ones(1,length(spike2_seizure.timestamp{1}));
            for iSpike = 1:length(spike2_seizure.timestamp{1})
                indx = find(TimeStamp<spike2_seizure.timestamp{1}(iSpike),1,'last')
                if isempty(indx), continue,end
                d = spike2_seizure.timestamp{1}(iSpike)-TimeStamp(indx);
                if d<(0.5*10^6)
                    todel(iSpike) = 1;
                else
                    todel(iSpike) = 0;
                end
                dAll(iSpike) = d;
            end
            spike2_seizure.timestamp{1}(todel==1) = [];
            spike2_seizure.trial{1}(todel==1) = [];
            spike2_seizure.time{1}(todel==1) = [];
            spike2_seizure.waveform{1} = spike2_seizure.waveform{1}(:,:,todel==1);

             [N,todel] = histc(spike2_base.timestamp{1},bins);
            todel = ones(1,length(spike2_base.timestamp{1}));
            for iSpike = 1:length(spike2_base.timestamp{1})
                indx = find(TimeStamp<spike2_base.timestamp{1}(iSpike),1,'last')
                if isempty(indx), continue,end
                d = spike2_base.timestamp{1}(iSpike)-TimeStamp(indx);
                if d<(0.5*10^6)
                    todel(iSpike) = 1;
                else
                    todel(iSpike) = 0;
                end
                dAll(iSpike) = d;
            end

            todel = todel==1;
            spike2_base.timestamp{1}(todel) = [];
            spike2_base.trial{1}(todel) = [];
            spike2_base.time{1}(todel) = [];
            spike2_base.waveform{1} = spike2_base.waveform{1}(:,:,todel);
        end

        cnt = cnt + 1
        if cnt==0
           spikeAllSeizure = spike2_seizure;
        else
            spikeAllSeizure.timestamp{1} = [spikeAllSeizure.timestamp{1}(:); spike2_seizure.timestamp{1}(:)];
            spikeAllSeizure.time{1} = [spikeAllSeizure.time{1}(:) ; spike2_seizure.time{1}(:)];
            spikeAllSeizure.trial{1} = [spikeAllSeizure.trial{1}(:); spike2_seizure.trial{1}(:)+cnt];
            spikeAllSeizure.waveform{1} = cat(3,spikeAllSeizure.waveform{1}, spike2_seizure.waveform{1});
            spikeAllSeizure.trialtime = [spikeAllSeizure.trialtime;spike2_seizure.trialtime];            
        end
        
          if cnt==0
           spikeAllInjection = spike2_base;
        else
            spikeAllInjection.timestamp{1} = [spikeAllInjection.timestamp{1}(:); spike2_base.timestamp{1}(:)];
            spikeAllInjection.time{1} = [spikeAllInjection.time{1}(:) ; spike2_base.time{1}(:)];
            spikeAllInjection.trial{1} = [spikeAllInjection.trial{1}(:); spike2_base.trial{1}(:)+cnt];
            spikeAllInjection.waveform{1} = cat(3,spikeAllInjection.waveform{1}, spike2_base.waveform{1});
            tt = spike2_base.trialtime;
 %           tt(1) = tt(1)-60;
           spikeAllInjection.trialtime = [spikeAllInjection.trialtime;tt];            
          end
        
         celltype{iFile} = info(iFile).neuron_type
    
end
%%
keyboard
%%
types = {'PV', 'RS', 'SOM'};
for iType = 1%:3
    % make a selection variable here
    isPilo = true(length(info),1);
    isPilo([140:162]) = false;
  %  isPilo = ~isPilo;
    hasrc = isPilo*0;
    hasrc(53:126) = true;
    isPilo = isPilo & hasrc==0;
  %  isPilo(53:126)  = false;
    %
    type = types{iType};
    cfg = [];
    cfg.timwin = [-20 20];
    cfg.trials = strcmp(celltype,type) &  isPilo(:)';
    %
    sdf = ft_spikedensity(cfg, spikeAllInjection);
    %
    
    cfg = [];
    cfg.trials = strcmp(celltype,type) & isPilo(:)';
    spikeSelect = ft_spike_select(cfg, spikeAllSeizure);
    spikeSelect.trialtime = spikeSelect.trialtime(unique(spikeSelect.trial{1}),:);
    uniques = unique(spikeSelect.trial{1});
    for iU = 1:length(uniques)
        sl = spikeSelect.trial{1}==uniques(iU);
        spikeSelect.trial{1}(sl) = iU;
    end
    cfg = [];
    rate = ft_spike_rate(cfg, spikeSelect);

    %
    cfg = [];
    cfg.binsize = 5;
    cfg.keeptrials = 'yes';
    psth = ft_spike_psth(cfg, spikeSelect);

    %
    A = squeeze(psth.trial);
    A = [A;ones(1,size(A,2))];
    mx = [squeeze(nanmax(psth.trial,[],3));1];
    cfg.trials = strcmp(celltype,'PV');
    %mx = [R.rate_base(cfg.trials);1];
    for k = 1:size(A,1)   
         A(k,:) = (A(k,:));%./mx(k));%./(A(k,:)+mx(k));     
    end
    figure, pcolor(psth.time, 1:size(A,1),log10(A)), colorbar, shading flat, hold on, plot([-50 -50], [0 16],'k'), colormap('jet')
    %
    A = squeeze(psth.trial);
    A = [A;ones(1,size(A,2))];
    mx = nanmax(A,[],2);
    mn = nanmean(A,2);
    for k = 1:size(A,1)
        A(k,:) = (A(k,:))./mx(k);
    end
    figure, pcolor(psth.time, 1:size(A,1),(A)), colorbar, shading flat, hold on, plot([-50 -50], [0 size(A,1)],'k', 'LineWidth', 2), colormap('jet')
 end
%%




















% make a selection variable here
isPilo = true(length(info),1);
isPilo(140:end) = true;
isPilo = ~isPilo;
isPilo(53:126)  = false;
%infonew = info(129:end);
%%
%celltype = celltype(129:end);
%%
type = 'SOM'
cfg = [];
cfg.timwin = [-20 20];
cfg.trials = strcmp(celltype,type) &  isPilo(:)';
%infonew = infonew(cfg.trials);
%%
sdf = ft_spikedensity(cfg, spikeAllInjection);
%%
cfg = [];
cfg.trials = strcmp(celltype,type) & isPilo(:)';
%cfg.trials(55:end) = false;
spikeSelect = ft_spike_select(cfg, spikeAllSeizure);
spikeSelect.trialtime = spikeSelect.trialtime(unique(spikeSelect.trial{1}),:);
uniques = unique(spikeSelect.trial{1});
for iU = 1:length(uniques)
    sl = spikeSelect.trial{1}==uniques(iU);
    spikeSelect.trial{1}(sl) = iU;
end
%%

cfg = [];
cfg.trials = strcmp(celltype,type) & isPilo(:)';
%cfg.trials(55:end) = false;
spikeSelect2 = ft_spike_select(cfg, spikeAllInjection);
spikeSelect2.trialtime = spikeSelect2.trialtime(unique(spikeSelect.trial{1}),:);
uniques = unique(spikeSelect2.trial{1});
for iU = 1:length(uniques)
    sl = spikeSelect2.trial{1}==uniques(iU);
    spikeSelect2.trial{1}(sl) = iU;
end
%%
cfg = [];
cfg.binsize = 5;
cfg.keeptrials = 'yes';
psth = ft_spike_psth(cfg, spikeSelect);
%%
cfg = [];
cfg.binsize = 10;
cfg.keeptrials = 'yes';
psth2 = ft_spike_psth(cfg, spikeSelect2);
%%
cfg = [];
cfg.timwin = [-2.5 2.5];
cfg.keeptrials = 'yes';
cfg.fsample = 1;
psth = ft_spikedensity(cfg, spikeSelect);

%%
A = squeeze(psth.trial);
A = [A;ones(1,size(A,2))];
mx = [squeeze(nanmax(psth.trial,[],3));1];
cfg.trials = strcmp(celltype,'PV');
%mx = [R.rate_base(cfg.trials);1];
for k = 1:size(A,1)   
     A(k,:) = (A(k,:));%./mx(k));%./(A(k,:)+mx(k));     
end
figure, pcolor(psth.time, 1:size(A,1),log10(A)), colorbar, shading flat, hold on, plot([-50 -50], [0 16],'k'), colormap('jet')
%
A = squeeze(psth.trial);
A = [A;ones(1,size(A,2))];
mx = nanmax(A,[],2);
mn = nanmean(A,2);
for k = 1:size(A,1)
    A(k,:) = (A(k,:))./mx(k);
end
figure, pcolor(psth.time, 1:size(A,1),(A)), colorbar, shading flat, hold on, plot([-50 -50], [0 16],'k'), colormap('jet')

%%



figure
cfg = [];
cfg.linewidth = 0.02;
cfg.topplotfunc = 'line';
ft_spike_plot_raster(cfg, spikeSelect)
%%

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
% make some marker of the neuron type
[a,b,c] = unique(R.neurontype);
R.neurontype_label = a;
R.neurontype_indx  = c;


    
    



