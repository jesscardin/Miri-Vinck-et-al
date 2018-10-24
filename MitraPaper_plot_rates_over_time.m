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
    inp2 = load(filename, 'R');
        
    str = ['rates_over_time_'];
    filename = fullfile(datadir_manuscript, 'rates_over_time', str);
    load(filename, 'R');
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);

    S = MitraPaper_getselections(R,Stat,repor_cutoff);
        
    n_rc = length(S.rc);
    for include_rc = 3%1:4
        n_drugs = length(S.rc(include_rc).drug);
        for doPtz = 1%:n_drugs              
            doPtz
            n_comparisons = length(S.rc(include_rc).drug(doPtz).comparison);
            for iComparison = 1:n_comparisons
                n_types = length(S.rc(include_rc).drug(doPtz).comparison(iComparison).n);
                figure('Visible', 'off')
                hd = []; str = []; modIndxAll = {}; neuronlabels = {};
                for iType = 1:n_types                    
                    sl = S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical{iType};
                    sl = sl(:) & inp2.R.rate_base(:)>0.1;
                    if sum(sl)==0, continue,end
                    
                    A = R.avAll;
                   lat = R.latency;

                    %lat(nanmean(psth.trial,3)<0.3) = NaN;
                   % lat(rc==1) = NaN;
                          mx = nanmax(A,[],2);
                     for k = 1:size(A,1)
                         A(k,:) = ((A(k,:)) - inp2.R.rate_ictal(k,1))./((A(k,:)) + inp2.R.rate_ictal(k,1));%./mx(k);
                     end
                     
                   %  keyboard
                     mod = (inp2.R.rate_ictal - repmat(inp2.R.rate_ictal(:,1),[1 4])) ./ (inp2.R.rate_ictal + repmat(inp2.R.rate_ictal(:,1),[1 4]));                   
                     tmp = mod(sl,:);
                     [val,indx] = sort(tmp(:,4));
                     figure, 
                     subplot(1,2,1)
                     tmp = A(sl,:);
                     
                     imagesc(R.time,1:size(A(sl,:),1),tmp(indx,:))
                     colorbar
                     subplot(1,2,2)
                     mod = (inp2.R.rate_ictal - repmat(inp2.R.rate_ictal(:,1),[1 4])) ./ (inp2.R.rate_ictal + repmat(inp2.R.rate_ictal(:,1),[1 4]));
                     tmp = mod(sl,:);
                     imagesc(tmp(indx,:))
                     colorbar
                     
%                     sl1 = lat>-300;                                        
%                     figure,
%                     plotmeansem(psth.time, nanmean(A(sl1,:),1), nansem(A(sl1,:),1), nansem(A(sl1,:),1),'g-', 'g--')
%                     xlim([-300 -50])
%                     sl1 = lat<-300;
%                     figure,
%                     plotmeansem(psth.time, nanmean(A(sl1,:),1), nansem(A(sl1,:),1), nansem(A(sl1,:),1),'g-', 'g--')
%                     xlim([-600 -50])
                    lat = -lat/1000000;
                    sl1 = lat(:)>-300 & sl(:);
                    figure,
                    plotmeansem(R.time, nanmean(A(sl1,:),1), nansem(A(sl1,:),1), nansem(A(sl1,:),1),'g-', 'g--')
                    xlim([-300 -50])
                    sl1 = lat(:)<-300 & sl(:);
                    figure
                    hold on
                    plotmeansem(R.time, nanmean(A(sl1,:),1), nansem(A(sl1,:),1), nansem(A(sl1,:),1),'r-', 'r--')
                    xlim([-500 -50])
keyboard
                    %sl1 = lat>-300;
           %        mnAll(iType) = nanmean(Rall);
           %        smAll(iType) = nansem(Rall,2);                                                                                                                                                               
                end
                  root = (fullfile(figuredir_manuscript, 'rates_over_time'));                    
%                 directory_name = fullfile(root, S.rc_label{include_rc}, num2str(nIctalPeriods), ...
%                 S.rc(include_rc).drug_label{doPtz}, S.rc(include_rc).drug(doPtz).comparison_label{iComparison});
%                 mkdir(directory_name);                        
%                 filename = fullfile(directory_name, normalization_labels{iNormalization}); 
%                 if doPublish==1
%                     publish(filename, cfg)
%                 end
% 
%                 filenamePDF = [filename '.pdf'];
%                 saveas(gcf,filenamePDF)
%                 filenamePDF = [filename '.jpeg'];
%                 saveas(gcf,filenamePDF)
%              %    title(sprintf('df = %s\n last T: %1.3f %1.3f \n last R: %1.3f %1.3f \n last vs 2nd T %1.3f %1.3f \n last vs 2nd R %1.3f %1.3f', ...
%              %       dofstr, pvalT(1,2), pvalT(1,3),pvalR(1,2), pvalR(1,3),pvalT2(1,2), pvalT2(1,3),pvalR2(1,2), pvalR2(1,3)));
% 
%                 filenamePDF = [filename '_LEGEND.jpeg'];
%                 legend(hd, S.rc(include_rc).drug(doPtz).comparison(iComparison).label);
%                 saveas(gcf,filenamePDF)
            end
            close all
        end
    end
end                                                                              
