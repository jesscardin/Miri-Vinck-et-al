function [] = MitraPaper_plot_waveforms
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 1;
MitraPaper_info
global datadir_manuscript
global figuredir_manuscript

str = ['waveform_parameters'];
filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
load(filename);
%%
str = ['averagerate_' num2str(nIctalPeriods)];
filename = fullfile(datadir_manuscript, 'average_rates', str);
load(filename, 'R');
%%
for iC = 1:length(info)
    cre{iC} = info(iC).cre;
end
%%
%%
root = fullfile(figuredir_manuscript, 'waveforms')
p2t = Stat.p2t;
repor = Stat.repor;
ispv = Stat.ispv;
issom = Stat.issom;
isrs = Stat.isrs;

figure,
plot3(p2t(ispv), repor(ispv),R.rate_base(ispv),'ro')
hold on
plot3(p2t(issom), repor(issom),R.rate_base(issom),'go')
hold on
plot3(p2t(isrs), repor(isrs),R.rate_base(isrs),'ko')
hold on
%plot(p2t(isrs & strcmp(cre,'PV')), repor(isrs& strcmp(cre,'PV')),'co')


cfg.height = 2;
cfg.width = 2;
set(gca,'TickDir','out')
set(gca,'Box', 'off')

filename = fullfile(root, 'wavepars_rs');
%publish(filename,cfg)
%%
root = fullfile(figuredir_manuscript, 'waveforms')
p2t = Stat.p2t;
repor = Stat.repor;
ispv = Stat.ispv;
issom = Stat.issom;
isrs = Stat.isrs;

figure,
plot(p2t(ispv), repor(ispv),'ro')
hold on
plot(p2t(issom), repor(issom),'go')
hold on
plot(p2t(isrs), repor(isrs),'ko')
hold on
%plot(p2t(isrs & strcmp(cre,'PV')), repor(isrs& strcmp(cre,'PV')),'co')


cfg.height = 2;
cfg.width = 2;
set(gca,'TickDir','out')
set(gca,'Box', 'off')

filename = fullfile(root, 'wavepars_rs');
publish(filename,cfg)
%%

p2t = Stat.p2t;
repor = Stat.repor;
ispv = Stat.ispv;
issom = Stat.issom;
isrs = Stat.isrs;

figure,
%plot(p2t(ispv), repor(ispv),'ro')
%hold on
%plot(p2t(issom), repor(issom),'go')
hold on
plot(p2t(isrs & strcmp(cre,'SOM')), repor(isrs & strcmp(cre,'SOM')),'k*', 'MarkerFaceColor', 'k')
hold on
plot(p2t(isrs & strcmp(cre,'PV')), repor(isrs & strcmp(cre,'PV')),'ko', 'MarkerFaceColor', 'k')
hold on
plot(p2t(isrs & ~strcmp(cre,'PV') & ~strcmp(cre,'SOM')), repor(isrs & ~strcmp(cre,'PV') & ~strcmp(cre,'SOM')),'kd')
%

set(gca,'YTick', [-1 0 0.4])
xlim([0.1 0.6])
set(gca,'XTick', [0.1 0.3 0.6])
cfg.height = 2.2;
cfg.width = 2.2;
set(gca,'TickDir','out')
set(gca,'Box', 'off')

filename = fullfile(root, 'wavepars_rs_pv');
publish(filename,cfg)
%%

p2t = Stat.p2t;
repor = Stat.repor;
ispv = Stat.ispv;
issom = Stat.issom;
isrs = Stat.isrs;

figure,
plot(p2t(ispv), repor(ispv),'go')
% %hold on
% %plot(p2t(issom), repor(issom),'go')
% hold on
% plot(p2t(isrs & strcmp(cre,'SOM')), repor(isrs & strcmp(cre,'SOM')),'k*', 'MarkerFaceColor', 'k')
% hold on
% plot(p2t(isrs & strcmp(cre,'PV')), repor(isrs & strcmp(cre,'PV')),'ko', 'MarkerFaceColor', 'k')
% hold on
% plot(p2t(isrs & ~strcmp(cre,'PV') & ~strcmp(cre,'SOM')), repor(isrs & ~strcmp(cre,'PV') & ~strcmp(cre,'SOM')),'kd')
%

set(gca,'YTick', [-1 0 0.4])
xlim([0.1 0.6])
set(gca,'XTick', [0.1 0.3 0.6])
set(gca,'XTickLabel', [0.1 0.3 0.6])

cfg.height = 2.2;
cfg.width = 2.2;
set(gca,'TickDir','out')
set(gca,'Box', 'off')

filename = fullfile(root, 'wavepars_pv');
publish(filename,cfg)
%%

p2t = Stat.p2t;
repor = Stat.repor;
ispv = Stat.ispv;
issom = Stat.issom;
isrs = Stat.isrs;

figure,
plot(p2t(issom), repor(issom),'bo')
ylim([-1 0.4])
% %hold on
% %plot(p2t(issom), repor(issom),'go')
% hold on
% plot(p2t(isrs & strcmp(cre,'SOM')), repor(isrs & strcmp(cre,'SOM')),'k*', 'MarkerFaceColor', 'k')
% hold on
% plot(p2t(isrs & strcmp(cre,'PV')), repor(isrs & strcmp(cre,'PV')),'ko', 'MarkerFaceColor', 'k')
% hold on
% plot(p2t(isrs & ~strcmp(cre,'PV') & ~strcmp(cre,'SOM')), repor(isrs & ~strcmp(cre,'PV') & ~strcmp(cre,'SOM')),'kd')
%

cfg.height = 2.2;
cfg.width = 2.2;

set(gca,'YTick', [-1 0 0.4])
xlim([0.1 0.6])
set(gca,'XTick', [0.1 0.3 0.6])
set(gca,'XTickLabel', [0.1 0.3 0.6])
set(gca,'TickDir','out')
set(gca,'Box', 'off')
filename = fullfile(root, 'wavepars_som');
publish(filename,cfg)
%%
%%
p2t = Stat.p2t;
repor = Stat.repor;
ispv = Stat.ispv;
issom = Stat.issom;
isrs = Stat.isrs;

figure,
plot(R.rate_base(ispv), repor(ispv),'ro')
hold on
plot(R.rate_base(issom), repor(issom),'go')
hold on
plot(R.rate_base(isrs), repor(isrs),'ko')

%%

figure,
plot(R.rate_base(ispv), repor(ispv),'ro')
hold on
plot(R.rate_base(issom), repor(issom),'go')
hold on
plot(R.rate_base(isrs), repor(isrs),'ko')
%%
figure, hist(repor(isrs|ispv),15)
%%
figure
hold on
plot(p2t(issom), repor(issom),'go')

%%



%hist(p2t(p2t(:)'<0.6),20)

figure,
hist(p2t(ispv&p2t(:)'<0.6),10)
figure,
hist(p2t(isrs&p2t(:)'<0.6),10)
%%


%ispv = find(strcmp(celltype,'PV'))
%issom = find(strcmp(celltype,'SOM'))
%isrs = find(strcmp(celltype,'RS'));
%%
bsrate = R.rate_base(isrs);
wvrs   = wvAll(isrs,:);

somrate = R.rate_base(issom);
wvsom   = wvAll(issom,:);
%%
root = fullfile(figuredir_manuscript, 'waveforms')
mkdir(root)
time = Stat.time;
wvAll = Stat.wvAll;
figure, 
hold on
plot(time, wvAll(issom,:)','g')
hold on
xlim([-0.0003 0.001])
set(gca,'TickDir','out')
set(gca,'Box', 'off')
filename = fullfile(root, 'waves_som')
cfg.height = 1.5;
cfg.width = 1.5;
publish(filename,cfg)
figure
plot(time, wvAll(isrs(:) & repor(:)<-0.35,:)','k')
hold on
xlim([-0.0003 0.001])
set(gca,'TickDir','out')
set(gca,'Box', 'off')

filename = fullfile(root, 'waves_rs')
publish(filename,cfg)
figure
plot(time, wvAll(ispv,:)','r')
xlim([-0.0003 0.001])
filename = fullfile(root, 'waves_pv')
set(gca,'TickDir','out')
set(gca,'Box', 'off')

publish(filename,cfg)
%%
root = fullfile(figuredir_manuscript, 'waveforms')
mkdir(root)
time = Stat.time;
wvAll = Stat.wvAll;
figure, 
hold on
plot(time, wvAll(issom,:)','g')
hold on
xlim([-0.0003 0.001])
set(gca,'TickDir','out')
set(gca,'Box', 'off')
filename = fullfile(root, 'waves_som')
cfg.height = 1.5;
cfg.width = 1.5;
publish(filename,cfg)
figure
plot(time, wvAll(isrs(:),:)','k')
hold on
xlim([-0.0003 0.001])
set(gca,'TickDir','out')
set(gca,'Box', 'off')

filename = fullfile(root, 'waves_rs')
publish(filename,cfg)
figure
plot(time, wvAll(ispv,:)','r')
xlim([-0.0003 0.001])
filename = fullfile(root, 'waves_pv')
set(gca,'TickDir','out')
set(gca,'Box', 'off')

publish(filename,cfg)

%%
figure, 
hold on
plot(time, nanmean(wvAll(issom,:)',2),'g')
hold on
plot(time, nanmean(wvAll(isrs,:)',2),'k')
hold on
plot(time, nanmean(wvAll(ispv,:)',2),'r')
xlim([-0.001 0.0015])

%%

figure
plot(wv.time, wvsom(somrate>10,:)','g')
hold on
plot(wv.time, wvsom(somrate<10,:)','k')
hold on
figure
plot(wv.time, wvrs(bsrate<10,:)','k')
hold on
plot(wv.time, wvrs(bsrate>10,:)','r')

    





%%
nUnits = length(stat.repor);
for iUnit = 1:nUnits
    figure, plot(Stat.time, Stat.wvAll(iUnit,:))
    xlabel('time')
    ylabel('normalized waveform amplitude')
    xlim([-0.0005 0.0009])
end
%   
    S = MitraPaper_getselections(R,Stat,repor_cutoff);
    normalization_labels = {'modindx_to_base', 'modindx_to_ictal','diff_to_base', 'diff_to_ictal', 'ratio_to_max'};
        
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
                    for iType = 1:n_types                    
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
                        else
                             modIndx = (dat./ratenorm);
                        end
                        
                        hold on
                        colors = S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label;                        
                        hd(iType)=errorbar(0:nIctalPeriods,nanmean(modIndx,1), nanstd(modIndx,[],1)./sqrt(size(modIndx,1)),['o-' colors{iType}]);
                        str = [str ' ' num2str(sum(sl))];
                        
 %                       modIndxAll = [modIndxAll ; dat];
%                        neuronlabels = cat(1,neuronlabels,R.neurontype(sl)');
                        modIndxAll{iType} = modIndx
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
