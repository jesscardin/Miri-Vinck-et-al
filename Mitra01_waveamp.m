function [rate, spike2] = Mitra01_isi(name, tbeg, tend,toffset)

if nargin<4,
    toffset = 0;
end
load(name)
cfg = [];
if nargin<2
    cfg.trl = [0 inf toffset];
else
    cfg.trl = [tbeg tend toffset];
end
cfg.timestampspersecond = 10^6;
spike2 = ft_spike_maketrials(cfg, spike);   

cfg = [];
rate = ft_spike_rate(cfg, spike2);

meanAmp = squeeze( nanmean( nanmean(spike2.waveform{1}(:,:,:),1)  ,3 ) );
meanAmp = nanmean(nanmax(meanAmp,[],1),2);
rate.avg = meanAmp;