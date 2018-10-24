function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 1;
global datadir_manuscript
global figuredir_manuscript

for nIctalPeriods = 4
    str = ['sts'];
    filename = fullfile(datadir_manuscript, 'sts', str);
    load(filename, 'R');
        
    str = ['averagerate_' num2str(nIctalPeriods)];
    filename = fullfile(datadir_manuscript, 'average_rates', str);
    inp2 = load(filename, 'R');
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);
%keyboard
    inp2.R.rate_base = inp2.R.rate_base(1:167);
    inp2.R.rate_ictal = inp2.R.rate_ictal(1:167);
    inp2.R.neurontype = inp2.R.neurontype(1:167);
    inp2.R.neurontype_indx = inp2.R.neurontype_indx(1:167);
    
    S = MitraPaper_getselections(inp2.R,Stat,repor_cutoff);
    normalization_labels = {'diff_to_base', 'diff_to_ictal', 'raw'};
        
    for iNormalization = [1 3]%1:length(normalization_labels)
        n_rc = length(S.rc);
        for include_rc = [1]
            n_drugs = length(S.rc(include_rc).drug);
            for doPtz = 1%:n_drugs              
                doPtz
                n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                for iComparison = 1%:n_comparisons
                    n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                   % figure('Visible', 'off')
                    hd = []; str = []; modIndxAll = {}; neuronlabels = {};
                    for iType = 1:n_types                    
                        sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                        sl = sl(:) & inp2.R.rate_base(:)>0.1;
                        sl = sl(1:length(R.neurontype));
                        if sum(sl)==0, continue,end
                        tmp = []; nspikes = [];
                        for iIctal = 1:nIctalPeriods+1
                            for iUnit = 1:size(R.stat_hf_all,1)
                                if ~isempty(R.stat_hf_all(iUnit,iIctal).ppc0)
                                    tmp(iIctal,iUnit,:) = cat(1,R.stat_hf_all(iUnit,iIctal).ppc0);
                                end
                            end
                        end
                        dof = [];
                        for iUnit = 1:size(R.stat_hf_all,1)
                            if ~isempty(R.stat_hf_all(iUnit,iIctal).nspikes)
                                dof(iUnit) = R.stat_hf_all(iUnit,iIctal).nspikes(1);
                            end
                        end
                        tmp(~isfinite(tmp) | tmp==0 ) = NaN;
                  %      keyboard
                        tmp(:,dof<50,:) = NaN;
                      %  keyboard
                        if iNormalization==1 
                            ratenorm = repmat(tmp(1,sl,:),[nIctalPeriods+1 1 1]);
                        elseif iNormalization==2 
                            ratenorm = repmat(tmp(2,sl,:),[nIctalPeriods+1 1 1]);
                        else
                            ratenorm = 0;
                        end
                        dat = tmp(:,sl,:);
                        modIndx = (dat - ratenorm);% ./ (dat + ratenorm);
                        freq = R.stat_hf_all(1,1).freq;
                     %   keyboard
                        dof = sum(~isnan(modIndx(1,:,10)));
%                        modIndx = 
                        mn = squeeze(nanmean(modIndx(:,:,:),2));
                        sm = squeeze(nanstd(modIndx(:,:,:),1,2))./sqrt(dof);
                        cors = {'k', 'r', 'g', 'c', 'b'};
                     %   keyboard
                   %  keyboard
                        figure('Visible', 'off')
                        for iIctalPeriod = 1:5
                            hold on
                            plotmeansem(freq,mn(iIctalPeriod,:),sm(iIctalPeriod,:),sm(iIctalPeriod,:),[cors{iIctalPeriod} '-'],[cors{iIctalPeriod} '--'])  
                        end
                       % keyboard
                        
                        for iF = 1:3
                            if iF==1
                                nr = nearest(freq,8);
                            elseif iF==2
                                nr = nearest(freq,24);
                            else
                                nr = nearest(freq,40):nearest(freq,90);
                            end
                            
                            for iIctalPeriod = 1:5
                                try    
                                    pvalue(iIctalPeriod) = signrank(nanmean(modIndx(iIctalPeriod,:,nr),3));
                                catch
                                    pvalue(iIctalPeriod) = NaN;
                                end
                            end
                            % keyboard
                     %       hold on
                     %       colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;                        
                    %        hd(iType)=errorbar(0:nIctalPeriods,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o-' colors{iType}]);
                     %       str = [str ' ' num2str(sum(sl))];
                         %                       modIndxAll = [modIndxAll ; dat];
    %                        neuronlabels = cat(1,neuronlabels,R.neurontype(sl)');
                     %       modIndxAll{iType} = modIndx

                            xlabel('ictal periods')
                            if iNormalization==1 
                                ylabel('difference (a-b) in locking to base')
                            elseif iNormalization==2
                                ylabel('difference (a-b) in locking to ictal')
                            elseif iNormalization==3
                                ylabel('raw locking')
                            end
                            cfg.height = 2.2;
                            cfg.width = 2.2;
                            root = (fullfile(figuredir_manuscript, 'locking'));                    
                            directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                            S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison},...
                            S.rc(include_rc).drug(doPtz).comparison(iComparison).label{iType});
                            mkdir(directory_name);                        
                            filename = fullfile(directory_name, normalization_labels{iNormalization}); 
                            if doPublish==1
                                publish(filename, cfg)
                            end

                         %    title(sprintf('df = %s\n last period Tstat: %1.3f %1.3f \n last period ranksum: %1.3f %1.3f \n last vs 2nd Tstat %1.3f %1.3f \n last vs 2nd Ranksum %1.3f %1.3f', ...
                    %           str, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));

                            filenamePDF = [filename '.pdf'];
                            saveas(gcf,filenamePDF)
                            filenamePDF = [filename '.jpeg'];
                            saveas(gcf,filenamePDF)
                            dofstr = dof;
                             title(sprintf('df = %s\n %.2f %.2f %.2f %.2f %.2f', ...
                                dofstr,pvalue(1),pvalue(2),pvalue(3),pvalue(4),pvalue(5)));

                            filenamePDF = [filename '_' num2str(iF) '_LEGEND.jpeg'];
                            legend(hd, S.rc(include_rc).drug(doPtz).comparison(iComparison).label);
                            saveas(gcf,filenamePDF)
                         %   keyboard

                            root = (fullfile(figuredir_manuscript, 'locking'));                    
                            directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                            S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison},...
                            S.rc(include_rc).drug(doPtz).comparison(iComparison).label{iType});
                            mkdir(directory_name);                        
                            filename = fullfile(directory_name, ['errorbars_' normalization_labels{iNormalization} '_' num2str(iF)]); 

                             figure('Visible', 'on')
                              hold on
                              
                              mn = squeeze( nanmean (nanmean(modIndx(:,:,nr),3), 2));
                              sm = squeeze(nanstd(  nanmean( modIndx(:,:,nr) ,3) ,1,2))./sqrt(dof);
                              cors = {'k', 'r', 'g', 'c', 'b'};
                  
                              hd = errorbar(1:nIctalPeriods+1,mn(:,:)',sm(:,:)')  
                              set(hd,'Color', S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label{iType})
                              ylim([-0.05 0.05])

                               if doPublish==1
                                publish(filename, cfg)
                               end
                           end
                        end
                    end
                end
                close all
            end
        end
    end                                                                              
end
