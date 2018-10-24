function [isi, logratio] = Mitra01_isi_opto(name, bins,opto, nlevels,pulse_start, pulse_end)

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
trialsSpontaneous = find((spike2.trialtime(:,2)-spike2.trialtime(:,1))>2);%%[(pulse_start):nlevels:nTrials];
%trialsSpontaneous(end) = [];
%trialsSpontaneous(trialsSpontaneous==0) = [];

% determine the start and end latency
times = spike2.trialtime(trialsSpontaneous,:);
endLatency = median(times(:,2));
begLatency = 0.5;%0.05;
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