function [psth,intens] = MitraPaper_rate_psth_rc(name, opto, nlevels,pulse_start, pulse_end,iLevel, intensities,binsize,latency)

% spontaneous activity for the RC expts

% load
load(name)

% make trials running from previous to next opto pulse
cfg = [];
cfg.trl(:,1) = opto(1:end-2);
cfg.trl(:,2) = opto(3:end);
cfg.trl(:,3) = opto(1:end-2)-opto(2:end-1);

% construct a spike matrix
trl1 = [opto(1)-0.25*10^6 opto(2)];
trl1(3) = -0.25*10^6;
trl2 = [opto(end-1) opto(end)+0.25*10^6];
trl2(3) = opto(end-1)-opto(end);
cfg.trl = [trl1;cfg.trl;trl2];
cfg.timestampspersecond = 10^6;
spike2 = ft_spike_maketrials(cfg, spike);
if iLevel==1
  %  figure, plot(opto,'o-')
end

% take the baseline trials
startPulseLevel = (pulse_start + 1) + iLevel - 1;
endPulseLevel   = (pulse_end   + 1) + iLevel - 1;
intens = median(intensities(startPulseLevel:nlevels:endPulseLevel));
nTrials = size(spike2.trialtime,1);
trialsSpontaneous = [startPulseLevel:nlevels:endPulseLevel];
%trialsSpontaneous(end) = [];

% determine the start and end latency
times = spike2.trialtime(trialsSpontaneous,:);
%
cfg = [];
cfg.trials = trialsSpontaneous;
cfg.latency = latency;
cfg.keeptrials = 'yes';
cfg.binsize = binsize;
psth = ft_spike_psth(cfg, spike2);



