function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 1;
global datadir_manuscript
global figuredir_manuscript

for nIctalPeriods = 4
    str = ['averagerate_' num2str(nIctalPeriods)];
    filename = fullfile(datadir_manuscript, 'average_rates', str);
    load(filename, 'R');
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);

    S = MitraPaper_getselections(R,Stat,repor_cutoff);
    normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'ratio_to_max'};
        
    str = ['rates_over_time_'];
    filename = fullfile(datadir_manuscript, 'rates_over_time', str);
    inp2 = load(filename, 'R');
        for iNormalization = 1:length(normalization_labels)
            n_rc = length(S.rc);
            for include_rc = 3
                n_drugs = length(S.rc(include_rc).drug);
                for doPtz = 1%:n_drugs              
                    doPtz
                    n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
                    for iComparison = 1%:n_comparisons
                        n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                        for iType = 1:n_types
                           
                        figure('Visible', 'off')
                        
                        hd = []; str = []; modIndxAll = {}; neuronlabels = {};
                        for iLat = 1:2                    
                            if iLat==1
                                sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                                slo = sl(:) & R.rate_base(:)>0.1;

                                A = inp2.R.avAll(:,:);
                                lat = inp2.R.latency;
%                                 lat = [];
%                                 for k = 1:size(A,1)        
%                                     sl = find(~isnan(A(k,:)),1,'first');
%                                     if ~isempty(sl)
%                                         lat(k) = inp2.R.time(sl);
%                                     else
%                                         lat(k) = NaN;
%                                     end
%                                 end
                              %  lat = lat + rand(1,length(lat));
                                sl = slo(:) & -lat(:)>-300*10^6%median(lat(slo(:)));
                            else
                                sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                                slo = sl(:) & R.rate_base(:)>0.1;
                                lat = inp2.R.latency;

                                A = inp2.R.avAll(:,:);
%                                 lat = [];
%                                 for k = 1:size(A,1)        
%                                     sl = find(~isnan(A(k,:)),1,'first');
%                                     if ~isempty(sl)
%                                         lat(k) = inp2.R.time(sl);
%                                     else
%                                         lat(k) = NaN;
%                                     end
%                                 end
                              %  lat = lat + rand(1,length(lat));                                
                                sl = slo(:) & -lat(:)<=-300*10^6%median(lat(slo(:)));
                            end
%keyboard
                       
                            %keyboard
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
                            else
                                 modIndx = (dat./ratenorm);
                            end

                            hold on
                            colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;  
                            if iLat==1
                                hd(iType)=errorbar(0:nIctalPeriods,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o--' colors{iType}]);
                            else
                                hd(iType)=errorbar(0:nIctalPeriods,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['d-' colors{iType}]);
                            end                                
                                
                            str = [str ' ' num2str(sum(sl))];
                            avglatency(iLat) = nanmean(lat(sl(:))/1000000);
                            modIndxAll{iType} = modIndx;
                        end
                        dofstr = str;
                      
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
                        ylim([-2 8])
                        %root = (fullfile(figuredir_manuscript, 'rate_periods'));
                        %mkdir(root);
                        %filename = fullfile(root, [S.rc_label{include_rc} '__' S.rc(include_rc).drug_label{doPtz} ...
                        %    '__' S.rc(include_rc).drug(doPtz).comparison_label{iComparison} ...
                        %    normalization_labels{iNormalization} '_' num2str(nIctalPeriods)]);             
                        root = (fullfile(figuredir_manuscript, 'averagerate'));                    
                        directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                        S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison}, S.rc(include_rc).drug(doPtz).comparison(iComparison).label{iType});
                        mkdir(directory_name);                        
                        filename = fullfile(directory_name, normalization_labels{iNormalization}); 
                        if doPublish==1
                            publish(filename, cfg)
                        end

                      
                         title(sprintf('df = %s\n latShort = %2.2f,latLong=%2.2f', str, avglatency(1),avglatency(2)));
                %           str, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));

                        filenamePDF = [filename '.pdf'];
                        saveas(gcf,filenamePDF)
                        filenamePDF = [filename '.jpeg'];
                        saveas(gcf,filenamePDF)
                         title(sprintf('df = %s\n', ...
                            dofstr));

                        filenamePDF = [filename '_LEGEND.jpeg'];
                        %legend(hd, S.rc(include_rc).drug(doPtz).comparison(iComparison).label);
                        saveas(gcf,filenamePDF)
                        
                             global info
                            rc_indx           = false(length(info),1);
                            for ii = 1:length(info)
                                rc_indx(ii) = info(ii).has_rc;
                            end    
                            ptzsel = true(length(rc_indx),1);   
                            ptzsel([1:139 163:length(info)]) = false;
                            sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                            figure, hist(lat(~ptzsel)/1000000,20)
                            root = (fullfile(figuredir_manuscript, 'averagerate'));                    
                            directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
                            S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison}, S.rc(include_rc).drug(doPtz).comparison(iComparison).label{iType});
                            mkdir(directory_name);                        
                            filename = fullfile(directory_name, 'hist_latencies'); 
                            title(sprintf('mean = %3.3f, sem = %3.3f', nanmean(lat(~ptzsel)/1000000), nanstd(lat(~ptzsel)/1000000)./sqrt(sum(ptzsel))));
                            cfg.height = 2.2;
                            cfg.width  = 2.2;
                            publish(filename,cfg)
                            
                    end
                    close all
                end
            end
        end                                                                             
    end
end
