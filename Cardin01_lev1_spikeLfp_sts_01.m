function [] = Cardin_lev1_sts_01(dirsel)

% in this script we compute the spike triggered spectrum; only for the stimulus and
% baseline so far
% directories of loading and saving the data
global outputDirCardin
input1 = 'lev0_readlfp';
input2 = 'lev0_readsua';
input3 = 'lev1_getallstiminfo';
analysis = 'lev1_spikeLfp_sts';
info = Cardin01_lev0_info_01;

% loop over the various directories and read in the spike files
nDirs = length(info);
for iDir = dirsel

  fprintf('processing %s\n', info(iDir).dir);
  try
    inpSpike = load(fullfile(outputDirCardin, input2, info(iDir).dir,input2));
    inpLfp   = load(fullfile(outputDirCardin, input1, info(iDir).dir,input1));
    inpTrig = load(fullfile(outputDirCardin, input3, info(iDir).dir,input3));
  catch
    fprintf('just no data in %s\n', info(iDir).dir);
    continue
  end
  infoSession = inpTrig.infoSession;
  
  if isempty(inpSpike.spikeAll), continue,end
  
  % create LFP trials and spike trials        
  try
    cfg = [];  
    cfg.trl = cat(1,infoSession.trl_ts{:});
  catch
    continue,
  end
  if size(cfg.trl,1)<3, continue,end  
  iti_dur = -cfg.trl(1:end-1,2) + cfg.trl(2:end,1);
  mn_dur  = min(iti_dur);
  cfg.trl(:,1) = cfg.trl(:,1) - mn_dur;
  cfg.trl(:,2) = cfg.trl(:,2);
  cfg.trl(:,3) = -mn_dur;  

   % detect the type
  nXls  = length(info(iDir).xls);
  cnds  = {'ort', 'Ort', 'ori', 'Ori', 'sf','Sf', 'Crf', 'crf'};
  isCnd = [];isCndNew = [];
  for iXls = 1:nXls
    for iCnd = 1:length(cnds)
      isCnd(iXls,iCnd) = ~isempty(strfind(info(iDir).xls{iXls}, cnds{iCnd}));
    end
  end
  isCndNew(:,1) = sum(isCnd(:,1:4),2);
  isCndNew(:,2) = sum(isCnd(:,5:6),2);
  isCndNew(:,3) = sum(isCnd(:,7:8),2);
  
  for iXls = 1:nXls
    if isCndNew(iXls,1)==1
      infoSession.per_type{iXls} = 'ori';
    elseif isCndNew(iXls,2)==1
      infoSession.per_type{iXls} = 'contrast';
    elseif isCndNew(iXls,3)==1
      infoSession.per_type{iXls} = 'sf';
    end
  end
  
   % add some info about the trial identity as well
  nPeriods = length(infoSession.dec_stim);
  nTrials  = zeros(1,nPeriods);
  infoSession = rmfield(infoSession,'uniqueStims');
  [stim,period]   = deal([]); % concatenate within the loop
  stim_type = {};
  for iPeriod = 1:nPeriods
    nTrials(iPeriod) = length(infoSession.trl_ts{iPeriod});
    period = [period; iPeriod * ones(nTrials(iPeriod),1)]; %#ok<AGROW>
    infoSession.uniqueStims{iPeriod} = unique(infoSession.xlsStim{iPeriod});
    ustim  = infoSession.uniqueStims{iPeriod}(infoSession.dec_stim{iPeriod});
    stim   = [stim; ustim(:)];
    c = {};
    c(1:nTrials(iPeriod)) = {infoSession.per_type{iPeriod}};
    stim_type = cat(2,stim_type,c{:});
  end    
  
  % these will be the 4th and 5th column in Fieldtrip, this is a convention
  cfg.trl(:,4) = period;
  cfg.trl(:,5) = stim;  
  hasOri      = strcmp(stim_type,'ori');
  hasContrast = strcmp(stim_type,'contrast');
  hasSf       = strcmp(stim_type,'sf');
  cfg.trl(hasOri,6) = 1;
  cfg.trl(hasContrast,6) = 2;
  cfg.trl(hasSf,6) = 3;
  if any(cfg.trl(:,6)==0), error; end
  
  % create spikes in trial format
  cfg.timestampspersecond = 10^6;
  cfg.trlunit = 'timestamps';
  spike = inpSpike.spikeAll;
  spikeTrials = ft_spike_maketrials(cfg, spike);
  
  cfgLfp = [];
  iti_dur = -cfg.trl(1:end-1,2) + cfg.trl(2:end,1);
  mn_dur  = min(iti_dur);
  desiredDur  = 5*inpLfp.dataAll.fsample + 1;
  trl = cat(1,infoSession.trl_ts{:});
  [N,begSamp] = nearest_arrays(inpLfp.dataAll.time_timestamp{1}, trl(:,1));    
  [N,endSamp] = nearest_arrays(inpLfp.dataAll.time_timestamp{1}, trl(:,2));    
  nSamples     = endSamp-begSamp+1;
  extraSamples = desiredDur - nSamples;    
  cfgLfp.trl(:,1) = begSamp-extraSamples;
  cfgLfp.trl(:,2) = endSamp;
  cfgLfp.trl(:,3) = -extraSamples;
  n = size(cfg.trl,2);
  cfgLfp.trl(:,4:n)  = cfg.trl(:,4:n);  
  dataTrials = ft_redefinetrial(cfgLfp, inpLfp.dataAll);
    
  % preprocess the data again, we can later add more filtering
  cfg = [];
  cfg.dftfilter = 'yes';
  cfg.dftfreq   = [59.8:0.2:60.2];
  dataTrials    = ft_preprocessing(cfg, dataTrials);
  
  % compute the overall spike triggered spectra; selections only in the next round
  cfg     = [];
  cfg.foi = 2:2:200; 
  cfg.t_ftimwin = 7./cfg.foi;
  cfg.taper     = 'hanning';
  cfg.method    = 'convol';
  
  % we need to save them separately per LFP
  nChans = length(dataTrials.label);
  for iChan = 1:nChans
    cfg.channel = dataTrials.label{iChan};
    sts = ft_spiketriggeredspectrum(cfg, dataTrials,spikeTrials);
  
    output = fullfile(outputDirCardin, analysis, info(iDir).dir);
    mkdir(output);    
    filename = fullfile(output, [dataTrials.label{iChan} '_sts_stim']);
    save(filename, 'infoSession', 'sts', '-v7.3')
    clear sts
  end   
end
  
  
  


