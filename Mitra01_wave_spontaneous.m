function [rate] = Mitra01_rate_opto(name, opto, nlevels,pulse_start, pulse_end)

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

% take the baseline trials
nTrials = size(spike2.trialtime,1);
trialsSpontaneous = [nlevels:nlevels:nTrials];
trialsSpontaneous(end) = [];

% determine the start and end latency
times = spike2.trialtime(trialsSpontaneous,:);
endLatency = median(times(:,2));
begLatency = 0.05;

% add your selection based on which period you want to find, using
% opto_base_start and opto_base_end
% select on trialsSpontaneous using pulse_start and pulse_end those trials.
selection = trialsSpontaneous>=pulse_start & trialsSpontaneous<=pulse_end;
trialsSpontaneous = trialsSpontaneous(selection);


% compute the firing rate rate
cfg = [];
cfg.trials = trialsSpontaneous;
cfg.latency = [begLatency endLatency];
cfg.keeptrials = 'yes';
rate = ft_spike_rate(cfg, spike2);



