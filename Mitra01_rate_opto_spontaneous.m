function [rate] = Mitra01_rate_opto_spontaneous(name, opto, base_start, base_end)

% load
load(name)

ts = [base_start opto base_end];
ts = sort(ts);

% make trials running from previous to next opto pulse
cfg = [];
cfg.trl(:,1) = ts(1:end-1);
cfg.trl(:,2) = ts(2:end);
cfg.trl(:,3) = zeros(length(ts)-1,1);
trialSel = cfg.trl(:,1)>=base_start & cfg.trl(:,2)<=base_end;
cfg.trl = cfg.trl(trialSel,:);

cfg.timestampspersecond = 10^6;
spike2 = ft_spike_maketrials(cfg, spike);

% take the baseline trials
nTrials = size(spike2.trialtime,1);
trialsSpontaneous = [1:nTrials];
times = spike2.trialtime(trialsSpontaneous,:);
endLatency = max(times(:,2));
begLatency = 0.05;

% compute the firing rate rate
cfg = [];
if length(trialsSpontaneous)>1
    cfg.trials = trialsSpontaneous;
end
cfg.latency = [begLatency endLatency];
cfg.keeptrials = 'yes';
rate = ft_spike_rate(cfg, spike2);



