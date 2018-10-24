function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 1;
global datadir_manuscript
global figuredir_manuscript
global info
for nIctalPeriods = [4]

    str = ['rc_' num2str(nIctalPeriods)];
    filename = fullfile(datadir_manuscript, 'rc', str);
    load(filename, 'R');

    str = ['averagerate_' num2str(4)];
    filename = fullfile(datadir_manuscript, 'average_rates', str);
    inp2 = load(filename, 'R');

    for k = 1:length(info)
        dirs{k} = info(k).directory;
    end

 %   str = ['averagerate_' num2str(nIctalPeriods)];
 %   filename = fullfile(datadir_manuscript, 'average_rates', str);
 %   inp3 = load(filename, 'R');
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);
    
    for k = 1:length(info)
        R.neurontype{k}  = info(k).neuron_type;
    end
        
    [a,b,c] = unique(R.neurontype);
    R.neurontype_label = a;
    R.neurontype_indx  = c;
    Stat.repor(168:197) = -1;         
   
    S = MitraPaper_getselections(R,Stat,repor_cutoff);
    for k = 1:3
        bigN(k) = length(unique(dirs(S(1).rc(1).drug(3).comparison(1).selection_indx{k})));
        smallN(k) = length(S(1).rc(1).drug(3).comparison(1).selection_indx{k});
    end
    
    bigN_ui = length(unique(dirs(S(1).rc(1).drug(3).comparison(2).selection_logical{1} | S(1).rc(1).drug(3).comparison(2).selection_logical{2})));
    smallN_ui = sum(S(1).rc(1).drug(3).comparison(2).selection_logical{1} | S(1).rc(1).drug(3).comparison(2).selection_logical{2});

    S = MitraPaper_getselections_rc(R,Stat,repor_cutoff);
    normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'raw'};

    metrics = {'dynamic_range', 'RMax', 'c50', 'slope'};
    for iMetric = [2 3 4]
        for iNormalization = [1 3]%1:length(normalization_labels)
            n_rc = length(S.rc);
            for include_rc = 1
                n_drugs = length(S.rc(include_rc).drug);
                for doPtz = 1              
                    n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                    for iComparison = [7]%^1:n_comparisons
                        n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                                                    figure
                         hd = []; str = []; modIndxAll = {}; neuronlabels = {};str_animals = [];
                        figure
                        set(gcf,'Visible', 'off')                        
                        for iType = 1:n_types  
                                                  
                     %       keyboard
                            sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                            sl = sl(:) & any(~isnan(R.coeffs_base),2);
                            if sum(sl)==0, continue,end
%keyboard
                            if iMetric==1
                                dRangeBase = R.coeffs_base(:,7) - R.coeffs_base(:,6);
                                dRangeIctal = R.coeffs_ictal(:,:,7) - R.coeffs_ictal(:,:,6);
                            elseif iMetric==2
                                dRangeBase = R.coeffs_base(:,7);
                                dRangeIctal = R.coeffs_ictal(:,:,7);
                            elseif iMetric==3
                                dRangeBase = R.coeffs_base(:,5);
                                dRangeIctal = R.coeffs_ictal(:,:,5);
                            elseif iMetric==4                               
                                dRangeBase = 1./R.coeffs_base(:,4);
                                dRangeIctal = 1./R.coeffs_ictal(:,:,4);
                            end                                

                            if iNormalization==1 || iNormalization==3
                                ratenorm = repmat(dRangeBase(:),[1 size(dRangeIctal,2)+1]);
                            elseif iNormalization==2 || iNormalization==4
                                ratenorm = repmat(dRangeIctal(:,1),[1 size(dRangeIctal,2)+1]);
                            end
                            dat = [dRangeBase dRangeIctal];
                            if iNormalization<3      
                                 modIndx = (dat - ratenorm) ./ (dat + ratenorm);
                            elseif iNormalization==3 || iNormalization==4
                                 modIndx = (dat - ratenorm);
                            elseif iNormalization==5
                                 modIndx = (dat);
                            end                                
                              
                            animals = dirs(sl);
                            animals(isnan(modIndx(sl,1))) = [];
                            nAnimals = length(unique(animals));                            
                          %  keyboard
                            modIndx = modIndx(sl,:);
                            nanmean(modIndx,1)
                            hold on
                            colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;                        
                            hd(iType)=errorbar(0:nIctalPeriods+2,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o-' colors{iType}]);
                            str = [str ' ' num2str(sum(~isnan(modIndx(:,1))))];
                            str_animals = [str_animals ' ' num2str(nAnimals)]; 
                            modIndxAll{iType} = modIndx;
                          %  keyboard
%                             figure(5+iType), 
%                             hold on, 
%                             plot(inp2.R.rate_base(sl),dat(sl,5)-dat(sl,2),[colors{iType} 'o'])
%                             title(num2str(iType))
%                             [rho,pval]= corr(inp2.R.rate_base(sl & ~isnan(inp2.R.rate_base)),dat(sl& ~isnan(inp2.R.rate_base),2)-dat(sl& ~isnan(inp2.R.rate_base),5),'Type', 'Spearman')
%                             
%                             figure(10+iType), 
%                             hold on, 
%                             plot(inp2.R.rate_ictal(sl,4)-inp2.R.rate_ictal(sl,1),dat(sl,5)-dat(sl,2),[colors{iType} 'o'])
%                          %  title(num2str(iType))
%                             [rho,pval]= corr(inp2.R.rate_ictal(sl& ~isnan(inp2.R.rate_base),4)-inp2.R.rate_ictal(sl& ~isnan(inp2.R.rate_base),1),dat(sl& ~isnan(inp2.R.rate_base),5)-dat(sl& ~isnan(inp2.R.rate_base),2),'Type', 'Spearman')
%                             
%                             keyboard
                          %  keyboard
                        end
                        dofstr = str;
                         pvalR = ones(3,3); pvalT = ones(3,3); pvalR2 = ones(3,3); pvalT2 = ones(3,3);
                         pvalR_individual = ones(1,3); pvalT_individual = ones(1,3);
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
                                    
                                      try
                                        [H,pvalT_individual(k)] = ttest(smp1);
                                    catch
                                        pvalT_individual(k) = 1;
                                    end
                                    try
                                        pvalR_individual(k) = signrank(smp1);
                                    catch
                                        pvalR_individual(k) = 1;
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
                         
                        
                         for iIctal = 1:size(modIndxAll{1},2)
                            try
                               smp1 = modIndxAll{1}(:,iIctal);
                               smp2 = modIndxAll{2}(:,iIctal); 
                               
                            catch
                                smp1 = [];
                            end

                            try
                                [H,pvalT_types(iIctal)] = ttest2(smp1,smp2);
                            catch
                                pvalT_types(iIctal) = 1;
                            end
                            try
                                pvalR_types(iIctal) = ranksum(smp1,smp2);
                            catch
                                pvalR_types(iIctal) = 1;
                            end
                         end

                        xlabel('ictal periods')
                        if iNormalization<3
                            ylabel('modulation (a-b)/(a+b)')
                        elseif iNormalization==3 || iNormalization==4
                            ylabel('difference (a-b)')
                        end
                         cfg.height = 2.2;
                        cfg.width = 2.2;
                        set(gca, 'XTick', 0:nIctalPeriods);
                        label = get(gca,'XTickLabel');
                        label(1) = 'b';
                        set(gca, 'XTickLabel', label);

                        root = (fullfile(figuredir_manuscript, 'rc_curves'));
                        mkdir(root);
                        title(sprintf('df = %s', str));
                        directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                            S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison}, metrics{iMetric});
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
                    
                      filenameTXT = [filename 'types_RSTAT.txt'];
                    fid = fopen(filenameTXT,'wt');
                    for k = 1:length(pvalR_types)
                        str = [];
                        str = sprintf('%2.6f', pvalR_types(k));
                        fprintf(fid, '%s\n', str);
                    end
                    fclose(fid);
                    
                    
                        filenamePDF = [filename '.pdf'];
                        saveas(gcf,filenamePDF)
                        filenamePDF = [filename '.jpeg'];
                        saveas(gcf,filenamePDF)
                        title(sprintf('df = %s\n df = %s\n last T: %1.3f %1.3f \n last R: %1.3f %1.3f \n last vs 2nd T %1.3f %1.3f \n last vs 2nd R %1.3f %1.3f \n pvalT %1.3f %1.3f %1.3f\n pval R %1.3f %1.3f %1.3f', ...
                        dofstr, str_animals,pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3), ...
                        pvalT_individual(1),pvalT_individual(2),pvalT_individual(3), pvalR_individual(1), pvalR_individual(2), pvalR_individual(3)));
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
