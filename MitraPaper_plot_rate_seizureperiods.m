function [] = MitraPaper_plot_rate_seizureperiods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 0;
global datadir_manuscript
global figuredir_manuscript

for nIctalPeriods = 4
    str = ['averagerateseizure_stable_' num2str(nIctalPeriods)];
    filename = fullfile(datadir_manuscript, 'averagerateseizure_stable', str);
    load(filename, 'R');
    
    str = ['averagerate_' num2str(4)];
    filename = fullfile(datadir_manuscript, 'average_rates', str);
    inp2 = load(filename, 'R');
    
    R.rate_ictal = [inp2.R.rate_ictal(:,1:end) R.rate_ictal];
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);
    R.dur(end+1:length(R.neurontype)) = 0;
    S = MitraPaper_getselections(R,Stat,repor_cutoff);
    normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'ratio_to_max'};
   for dur = [10 20 40 60 80 100 120]
        for iNormalization = 3%:length(normalization_labels)
            iNormalization
            n_rc = length(S.rc);
            for include_rc = [1]
                n_drugs = length(S.rc(include_rc).drug);
                for doPtz = 1%1:n_drugs              
                    n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                    for iComparison = 1%1:n_comparisons
                        n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                        figure('Visible', 'off')
                        hd = []; str = []; modIndxAll = {}; neuronlabels = {};
                        for iType = 1:n_types                    
                            sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                            exclude = R.rate_ictal(:,end)>20 & R.rate_ictal(:,end-nIctalPeriods+1)>20;
                            
                            sl = sl(:) & R.rate_base(:)>0.1 & all(~isnan(R.rate_ictal),2) & R.dur(:)>=dur & ~exclude(:);
                            if sum(sl)==0, continue,end

                            if iNormalization==1 || iNormalization==3
                                ratenorm = repmat(R.rate_base(sl),[1 size(R.rate_ictal,2)+1]);
                            elseif iNormalization==2 || iNormalization==4
                                ratenorm = repmat(R.rate_ictal(sl,end-nIctalPeriods+1),[1 size(R.rate_ictal,2)+1]);
                            else
                                ratenorm = repmat(nanmax([R.rate_base(sl,1) R.rate_ictal(sl,:)],[],2),[1 size(R.rate_ictal,2)+1]);
                            end
                            dat = [R.rate_base(sl,1) R.rate_ictal(sl,:)];
                            
                            
                            
                            if iNormalization<3      
                                 modIndx = (dat - ratenorm) ./ (dat + ratenorm);
                            elseif iNormalization==3 || iNormalization==4
                                 modIndx = (dat - ratenorm);
                            else
                                 modIndx = (dat./ratenorm);
                            end

                            hold on
                            colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;                        
                            hd(iType)=errorbar(0:size(dat,2)-1,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o-' colors{iType}]);
                             str = [str ' ' num2str(sum(sl))];
                            %str = [str ' ' num2str(S.rc(include_rc).drug(doPtz).comparison(iComparison).n(iType))];
                           % keyboard
     %                       modIndxAll = [modIndxAll ; dat];
    %                        neuronlabels = cat(1,neuronlabels,R.neurontype(sl)');
                            modIndxAll{iType} = modIndx;
                        end
                        dofstr = str;
                         pvalR = ones(3,3); pvalT = ones(3,3); pvalR2 = ones(3,3); pvalT2 = ones(3,3);
                         n_types = length(modIndxAll);
                        for k = 1:n_types
                            for j = 1:n_types
                                for iIctal = size(modIndxAll{1},2)
                                    smp1 = modIndxAll{k}(:,iIctal);
                                    smp2 = modIndxAll{j}(:,iIctal);
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
                                    smp1 = modIndxAll{k}(:,end)-modIndxAll{k}(:,end-1);
                                    smp2 = modIndxAll{j}(:,end)-modIndxAll{j}(:,end-1);
                                    try
                                        pvalR2(k,j) = ranksum(smp1,smp2);
                                        [ignore,pvalT2(k,j)] = ttest2(smp1,smp2);                                    
                                    catch
                                        pvalR2(k,j) = 1;
                                        pvalT2(k,j) = 1;
                                    end
                                end
                            end
                        end

                        xlabel('ictal periods')
                        if iNormalization<3
                            ylabel('modulation (a-b)/(a+b) in firing rate')
                        elseif iNormalization==3 || iNormalization==4
                            ylabel('difference (a-b) in firing rate')
                        elseif iNormalization==5
                            ylabel('normalized relative to max')
                        end
                         cfg.height = 2.2;
                        cfg.width = 2.2;
                        set(gca, 'XTick', 0:size(dat,2)-1);
                        set(gca, 'XTickLabel', 0:size(dat,2)-1);

                        label = get(gca,'XTickLabel');
                        labelnew = {};
                        for k = 1:length(label)
                            labelnew{k} = label;
                        end
                        labelnew{1} = 'b';
                        for k = 2:size(dat,2)-nIctalPeriods
                            labelnew{k} = ['pr' label(k)];
                        end
                        cnt = 0;                    
                        for k = size(dat,2)-nIctalPeriods+1:size(dat,2)
                            cnt = cnt + 1;
                            labelnew{k} = ['ps' num2str(cnt)];
                        end

    %                     label(1) = 'b';
    %                     for k = 1:nIctalPeriods
    %                         label(end-k+1) = num2str(nIctalPeriods-k+1);
    %                     end
                        set(gca, 'XTickLabel', labelnew);
    %                     root = (fullfile(figuredir_manuscript, 'seizurerate_periods'));
    %                     mkdir(root);
    %                     filename = fullfile(root, [S.rc_label{include_rc} '__' S.rc(include_rc).drug_label{doPtz} ...
    %                         '__' S.rc(include_rc).drug(doPtz).comparison_label{iComparison} ...
    %                         normalization_labels{iNormalization} '_' num2str(nIctalPeriods)]);                        
    %                     publish(filename, cfg)
    %                        
                        root = (fullfile(figuredir_manuscript, 'seizurerate_periods'));                    
                        directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                        S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison}, num2str(dur));
                        mkdir(directory_name);                        
                        filename = fullfile(directory_name, normalization_labels{iNormalization});   
                        if doPublish==1
                            publish(filename, cfg)
                        end

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

                        filenameTXT = [filename 'last_vs_secondlastperiodRANKSUM.txt'];
                        fid = fopen(filenameTXT,'wt');
                        for k = 1:size(pvalR2,1)
                            str = [];
                            for j = 1:size(pvalR2,2)
                                if j==1
                                    str = sprintf('%2.4f', pvalR2(k,j));
                                else
                                    str = sprintf('%s %2.4f', str, pvalR2(k,j)); 
                                end
                            end
                            fprintf(fid, '%s\n', str);
                        end
                        fclose(fid);

                        filenameTXT = [filename 'last_vs_secondlastperiodTSTAT.txt'];
                        fid = fopen(filenameTXT,'wt');
                        for k = 1:size(pvalT2,1)
                            str = [];
                            for j = 1:size(pvalT2,2)
                                if j==1
                                    str = sprintf('%2.4f', pvalT2(k,j));
                                else
                                    str = sprintf('%s %2.4f', str, pvalT2(k,j)); 
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
                         title(sprintf('df = %s\n last T: %1.3f %1.3f \n last R: %1.3f %1.3f \n last vs 2nd T %1.3f %1.3f \n last vs 2nd R %1.3f %1.3f', ...
                            dofstr, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));

                        filenamePDF = [filename '_LEGEND.jpeg'];
                        legend(hd, S.rc(include_rc).drug(doPtz).comparison(iComparison).label);
                        saveas(gcf,filenamePDF)
                    end
                    close all
                end
            end
        end                                                                              
    end
end
