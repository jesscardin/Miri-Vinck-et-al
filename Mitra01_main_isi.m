 function [R] = Mitra01_main_isi(nIctalPeriods,bins)

if nargin<2
    bins = 0:0.002:1;
end
Mitra01_info;
global info

nFiles = length(info);
%[isi_base, logratio_base, rate_base, isi_ictal, logratio_base, rate_ictal, isi_seizure, logratio_seizure, rate_seizure] = deal([]);
celltype = {};
for iFile = 1:nFiles
    
    % first the baseline
    [isi_base(iFile),logratio_base(iFile)] = Mitra01_isi(fullfile(info(iFile).directory, info(iFile).name), bins, info(iFile).base_start, info(iFile).base_end);
    [rate_base(iFile)] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), info(iFile).base_start, info(iFile).base_end);

    % ictal periods
    ts1 = info(iFile).injection_start;
    ts2 = info(iFile).seizure_onset;    
    ts  = linspace(ts1, ts2, nIctalPeriods+1);    
    for iIctalPeriod = 1:nIctalPeriods
        [isi_ictal(iFile,iIctalPeriod),logratio_ictal(iFile,iIctalPeriod)] = ...
            Mitra01_isi(fullfile(info(iFile).directory, info(iFile).name), bins, ts(iIctalPeriod), ts(iIctalPeriod+1));
        
         [rate_ictal(iFile,iIctalPeriod)] = ...
         Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts(iIctalPeriod), ts(iIctalPeriod+1));

    end
   
    % seizure
    ts1 = info(iFile).seizure_onset;    
    tsEnd = ts1 + 30*10^6;
    [isi_seizure(iFile),logratio_seizure(iFile)] = Mitra01_isi(fullfile(info(iFile).directory, info(iFile).name), bins, ts1, tsEnd);    
    [rate_seizure(iFile)] = Mitra01_rate(fullfile(info(iFile).directory, info(iFile).name), ts1, tsEnd);    
    
    celltype{iFile} = info(iFile).neuron_type;
end

% concatenate all the data and give it back as a result structure
R.rate_base = cat(1,rate_base(:).avg);
R.isi_base  = cat(1,isi_base(:).avg);
R.lv_base   = cat(1,isi_base(:).lv);
R.logratio_base = logratio_base;
R.isi_ictal = [];
for ii = 1:nIctalPeriods
    R.isi_ictal(:,:,ii) = cat(1,isi_ictal(:,ii).avg);
    R.lv_ictal(:,ii)    = cat(1,isi_ictal(:,ii).lv);
    R.rate_ictal(:,ii)  = cat(1,rate_ictal(:,ii).avg);
end
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


    
    



