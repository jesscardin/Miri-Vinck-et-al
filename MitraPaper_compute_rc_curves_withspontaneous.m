function [R] = MitraPaper_compute_rc_curves(nIctalPeriods,bins)
%%
global info
global datadir_manuscript
nFiles = length(info);
celltype = {};

repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 0;
global datadir_manuscript
global figuredir_manuscript
    
str = ['waveform_parameters'];
filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
load(filename);
    
clear rate_base
binsizes = [0.005 0.01];
for iBin = 1
    bins = -0.25:binsizes(iBin):0.25;
    nBins = length(bins)-1;
    avg_all_base = NaN(length(info),16,nBins);    
    clear R
    for iFile = 1:nFiles
        iFile
        if info(iFile).has_rc==0 %|| ~strcmp(info(iFile).neuron_type, 'RS')

            % read in the opto files 
            fieldSelection = ones(1,5);    
            extractHeader  = 1;
            try
                [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
            catch
                TimeStamp = [];
            end

            % if there are no pulses, compute the rat in the regular way
            if length(TimeStamp)>2
                 info(iFile).nlevels = 1;
                 iLevel = 1;
                 base_start_pulse = 1;
                 base_end_pulse   = nearest(TimeStamp, info(iFile).injection_start);
                 [psth_base(iFile).level(iLevel),intens(iLevel)] = MitraPaper_rate_psth_rc(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse,iLevel,squeeze(data(1,1,:)),binsizes(iBin),[-0.25 0.25]);
            end                        
        else % write something new that produces the same stuff for RC
            fieldSelection = ones(1,5);    
            extractHeader  = 1;
            [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);

            intens = [];
            for iLevel = 1:info(iFile).nlevels
                [psth_base(iFile).level(iLevel),intens(iLevel)] = MitraPaper_rate_psth_rc(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse,iLevel,squeeze(data(1,1,:)),binsizes(iBin),[-0.25 0.25]);
            end
        end

        if ~isempty(info(iFile).exclude_rc_numlevels) & ~strcmp(info(iFile).neuron_type,'RS')
            if info(iFile).exclude_rc_numlevels ==0
                psth_indx = info(iFile).nlevels;
            elseif info(iFile).exclude_rc_numlevels ==1
                psth_indx = info(iFile).nlevels - 1;
            elseif info(iFile).exclude_rc_numlevels ==2
                psth_indx = info(iFile).nlevels - 2;
            end
        else
            psth_indx = info(iFile).nlevels;
        end

      %  info(iFile)
%        Stat.repor(iFile)
     %   Stat.p2t(iFile)


        if length(psth_base)==iFile
            A = cat(1,psth_base(iFile).level(:).avg);
            A = A(1:psth_indx,:);
            avg_all_base(iFile,1:size(A,1),:) = A;
            A
        end    
        cre{iFile} = info(iFile).cre;
        celltype{iFile} = info(iFile).neuron_type;       
    end
    R.celltype      = celltype;
    R.cre           = cre;
    R.avg_all_base  = avg_all_base;
    str = ['psth_rc_spontaneous' num2str(iBin)];
    root = fullfile(datadir_manuscript, 'psth_rc_spontaneous');
    mkdir(root);
    filename = fullfile(root, str);
    save(filename, 'R');
end

