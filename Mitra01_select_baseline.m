function [spike2] = Mitra01_select_baseline(name, tbeg, tend,spike)

cfg = [];
if nargin<2
    cfg.trl = [0 inf 0];
else
    cfg.trl = [tbeg tend 0];
end
cfg.timestampspersecond = 10^6;
spike2 = ft_spike_maketrials(cfg, spike);

