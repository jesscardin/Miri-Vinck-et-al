 function [R] = Mitra01_readwaveforms_01
%%
Mitra01_info;
global info
global figuredir
outputDir = fullfile(figuredir, 'waves');
mkdir(outputDir)
nFiles = length(info);
%%
%wvAll = [];
for iFile = [167]
    
    iFile
    load(fullfile(info(iFile).directory, [info(iFile).name '_wvlong']))
    spike.label = spike.label{1};
    spike = ft_checkdata(spike,'type', 'spike');
   % keyboard
    if info(iFile).has_rc==0    
        spike_base = Mitra01_select_baseline(fullfile(info(iFile).directory, info(iFile).name), info(iFile).base_start, info(iFile).seizure_onset,spike);    
    else
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
      %  keyboard
        [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);        
        spike_base = Mitra01_opto_select_baseline(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).seizure_onset_pulse,spike);
    end
     cfg = [];
     cfg.fsample = 40000;
     cfg.spikechannel = spike.label;
     cfg.normalize    = 'no';
     cfg.rejectonpeak = 'no';
     cfg.rejectclippedspikes = 'no';
     try
         [wv,spikenew] = ft_spike_waveform(cfg, spike_base);
     catch
         [wv,spikenew] = ft_spike_waveform(cfg, spike);
         disp('cannot use the baseline waveform, using the rc one')
     end         
     [val,ind] = max(nanvar(wv.avg,[],3));
     figure
     hd = plot(wv.time, squeeze(wv.avg(:,:,:))', 'LineWidth', 3);
     for k = 1:length(hd)
         labs{k} = ['lead' num2str(k)];
     end
     legend(hd, labs)
     ind = input('which waveform to use')
     figure, 
     try
         plot(wv.time,squeeze(spikenew.waveform{1}(ind,:,1:1000)),'k', 'LineWidth', 1)
     catch
         plot(wv.time,squeeze(spikenew.waveform{1}(ind,:,1:end)),'k', 'LineWidth', 1)
     end         
     hold on
     plot(wv.time, squeeze(wv.avg(:,ind,:)),'r', 'LineWidth', 3)
     title(sprintf('type = %s', info(iFile).neuron_type));
     disp('zoom')
     pause
         
     [x,y] = ginput
     indx = [];
     for k = 1:length(x)/2
         indx(k) = nearest(wv.time,x(k*2-1));    
     end
     % plot again but now with a subsample of spikes
     cfg = [];
     cfg.fsample = 40000;
     cfg.spikechannel = spike.label;
     cfg.normalize    = 'no';
     cfg.xindx        = indx;
     cfg.ylim         = reshape(y,[2 numel(y)/2]);
     cfg.lead         = ind;
     try
         [wv,spikenew] = ft_spike_waveform(cfg, spike_base);
     catch
         [wv,spikenew] = ft_spike_waveform(cfg, spike);
         disp('cannot use the baseline waveform, using the rc one')
     end         
     figure, 
     try
         plot(wv.time,squeeze(spikenew.waveform{1}(ind,:,1:1000)),'k', 'LineWidth', 1)
     catch
         plot(wv.time,squeeze(spikenew.waveform{1}(ind,:,1:end)),'k', 'LineWidth', 1)
     end         
     hold on
     plot(wv.time, squeeze(wv.avg(:,ind,:)),'r', 'LineWidth', 3)
    title(sprintf('type = %s', info(iFile).neuron_type));             
     
     % normalized waveform
    cfg = [];
    cfg.fsample = 40000;
    cfg.spikechannel = spike.label;
    cfg.normalize    = 'yes';
      cfg.xindx        = indx;     
     cfg.ylim         = reshape(y,[2 numel(y)/2]);
     cfg.lead         = ind;
  
    try
        [wv,spikenew] = ft_spike_waveform(cfg, spike_base);
    catch
        [wv,spikenew] = ft_spike_waveform(cfg, spike);
        disp('cannot use the baseline waveform, using the rc one')
    end         

                
     figure, 
     plot(wv.time, squeeze(wv.avg(:,ind,:)),'r', 'LineWidth', 3)
    title(sprintf('type = %s', info(iFile).neuron_type));
    pause(5)
    close all
    indAll(iFile) = ind;
    wvAll(iFile,:) = squeeze(wv.avg(:,ind,:));    
    celltype{iFile} = info(iFile).neuron_type;
    [a,b]=fileparts(info(iFile).directory);
    
    filename = fullfile(outputDir, [num2str(iFile) '_' b '_' info(iFile).name]);
    save(filename, 'wv', 'ind', 'wvAll', 'celltype', 'iFile')
end
%%
ttnames = {}; dirnames = {};
for k = 1:length(info)
    [a,b]= fileparts(info(k).directory);
    dirnames{k} = b;
    ttnames{k} = info(k).name;
end
%%
outputDir = fullfile(figuredir, 'waves');
dirInfo = dir(outputDir);
wvAll = [];
celltype = {};
for k = 3:length(dirInfo)
    indx = strfind(dirInfo(k).name,'_');
    indx2 = strfind(dirInfo(k).name, 'TT');
    isdir = (strcmp(dirnames,dirInfo(k).name(indx(1)+1:indx2-2)));
    ttname = dirInfo(k).name(indx2:end-4);
    isunit = strcmp(ttnames,ttname);
    indx = find(isdir & isunit);
    inp = load(fullfile(outputDir, dirInfo(k).name));
    %inp.iFile = indx(1);
    if isempty(indx), continue,end
    celltype{indx(1)} = inp.celltype{inp.iFile};
    if info(inp.iFile).exclude_waveform==1
        celltype{indx(1)} = 'ignore';
    end
    wvAll(indx(1),:) = inp.wv.avg(1,inp.ind,:);
    mn = wvAll(indx(1),:);
    ed = nearest(inp.wv.time,0.001);
   [vl,iup]   = nanmax(mn(1:end));
   [vl,idown] = nanmin(mn(iup:ed));
   idown = idown + iup - 1;
   [nLeads nSamples nSpikes] = size(mn);          
   % --- normalize amplitude ratio of spike waveforms if requested
   r = mn(:,iup)-mn(:,idown);
   mn = 2*mn./ repmat(r,1,nSamples); %makes it have amp of 2
   mn = mn + -repmat(mn(:,idown)+1,1,nSamples); % put the minus on -1    
   wvAll(indx(1),:) = mn;
end
%%
for k = 1:size(wvAll,1)
    figure, plot(wv.time, wvAll(k,:))
    title(k)
    hold on
    plot(wv.time, -1*ones(1,length(wv.time)))
    hold on
    plot(wv.time, +1*ones(1,length(wv.time)))
    hold on
    ct = nearest(wv.time,0);
    plot(wv.time([ct ct]), [-1 1],'k')
    pause
    close
end

%%    
wv = inp.wv;
ispv = (strcmp(celltype,'PV'))
issom = (strcmp(celltype,'SOM'))
isrs = (strcmp(celltype,'RS'));

ct = nearest(wv.time,0);
ed = nearest(inp.wv.time,0.001);
[val,mn] = nanmin(wvAll(:,ct:ed),[],2);
p2t = 1000*mn/40000;

ct2 = nearest(wv.time,0.0009);
repor = (wvAll(:,ct2));

figure,
plot(p2t(ispv), repor(ispv),'ro')
hold on
plot(p2t(issom), repor(issom),'go')
hold on
plot(p2t(isrs), repor(isrs),'ko')
hold on, plot([0.1 0.6], [-0.35 -0.35], 'k')

%%

figure,
plot(R.rate_base(ispv), repor(ispv),'ro')
hold on
plot(R.rate_base(issom), repor(i0ssom),'go')
hold on
plot(R.rate_base(isrs), repor(isrs),'ko')
%%
figure, hist(repor(isrs|ispv),15)
%%
figure
hold on
plot(p2t(issom), repor(issom),'go')

%%



%hist(p2t(p2t(:)'<0.6),20)

figure,
hist(p2t(ispv&p2t(:)'<0.6),10)
figure,
hist(p2t(isrs&p2t(:)'<0.6),10)
%%


ispv = find(strcmp(celltype,'PV'))
issom = find(strcmp(celltype,'SOM'))
isrs = find(strcmp(celltype,'RS'));
%%
bsrate = R.rate_base(isrs);
wvrs   = wvAll(isrs,:);

somrate = R.rate_base(issom);
wvsom   = wvAll(issom,:);
%%
figure, 
hold on
plot(wv.time, wvAll(issom,:)','g')
hold on
plot(wv.time, wvAll(isrs,:)','k')
hold on
plot(wv.time, wvAll(ispv,:)','r')
xlim([-0.001 0.0015])
%%
figure, 
hold on
plot(wv.time, nanmean(wvAll(issom,:)',2),'g')
hold on
plot(wv.time, nanmean(wvAll(isrs,:)',2),'k')
hold on
plot(wv.time, nanmean(wvAll(ispv,:)',2),'r')
xlim([-0.001 0.0015])

%%

figure
plot(wv.time, wvsom(somrate>10,:)','g')
hold on
plot(wv.time, wvsom(somrate<10,:)','k')
hold on
figure
plot(wv.time, wvrs(bsrate<10,:)','k')
hold on
plot(wv.time, wvrs(bsrate>10,:)','r')

    




    
    



