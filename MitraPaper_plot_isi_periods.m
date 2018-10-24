function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;

global datadir_manuscript
global figuredir_manuscript
global info 
for iMetric = 1:2%
    for nIctalPeriods = 4
        str = ['averageisi_' num2str(nIctalPeriods)];
        filename = fullfile(datadir_manuscript, 'averageisi', str);
        load(filename, 'R');

        str = ['averagerate_' num2str(nIctalPeriods)];
        filename = fullfile(datadir_manuscript, 'average_rates', str);
        inp2 = load(filename, 'R');

        str = ['waveform_parameters'];
        filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
        load(filename);
              
        for k = 1:length(info)
            dirs{k} = info(k).directory;
        end
        
        S = MitraPaper_getselections(R,Stat,repor_cutoff);
        normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'raw'};

        for iNormalization = 3:5%1:length(normalization_labels)
            n_rc = length(S.rc);
            for include_rc = 3%:4
                n_drugs = length(S.rc(include_rc).drug);
                for doPtz = 1:2%1:n_drugs              
                    n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                    for iComparison = 1:n_comparisons
                        n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                        figure('Visible', 'off')
                        hd = []; str = []; modIndxAll = {}; neuronlabels = {}; str_animals = [];
                        for iType = 1:n_types                    
                            sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                            
                            R.lv_base(R.lv_base==0 | ~isfinite(R.lv_base)) = NaN;
                            R.lv_ictal(R.lv_ictal==0 | ~isfinite(R.lv_ictal)) = NaN;
                            R.logratio_base(R.logratio_base==0 | ~isfinite(R.logratio_base)) = NaN;
                            R.logratio_ictal(R.logratio_ictal==0 | ~isfinite(R.logratio_ictal)) = NaN;

                            sl = sl(:) & inp2.R.rate_base(:)>0.1 & all(~isnan([R.logratio_base(:) R.logratio_ictal]),2);
                            if sum(sl)==0, continue,end

                            if iNormalization==1 || iNormalization==3
                                if iMetric==1
                                    ratenorm = repmat(R.logratio_base(sl)',[1 size(R.logratio_ictal,2)+1]);
                                elseif iMetric==2
                                    ratenorm = repmat(R.lv_base(sl),[1 size(R.lv_ictal,2)+1]);
                                end
                            elseif iNormalization==2 || iNormalization==4
                                if iMetric==1
                                    ratenorm = repmat(R.logratio_ictal(sl,1),[1 size(R.logratio_ictal,2)+1]);
                                elseif iMetric==2
                                    ratenorm = repmat(R.lv_ictal(sl,1),[1 size(R.lv_ictal,2)+1]);
                                end
                            end
                            if iMetric==1
                                dat = [R.logratio_base(sl)' R.logratio_ictal(sl,:)];
                            else
                                dat = [R.lv_base(sl) R.lv_ictal(sl,:)];
                            end
                            if iNormalization<3      
                                 modIndx = (dat - ratenorm) ./ (dat + ratenorm);
                            elseif iNormalization==3 || iNormalization==4
                                 modIndx = (dat - ratenorm);
                            else
                                modIndx = dat;
                            end
%keyboard
                            hold on
                            colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;                        
                            hd(iType)=errorbar(0:nIctalPeriods,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o-' colors{iType}]);
%                            str = [str ' ' num2str(S.rc(include_rc).drug(doPtz).comparison(iComparison).n(iType))];

                            animals = dirs(sl);
                            animals(isnan(R.logratio_base(sl))) = [];
                            nAnimals = length(unique(animals));
                            
                            str = [str ' ' num2str(sum(~isnan(modIndx(:,2))))];
                            str_animals = [str_animals ' ' num2str(nAnimals)]; 
                    


     %                       modIndxAll = [modIndxAll ; dat];
    %                        neuronlabels = cat(1,neuronlabels,R.neurontype(sl)');
                            modIndxAll{iType} = modIndx
                        end
                   %     keyboard
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
                            if iMetric==1
                                ylabel('modulation (a-b)/(a+b) in logratio')
                            else
                                ylabel('modulation (a-b)/(a+b) in lv')
                            end
                        elseif iNormalization==3 || iNormalization==4
                            if iMetric==1
                                ylabel('difference (a-b) in logratio')
                            else
                                ylabel('modulation (a-b) in lv')
                            end
                                
                        end
                         cfg.height = 2.2;
                        cfg.width = 2.42;
                        set(gca, 'XTick', 0:nIctalPeriods);
                        label = get(gca,'XTickLabel');
                        label(1) = 'b';
                        set(gca, 'XTickLabel', label);
                        set(gca,'TickDir', 'out')
                        set(gca,'Box', 'off')
                        if iMetric==1
                            root = (fullfile(figuredir_manuscript, 'logratio_periods'));
                        else
                            root = (fullfile(figuredir_manuscript, 'lv_periods'));
                        end                           
                        mkdir(root);
                        title(sprintf('df = %s', str));
                        directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                            S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison});
                        mkdir(directory_name);                        
                        filename = fullfile(directory_name, normalization_labels{iNormalization});
                        publish(filename, cfg)

                        
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
                        title(sprintf('df = %s\n df = %s\n last T: %1.3f %1.3f \n last R: %1.3f %1.3f \n last vs 2nd T %1.3f %1.3f \n last vs 2nd R %1.3f %1.3f', ...
                        dofstr, str_animals, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));
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