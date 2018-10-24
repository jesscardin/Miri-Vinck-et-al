function [isi, logratio] = MitraPaper_isi_opto(name, bins,opto, nlevels,pulse_start, pulse_end)

% spontaneous activity for the RC expts

% load
load(name)

% make trials running from previous to next opto pulse
cfg = [];
cfg.trl(:,1) = opto(1:end-1);
cfg.trl(:,2) = opto(2:end);
cfg.trl(:,3) = 0;
cfg.timestampspersecond = 10^6;
spike2 = ft_spike_maketrials(cfg, spike);

% take the baseline trials
nTrials = size(spike2.trialtime,1);
trialsSpontaneous = find((spike2.trialtime(:,2)-spike2.trialtime(:,1))>2);%%[(pulse_start):nlevels:nTrials];

% add your selection based on which period you want to find, using
% opto_base_start and opto_base_end
% select on trialsSpontaneous using pulse_start and pulse_end those trials.
selection = trialsSpontaneous>(pulse_start+1) & trialsSpontaneous<=pulse_end;
trialsSpontaneous = trialsSpontaneous(selection);

% determine the start and end latency
times = spike2.trialtime(trialsSpontaneous,:);
endLatency = max(times(:,2));
begLatency = 0.5;

% compute the isi for RC expt
cfg = [];
cfg.trials = trialsSpontaneous;
cfg.latency = [begLatency endLatency];
cfg.keeptrials = 'yes';

cfg.param = 'lv';
cfg.outputunit = 'proportion';
cfg.bins       = bins;
isi = ft_spike_isi(cfg, spike2);

tbeg     = nearest(isi.time, 0.1);
logratio = log10(nansum(isi.avg(1:tbeg))) - log10(nansum(isi.avg(tbeg+1:end)));