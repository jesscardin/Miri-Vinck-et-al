function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 1;
MitraPaper_info
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
    normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'ratio_to_max', 'raw'};
     for k = 1:length(info)
        dirs{k} = info(k).directory;
    end
        
    for iNormalization = [3:4]%1:length(normalization_labels)
        n_rc = length(S.rc);
        for include_rc = 1%1:4%[1 3]%:4
            n_drugs = length(S.rc(include_rc).drug);
            for doPtz = 1%1:n_drugs              
                doPtz
                n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                for iComparison = 1%:n_comparisons
                    n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                    figure('Visible', 'off')
                    hd = []; str = []; modIndxAll = {}; neuronlabels = {};str_animals = [];
                    for iType = 1:n_types       
                       % 
                        sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                        sl = sl(:) & R.rate_base(:)>0.1;
                        if sum(sl)==0, continue,end

                        if iNormalization==1 || iNormalization==3
                            ratenorm = repmat(R.rate_base(sl),[1 size(R.rate_ictal,2)+1]);
                        elseif iNormalization==2 || iNormalization==4
                            ratenorm = repmat(R.rate_ictal(sl,1),[1 size(R.rate_ictal,2)+1]);
                        else
                            ratenorm = repmat(nanmax([R.rate_base(sl,1) R.rate_ictal(sl,:)],[],2),[1 size(R.rate_ictal,2)+1]);
                        end
                        dat = [R.rate_base(sl,1) R.rate_ictal(sl,:)];
                        if iNormalization<3      
                             modIndx = (dat - ratenorm) ./ (dat + ratenorm);
                        elseif iNormalization==3 || iNormalization==4
                             modIndx = (dat - ratenorm);
                        elseif iNormalization==5
                             modIndx = (dat./ratenorm);
                        elseif iNormalization==6
                            modIndx = dat;
                        end
                      %  
                        animals = dirs(sl);
                        animals(isnan(modIndx(:,1))) = [];
                        nAnimals = length(unique(animals));
                   %     keyboard
                        hold on
                        colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;                        
                        hd(iType)=errorbar(0:nIctalPeriods,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o-' colors{iType}]);
                        str = [str ' ' num2str(sum(~isnan(modIndx(:,1))))];
                        str_animals = [str_animals ' ' num2str(nAnimals)]; 
                     %            
                   %  keyboard
                        set(gca,'TickDir', 'out')
                        set(gca,'Box', 'off')
 %                       modIndxAll = [modIndxAll ; dat];
%                        neuronlabels = cat(1,neuronlabels,R.neurontype(sl)');
                        modIndxAll{iType} = modIndx
                    end
%                    keyboard
                    dofstr = str;
                     pvalR = ones(3,3); pvalT = ones(3,3); pvalR2 = ones(3,3); pvalT2 = ones(3,3);
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
                                try
                                    smp1 = modIndxAll{k}(:,end)-modIndxAll{k}(:,end-1);
                                    smp2 = modIndxAll{j}(:,end)-modIndxAll{j}(:,end-1);
                                catch
                                    smp1 = [];
                                    smp2 = [];
                                end
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
                    
                  pvalT_individual = []; pvalR_individual = [];
                     for k = 1:n_types                        
                         for iIctal = 1:size(modIndxAll{k},2)
                            try
                               smp1 = modIndxAll{k}(:,iIctal); 
                            catch
                                smp1 = [];
                            end

                            try
                                [H,pvalT_individual(k,iIctal)] = ttest(smp1);
                            catch
                                pvalT_individual(k,iIctal) = 1;
                            end
                            try
                                pvalR_individual(k,iIctal) = signrank(smp1);
                            catch
                                pvalR_individual(k,iIctal) = 1;
                            end
                         end
                     end

                    % pvalT_individual = []; pvalR_individual = [];
                     for k = 1:n_types                        
                         for iIctal = 1:size(modIndxAll{k},2)
                             for jIctal = 1:size(modIndxAll{k},2)
                             
                                try
                                   smp1 = modIndxAll{k}(:,iIctal)-modIndxAll{k}(:,jIctal);
                                end

                                try
                                    [H,pvalT_pairwise(k,iIctal,jIctal)] = ttest(smp1);
                                    [pvalR_pairwise(k,iIctal,jIctal),H] = signrank(smp1);                                    
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
                    set(gca, 'XTick', 0:nIctalPeriods);
                    label = get(gca,'XTickLabel');
                    label(1) = 'b';
                    set(gca, 'XTickLabel', label);
                    %root = (fullfile(figuredir_manuscript, 'rate_periods'));
                    %mkdir(root);
                    %filename = fullfile(root, [S.rc_label{include_rc} '__' S.rc(include_rc).drug_label{doPtz} ...
                    %    '__' S.rc(include_rc).drug(doPtz).comparison_label{iComparison} ...
                    %    normalization_labels{iNormalization} '_' num2str(nIctalPeriods)]);             
                    root = (fullfile(figuredir_manuscript, 'averagerate'));                    
                    directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                    S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison});
                    mkdir(directory_name);                        
                    filename = fullfile(directory_name, normalization_labels{iNormalization}); 
                    if doPublish==1
                        publish(filename, cfg)
                    end
                    
                     filenameTXT = [filename 'individual_TSTAT.txt'];
                    fid = fopen(filenameTXT,'wt');
                    for k = 1:size(pvalT_individual,1)
                        str = [];
                        for j = 1:size(pvalT_individual,2)
                            if j==1
                                str = sprintf('%2.4f', pvalT_individual(k,j));
                            else
                                str = sprintf('%s %2.4f', str, pvalT_individual(k,j)); 
                            end
                        end
                        fprintf(fid, '%s\n', str);
                    end
                    fclose(fid);

                    filenameTXT = [filename 'individual_RSTAT.txt'];
                    fid = fopen(filenameTXT,'wt');
                    for k = 1:size(pvalR_individual,1)
                        str = [];
                        for j = 1:size(pvalR_individual,2)
                            if j==1
                                str = sprintf('%2.4f', pvalR_individual(k,j));
                            else
                                str = sprintf('%s %2.4f', str, pvalR_individual(k,j)); 
                            end
                        end
                        fprintf(fid, '%s\n', str);
                    end
                    fclose(fid);

                    

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

                   % keyboard
                    for iType = 1:n_types
                        filenameTXT = [filename S.rc(include_rc).drug(doPtz).comparison(iComparison).label{iType}  'individual_pairwise_TSTAT.txt'];
                        fid = fopen(filenameTXT,'wt');
                        for k = 1:size(pvalT_pairwise,2)
                            str = [];
                            for j = 1:size(pvalT_pairwise,3)
                                if j==1
                                    str = sprintf('%2.4f', squeeze(pvalT_pairwise(iType,k,j)));
                                else
                                    str = sprintf('%s %2.4f', str, squeeze(pvalT_pairwise(iType,k,j))); 
                                end
                            end
                            fprintf(fid, '%s\n', str);
                        end
                        fclose(fid);
                    end    
                    
                     for iType = 1:n_types
                        filenameTXT = [filename S.rc(include_rc).drug(doPtz).comparison(iComparison).label{iType} 'individual_pairwise_RSTAT.txt'];
                        fid = fopen(filenameTXT,'wt');
                        for k = 1:size(pvalR_pairwise,2)
                            str = [];
                            for j = 1:size(pvalR_pairwise,3)
                                if j==1
                                    str = sprintf('%2.4f', pvalR_pairwise(iType,k,j));
                                else
                                    str = sprintf('%s %2.4f', str, pvalR_pairwise(iType,k,j)); 
                                end
                            end
                            fprintf(fid, '%s\n', str);
                        end
                        fclose(fid);
                    end    
            
                    filenamePDF = [filename '.pdf'];
                    saveas(gcf,filenamePDF)
                    filenamePDF = [filename '.jpeg'];
                    saveas(gcf,filenamePDF)
                     title(sprintf('df = %s\n df=%s\n last T: %1.3f %1.3f \n last R: %1.3f %1.3f \n last vs 2nd T %1.3f %1.3f \n last vs 2nd R %1.3f %1.3f', ...
                        dofstr,str_animals, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));
                % str_animals = [str_animals ' ' num2str(nAnimals)]; 
                    
                    filenamePDF = [filename '_LEGEND.jpeg'];
                    legend(hd, S.rc(include_rc).drug(doPtz).comparison(iComparison).label);
                    saveas(gcf,filenamePDF)
                end
                close all
            end
        end
    end                                                                              
end
