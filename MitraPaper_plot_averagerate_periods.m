function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 0;
global datadir_manuscript
global figuredir_manuscript
global info
for nIctalPeriods = 4
    str = ['averagerate_' num2str(nIctalPeriods)];
    filename = fullfile(datadir_manuscript, 'average_rates', str);
    load(filename, 'R');
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);

    S = MitraPaper_getselections(R,Stat,repor_cutoff);
    normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'ratio_to_max'};
%keyboard
    for k = 1:length(info)
        dirs{k} = info(k).directory;
    end

    for iNormalization = 1:length(normalization_labels)
        n_rc = length(S.rc);
        for include_rc = 1:4
            n_drugs = length(S.rc(include_rc).drug);
            for doPtz = 1:n_drugs              
                doPtz
                n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                for iComparison = 1:n_comparisons
                    n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                    figure('Visible', 'off')
                    hd = []; str = []; modIndxAll = {}; neuronlabels = {};
                    mn = []; sm = []; animal_str = [];
                    for iType = 1:n_types            
                        sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                        sl = sl(:);% & R.rate_base(:)>0.1;
                        if sum(sl)==0, continue,end
                        dat = [R.rate_base(sl,1)];
                        modIndx = dat;
                        hold on
                        
                        animals = dirs(sl);
                        animals(isnan(modIndx)) = [];
                        nAnimals = length(unique(animals));
                                                        
                        mn(iType) = nanmean(modIndx);
                        sm(iType) = nanstd(modIndx) ./ sqrt(length(modIndx));
                        str = [str ' ' num2str(sum(sl))];     
                        animal_str = [animal_str ' ' num2str(nAnimals)];
                        modIndxAll{iType} = dat;                            
                    end
                    if ~isempty(mn)
                        hd=barweb(mn(:),sm(:));
                    end
                    dofstr = str;
                     pvalR = ones(3,3); pvalT = ones(3,3);                     
                     n_types = length(modIndxAll);
                    for k = 1:n_types
                        for j = 1:n_types
                            for iIctal = size(modIndxAll{1},2)
                                try
                                    smp1 = modIndxAll{k}(:,iIctal);        
                                    smp2 = modIndxAll{j}(:,iIctal);
                                catch
                                    smp1 = [];
                                    smp2 = [];
                                end
                                    
                                try
                                    [H,pvalT(k,j)] = ttest2(smp1,smp2);
                                catch
                                    pvalT(k,j) = 1;
                                end
                                try
                                    pvalR(k,j) = ranksum(smp1,smp2);
                                catch
                                    pvalR(k,j) = 1;
                                end
                            end
                        end
                    end
                    
                    xlabel('ictal periods')
                    ylabel('rate')
                    %ylim([0 15])
                    set(gca, 'TickDir', 'out')
                    set(gca,'Box', 'off');
                    cfg.height = 2.2;
                    cfg.width = 2.2;
                %    set(gca, 'XTick', 0:nIctalPeriods);
                 %   label = get(gca,'XTickLabel');
                 %   label(1) = 'b';
                 %   set(gca, 'XTickLabel', label);
                 %   
                    root = (fullfile(figuredir_manuscript, 'averagebaserate'));                    
                    directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                    S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison});
                    mkdir(directory_name);                        
                    filename = fullfile(directory_name, 'baserate'); 
                    publish(filename, cfg)
                    
                    filenameTXT = [filename 'lastperiodTSTAT.txt'];
                    fid = fopen(filenameTXT,'wt');
                    for k = 1:size(pvalT,1)
                        str = [];
                        for j = 1:size(pvalT,2)
                            if j==1
                                str = sprintf('%2.4f', pvalT(k,j));
                            else
                                str = sprintf('%s %2.4f', str, pvalT(k,j)); 
                            end
                        end
                        fprintf(fid, '%s\n', str);
                    end
                    fclose(fid);
                    
                    filenameTXT = [filename 'lastperiodRANKSUM.txt'];
                    fid = fopen(filenameTXT,'wt');
                    for k = 1:size(pvalR,1)
                        str = [];
                        for j = 1:size(pvalR,2)
                            if j==1
                                str = sprintf('%2.4f', pvalR(k,j));
                            else
                                str = sprintf('%s %2.4f', str, pvalR(k,j)); 
                            end
                        end
                        fprintf(fid, '%s\n', str);
                    end
                    fclose(fid);
                                     
                 %    title(sprintf('df = %s\n last period Tstat: %1.3f %1.3f \n last period ranksum: %1.3f %1.3f \n last vs 2nd Tstat %1.3f %1.3f \n last vs 2nd Ranksum %1.3f %1.3f', ...
            %           str, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));

                    filenamePDF = [filename '.pdf'];
                    saveas(gcf,filenamePDF)
                    filenamePDF = [filename '.jpeg'];
                    saveas(gcf,filenamePDF)

                    label_str = [];
                    for k = 1:length(S.rc(include_rc).drug(doPtz).comparison(iComparison).label)
                        label_str = [label_str ' ' S.rc(include_rc).drug(doPtz).comparison(iComparison).label{k}];
                    end
                    
                    title(sprintf('df = %s\n df = %s\n, last T: %1.3f %1.3f \n last R: %1.3f %1.3f \n last vs 2nd T \n %s', ...
                        dofstr, animal_str, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3), label_str));
                 
                    filenamePDF = [filename '_LEGEND.jpeg'];
                   % legend(hd, S.rc(include_rc).drug(doPtz).comparison(iComparison).label);
                    saveas(gcf,filenamePDF)
                end
                close all
            end
        end
    end                                                                              
end
