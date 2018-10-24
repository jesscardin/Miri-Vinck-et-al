function [] = MitraPaper_plot_rate_periods
%%
repor_cutoff = -0.35;
base_crit    = 0.1;
doPublish = 0;
MitraPaper_info
global info
global datadir_manuscript
global figuredir_manuscript
tBeg = -0.08; tEnd = 0.2
for nIctalPeriods = 4

    str = ['psth_rc' num2str(nIctalPeriods)];
    filename = fullfile(datadir_manuscript, 'psth_rc', str);
    load(filename, 'R');
    R.avg_all_ictal = R.avg_all_ictal(:,1:5,:,:);
  %  str = ['averagerate_' num2str(nIctalPeriods)];
 %   filename = fullfile(datadir_manuscript, 'average_rates', str);
 %   inp2 = load(filename, 'R');

  %  str = ['rc_' num2str(nIctalPeriods)];
%    filename = fullfile(datadir_manuscript, 'rc', str);
 %   inp3 = load(filename, 'R');
    
    str = ['waveform_parameters'];
    filename = fullfile(datadir_manuscript, 'waveform_parameters', str);
    load(filename);
    Stat.repor(168:197) = -1;         
    for k = 1:length(info)
        dirs{k} = info(k).directory;
    end

    has_rc = [];
    for k = 1:length(info)
        R.neurontype{k}  = info(k).neuron_type;
        has_rc(k) = info(k).has_rc==1;
        try
            R.cre{k} = info(k).cre;
        end
    end
    [a,b,c] = unique(R.neurontype);
    R.neurontype_label = a;
    R.neurontype_indx  = c;
    
    S = MitraPaper_getselections_rc(R,Stat,repor_cutoff);
    
    t = linspace(-0.245,0.245,50);
    nCells = length(R.celltype);
    idx = [];    
    
    tb = nearest(t,-0.2);
    te = nearest(t,+0.2);
    R.avg_all_base = R.avg_all_base(:,:,tb:te);
    R.avg_all_ictal = R.avg_all_ictal(:,:,:,tb:te);
    t = t(tb:te);
    t0 = nearest(t,0.005);

        
    for nPeriods = 1

        avg_high = NaN(1,length(info));
        avg_base_high = NaN(length(info),length(t));
        avg_ictal_high = NaN(length(info),nIctalPeriods+1,length(t));
        nCells = length(info);
        for k = 1:nCells
            avg = squeeze(R.avg_all_base(k,:,t0));
            idx(k) = find(isnan(avg),1,'first');
            if idx(k)>1
                avg = nanmean(squeeze(R.avg_all_base(k,idx(k)-nPeriods:idx(k),:)));
                avg = zscore(avg,1,2);
                avg_high(k) = nanmean(avg(t0:t0+1));
                avg_base_high(k,:) = squeeze(nanmean(R.avg_all_base(k,idx(k)-nPeriods:idx(k),:),2));
                avg_ictal_high(k,:,:) = squeeze(nanmean(R.avg_all_ictal(k,:,idx(k)-nPeriods:idx(k),:),3));
            else
                avg_high(k) = NaN;
                avg_base_high(k,:) = NaN;
            end
        end    

        %%
        root = (fullfile(figuredir_manuscript, 'rc_curves_psth', num2str(nPeriods)));
        mkdir(root);
        directory_name = fullfile(root, 'interneurons');    
        mkdir(directory_name);                        
        filename = fullfile(directory_name);        
         cre_label = {'SOM', 'PV'};
         R.cre(end+1:length(info)) = {'non_rc'};
         %%     
        labels = S.rc(1).drug(1).comparison(1).label;
        for iSel = 1:2
            sel = S.rc(1).drug(1).comparison(1).selection_logical{iSel}' & any(avg_base_high>0,2)';    
            figure('Visible', 'off'), imagesc(t, 1:sum(sel),avg_base_high(sel(:),:)),colorbar
            xlim([tBeg tEnd])
            filename = fullfile(directory_name,[labels{iSel} 'heatmap_rate'])
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            nAnimals = length(unique(dirs(sel)));
            nCells   = sum(sel);    
            title(sprintf('num an = %d, num cell = %d', nAnimals, nCells));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

            zAvgHigh = zscore(avg_base_high(sel,:),1,2);
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sel)),nanstd(zAvgHigh)./sqrt(sum( sel)),'k-', 'k--')
            hold on
            xlim([tBeg tEnd])              
            filename = fullfile(directory_name,[labels{iSel} 'avg_rate_z']);
            xlabel('time')
            ylabel('cells')                
            title(sprintf('num an = %d, num cell = %d', nAnimals, nCells));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

            zAvgHigh = avg_base_high(sel,:);
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sel)),nanstd(zAvgHigh)./sqrt(sum(sel)),'k-', 'k--')
            hold on
            xlim([tBeg tEnd])              
            filename = fullfile(directory_name,[labels{iSel} 'avg_rate']);
            xlabel('time')
            ylabel('cells')        
            title(sprintf('num an = %d, num cell = %d', nAnimals, nCells));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);  
            saveas(gcf,[filename '.jpeg']);
        end
  keyboard
         for iCre = 1
             pyrsel = find((S.rc(1).drug(1).comparison(3).selection_logical{1} | S.rc(1).drug(1).comparison(3).selection_logical{2}) & strcmp(R.cre,cre_label{iCre})');                      
             for k = pyrsel(:)'
                % if has_rc(k)==0, continue,end
                     
                 baseNorm = permute(shiftdim(avg_base_high,-1),[2 1 3]);
                 baseNorm = repmat(baseNorm,[1 1 1]);
                 mod = cat(2,baseNorm,avg_ictal_high);%-baseNorm;    
                 mod = nanmean(mod,2);
                 figure('Visible', 'on'), 
                 subplot(2,1,1)
                 plot(t,mod(k,:),'ko-')
                 title(sprintf('unit %d, zscore = %2.2f', k,avg_high(k)))
                 subplot(2,1,2)
                 plot(t,avg_base_high(k,:),'ko-')
                 title(sprintf('unit %d, zscore = %2.2f', k,avg_high(k)))             
             end
         end

    %          
    %     
    %     for k = S.rc(1).drug(1).comparison(1).selection_indx{2}'
    %         if has_rc(k)==0, continue,end
    %         figure('Visible', 'off'), 
    %         plot(t,avg_base_high(k,:),'ko-')
    %         title(sprintf('unit %d, zscore = %2.2f', k,avg_high(k)))
    %     end
    % 
    % %    
%          for k = S.rc(1).drug(1).comparison(3).selection_indx{1}'
%             if has_rc(k)==0, continue,end
%             figure('Visible', 'off'), 
%             plot(t,avg_base_high(k,:),'ko-')
%             title(sprintf('unit %d, zscore = %2.2f, cre = %s', k,avg_high(k),R.cre{k}))
%          end

         dirs = {};
        for k = 1:length(info)
            dirs{k} = info(k).directory; %'E:\SRT2014\chr2_ptz\2014-06-30_18-53-48'
        end

        nAnimals = []; nCells = [];
         for iCre = 1:2
             sl = any(avg_base_high>0,2) & strcmp(R.cre,cre_label{iCre})';
        % 
           % figure('Visible', 'off'), imagesc(avg_base_high(sl & S.rc(1).drug(1).comparison(3).selection_logical{1},:))
           % figure('Visible', 'off'), imagesc(avg_base_high(sl & S.rc(1).drug(1).comparison(3).selection_logical{2},:))
            pyrsel = S.rc(1).drug(1).comparison(3).selection_logical{1} | S.rc(1).drug(1).comparison(3).selection_logical{2};
            figure('Visible', 'off'), imagesc(t,1:sum(sl & pyrsel),avg_base_high(sl & pyrsel,:))         
           % xlim([tBeg tEnd])              

            nAnimals(iCre) = length(unique(dirs(sl & pyrsel)))
            nCells(iCre)   = sum(sl & pyrsel);

            zAvgHigh = avg_base_high(sl & pyrsel,:);

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'heatmap_avg_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
        %    nAnimals = length(unique(dirs(sel)));
        %    nCells   = sum(sel);    
            title(sprintf('num an = %d, num cell = %d', nAnimals(iCre), nCells(iCre)));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

%keyboard
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),'k-', 'k--')
            hold on
            xlim([tBeg tEnd])              

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'avg_psth']);           
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
         %   nAnimals = length(unique(dirs(sel)));
         %   nCells   = sum(sel);    
            title(sprintf('num an = %d, num cell = %d', nAnimals(iCre), nCells(iCre)));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);


            zAvgHigh = zscore(avg_base_high(sl & pyrsel,:),1,2);
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),'k-', 'k--')
            hold on

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'z_avg_psth']);           
            xlabel('time')
            ylabel('cells')
            xlim([tBeg tEnd])              

            cfg.height = 2.2;
            cfg.width = 2.2;
          %  nAnimals = length(unique(dirs(sel)));
          %  nCells   = sum(sel);    
            %title(sprintf('num an = %d, num cell = %d', nAnimals, nCells));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

            somsel = [82 84 168 170 179 194 189 181 187 192 188]; % 192 188 187     171     174 
            if iCre==2
                inhsl = [89 91 92 95 96 100 104 115];
                inh   = false(length(info),1);
                inh(inhsl) = true;
            elseif iCre==1 % 175?
                inhsl = somsel;
                inh   = false(length(info),1);
                inh(inhsl) = true;
            end 
            zAvgHigh = zscore(avg_base_high(sl(:) & pyrsel(:) & inh(:),:),1,2);
          
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel & inh(:))),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel & inh(:))),'k-', 'k--')
            hold on

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'sel_z_avg_psth']);           
            xlabel('time')
            ylabel('cells')
            xlim([tBeg tEnd])              

            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
                     saveas(gcf,[filename '.jpeg']);
  
         end
%keyboard
         %%
         nAnimals = []; nCells = [];
         for iCre = 1:2
             sl = any(avg_base_high>0,2) & strcmp(R.cre,cre_label{iCre})';
        % 
           % figure('Visible', 'off'), imagesc(avg_base_high(sl & S.rc(1).drug(1).comparison(3).selection_logical{1},:))
           % figure('Visible', 'off'), imagesc(avg_base_high(sl & S.rc(1).drug(1).comparison(3).selection_logical{2},:))
            pyrsel = S.rc(1).drug(1).comparison(3).selection_logical{1} | S.rc(1).drug(1).comparison(3).selection_logical{2};
            figure('Visible', 'off'), imagesc(t,1:sum(sl & pyrsel),squeeze(avg_ictal_high(sl & pyrsel,end,:)))         
           % xlim([tBeg tEnd])              

            nAnimals(iCre) = length(unique(dirs(sl & pyrsel)))
            nCells(iCre)   = sum(sl & pyrsel);

            zAvgHigh = squeeze(avg_ictal_high(sl & pyrsel,end,:));

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'heatmap_avg_psth_ictal']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
        %    nAnimals = length(unique(dirs(sel)));
        %    nCells   = sum(sel);    
            title(sprintf('num an = %d, num cell = %d', nAnimals(iCre), nCells(iCre)));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);


            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),'k-', 'k--')
            hold on
            xlim([tBeg tEnd])              

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'avg_psth_ictal']);           
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
         %   nAnimals = length(unique(dirs(sel)));
         %   nCells   = sum(sel);    
            title(sprintf('num an = %d, num cell = %d', nAnimals(iCre), nCells(iCre)));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);


            zAvgHigh = squeeze(zscore(avg_ictal_high(sl & pyrsel,end,:),1,3));
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel)),'k-', 'k--')
            hold on

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'z_avg_psth_ictal']);           
            xlabel('time')
            ylabel('cells')
            xlim([tBeg tEnd])              

            cfg.height = 2.2;
            cfg.width = 2.2;
          %  nAnimals = length(unique(dirs(sel)));
          %  nCells   = sum(sel);    
            %title(sprintf('num an = %d, num cell = %d', nAnimals, nCells));
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);


            if iCre==2
                inhsl = [89 91 92 95 96 100 104 115];
                inh   = false(length(info),1);
                inh(inhsl) = true;
            elseif iCre==1
                inhsl = somsel;
                inh   = false(length(info),1);
                inh(inhsl) = true;
            end 
            zAvgHigh = squeeze(zscore(avg_ictal_high(sl(:) & pyrsel(:) & inh(:),end,:),1,3));
          
            figure('Visible', 'off'), 
            plotmeansem(t,nanmean(zAvgHigh),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel & inh(:))),nanstd(zAvgHigh)./sqrt(sum(sl & pyrsel & inh(:))),'k-', 'k--')
            hold on

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'sel_z_avg_psth_ictal']);           
            xlabel('time')
            ylabel('cells')
            xlim([tBeg tEnd])              

            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
                     saveas(gcf,[filename '.jpeg']);
  
         end
         %%

        baseNorm = permute(shiftdim(avg_base_high,-1),[2 1 3]);
        baseNorm = repmat(baseNorm,[1 1 1]);
        mod = cat(2,baseNorm,avg_ictal_high);%-baseNorm;    
        for iCre = 1:2
            if iCre==2
                inhsl = [89 91 92 95 96 100 104 115];
                inh   = false(length(info),1);
                inh(inhsl) = true;
            elseif iCre==1
                inhsl = somsel;
                inh   = false(length(info),1);
                inh(inhsl) = true;
            end                
                
            sl = any(avg_base_high>0,2) & strcmp(R.cre,cre_label{iCre})' & inh(:);
            pyrsel = S.rc(1).drug(1).comparison(3).selection_logical{1} | S.rc(1).drug(1).comparison(3).selection_logical{2};
            mn = squeeze(nanmean(mod(sl & pyrsel,:,:),1));
            sm = squeeze(nanstd(mod(sl & pyrsel,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'on'), imagesc(t,0:nIctalPeriods+1,mn)        
            xlim([tBeg tEnd])
            colorbar

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'avgrateraw_heatmap_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
            saveas(gcf,[filename '.jpeg']);

            tpre = nearest(t,-0.2):nearest(t,-0.005);
            avgPre = nanmean(mod(sl & pyrsel,:,tpre),3);           
            modMod = (mod(sl & pyrsel,:,:)-repmat(avgPre,[1 1 length(t)]));% ./ (mod(sl & pyrsel,:,:)+repmat(avgPre,[1 1 length(t)]))
            t0 = nearest(t,0.005):nearest(t,0.05);             
            avPost = nanmean(modMod(:,:,t0),3);
            avPost = avPost;% - repmat(avPost(:,2),[1 nIctalPeriods+1+1]);

            mn = squeeze(nanmean(avPost(:,:,:),1));
            sm = squeeze(nanstd(avPost(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), 
            errorbar(0:nIctalPeriods+1,mn,sm,sm,'k-')
            xlim([-0.5 5.5])
            xlabel('time')
            ylabel('average modulation')

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'avgrateraw_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);         
            saveas(gcf,[filename '.jpeg']);
                                                
            tpre = nearest(t,-0.2):nearest(t,-0.005);
            avgPre = nanmean(mod(sl & pyrsel,:,tpre),3);
            modMod = (mod(sl & pyrsel,:,:)-repmat(avgPre,[1 1 length(t)])) ./ (mod(sl & pyrsel,:,:)+repmat(avgPre,[1 1 length(t)]))
            mn = squeeze(nanmean(modMod(:,:,:),1));
            sm = squeeze(nanstd(modMod(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), imagesc(t,0:nIctalPeriods+1,conv2(mn,ones(1,1)./1,'same'))
             xlim([tBeg tEnd])
            colorbar

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'avgratemod_heatmap_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
             publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

            t0 = nearest(t,0.005):nearest(t,0.05);             
            avPost = nanmean(modMod(:,:,t0),3);
            avPost = avPost;% - repmat(avPost(:,2),[1 nIctalPeriods+1+1]);

            mn = squeeze(nanmean(avPost(:,:,:),1));
            sm = squeeze(nanstd(avPost(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), 
            %plotmeansem(0:nIctalPeriods+1,mn,sm,sm,'k-','k--')
            errorbar(0:nIctalPeriods+1,mn,sm,'bo-')
             xlim([-0.5 5.5])            
            xlabel('time')
            ylabel('average modulation')
             ylim([-1 0])
            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'avgratemod_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;

            for k = 1:size(modMod,2)
                [H(k),pval(k)]=ttest(avPost(:,k))
                [pvalR(k)]=signrank(avPost(:,k))            
            end

            pvalR_to_base = NaN(1,5);
            for k = 2:size(modMod,2)
                [pvalR_to_base(k)]=signrank(avPost(:,k)-avPost(:,1))            
            end

            pvalR_to_ictal = NaN(1,5);
            for k = 3:size(modMod,2)
                [pvalR_to_ictal(k)]=signrank(avPost(:,k)-avPost(:,2))            
            end

            str = [];
            for k = 2:size(modMod,2)
                str = [str ' ' sprintf('%.2f', pvalR_to_base(k))];
            end
            str2 = [];
            for k = 2:size(modMod,2)
                str2 = [str2 ' ' sprintf('%.2f', pvalR_to_ictal(k))];
            end
            str3 = [];
            for k = 1:size(avPost,2)
                str3 = [str3 ' ' sprintf('%.2f', pvalR(k))];
            end
            strAll = sprintf('to b%s \n, to ic %s\n %s', str, str2, str3);


            publish(filename,cfg)
            title(strAll);

            saveas(gcf,[filename '.pdf']);         
           saveas(gcf,[filename '.jpeg']);

        end
                        
        iCre = 2;
        inhsl = [89 91 92 95 96 100 104 115];
        inh   = false(length(info),1);
        inh(inhsl) = true;
        for k = inhsl(:)'
            str = ['rc_' num2str(nIctalPeriods)];
            filename = fullfile(datadir_manuscript, 'rc', str);
            inp2 = load(filename, 'R');    
            idx_it = find(strcmp(dirs,info(k).directory) & strcmp(R.neurontype,cre_label{iCre}));
            c50 = nanmean(inp2.R.coeffs_base(idx_it,5));
            id = find(info(k).light_levels>c50,1,'first');
            avg_base_high(k,:) = squeeze(nanmean(R.avg_all_base(k,id,:),2));
            avg_ictal_high(k,:,:) = squeeze(nanmean(R.avg_all_ictal(k,:,id,:),3));
        end
        
        
        baseNorm = permute(shiftdim(avg_base_high,-1),[2 1 3]);
        baseNorm = repmat(baseNorm,[1 1 1]);
        mod = cat(2,baseNorm,avg_ictal_high);%-baseNorm;    
        for iCre = 2
            if iCre==2
                inhsl = [89 91 92 95 96 100 104 115];
                inh   = false(length(info),1);
                inh(inhsl) = true;
            elseif iCre==1
                inhsl = somsel;
                inh   = false(length(info),1);
                inh(inhsl) = true;
            end                
                
            sl = any(avg_base_high>0,2) & strcmp(R.cre,cre_label{iCre})' & inh(:);
            pyrsel = S.rc(1).drug(1).comparison(3).selection_logical{1} | S.rc(1).drug(1).comparison(3).selection_logical{2};
            mn = squeeze(nanmean(mod(sl & pyrsel,:,:),1));
            sm = squeeze(nanstd(mod(sl & pyrsel,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'on'), imagesc(t,0:nIctalPeriods+1,mn)        
            xlim([tBeg tEnd])
            colorbar

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgrateraw_heatmap_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
            saveas(gcf,[filename '.jpeg']);

            tpre = nearest(t,-0.2):nearest(t,-0.005);
            avgPre = nanmean(mod(sl & pyrsel,:,tpre),3);           
            modMod = (mod(sl & pyrsel,:,:)-repmat(avgPre,[1 1 length(t)]));% ./ (mod(sl & pyrsel,:,:)+repmat(avgPre,[1 1 length(t)]))
            t0 = nearest(t,0.005):nearest(t,0.05);             
            avPost = nanmean(modMod(:,:,t0),3);
            avPost = avPost;% - repmat(avPost(:,2),[1 nIctalPeriods+1]);

            mn = squeeze(nanmean(avPost(:,:,:),1));
            sm = squeeze(nanstd(avPost(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), plotmeansem(0:nIctalPeriods+1,mn,sm,sm,'k-','k--')
            xlabel('time')
            ylabel('average modulation')

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgrateraw_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);         
            saveas(gcf,[filename '.jpeg']);
                                                
            tpre = nearest(t,-0.2):nearest(t,-0.005);
            avgPre = nanmean(mod(sl & pyrsel,:,tpre),3);
            modMod = (mod(sl & pyrsel,:,:)-repmat(avgPre,[1 1 length(t)])) ./ (mod(sl & pyrsel,:,:)+repmat(avgPre,[1 1 length(t)]))
            mn = squeeze(nanmean(modMod(:,:,:),1));
            sm = squeeze(nanstd(modMod(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), imagesc(t,0:nIctalPeriods+1,conv2(mn,ones(1,1)./1,'same'))
             xlim([tBeg tEnd])
            colorbar

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgratemod_heatmap_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
             publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

            t0 = nearest(t,0.005):nearest(t,0.05);             
            avPost = nanmean(modMod(:,:,t0),3);
            avPost = avPost;% - repmat(avPost(:,2),[1 nIctalPeriods+1]);

            mn = squeeze(nanmean(avPost(:,:,:),1));
            sm = squeeze(nanstd(avPost(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), 
            errorbar(0:nIctalPeriods+1,mn,sm,'go-')
             xlim([-0.5 5.5])            
            xlabel('time')
            ylabel('average modulation')
            ylim([-1 0])
           % xlim([-0.5 4.5])
            set(gca,'TickDir', 'out')
            set(gca,'Box', 'off')
            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgratemod_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;

            for k = 1:size(modMod,2)
                [H(k),pval(k)]=ttest(avPost(:,k))
                [pvalR(k)]=signrank(avPost(:,k))            
            end

            pvalR_to_base = NaN(1,5);
            for k = 2:size(modMod,2)
                [pvalR_to_base(k)]=signrank(avPost(:,k)-avPost(:,1))            
            end

            pvalR_to_ictal = NaN(1,5);
            for k = 3:size(modMod,2)
                [pvalR_to_ictal(k)]=signrank(avPost(:,k)-avPost(:,2))            
            end

            str = [];
            for k = 2:size(modMod,2)
                str = [str ' ' sprintf('%.2f', pvalR_to_base(k))];
            end
            str2 = [];
            for k = 2:size(modMod,2)
                str2 = [str2 ' ' sprintf('%.2f', pvalR_to_ictal(k))];
            end
                 str3 = [];
            for k = 1:size(avPost,2)
                str3 = [str3 ' ' sprintf('%.2f', pvalR(k))];
            end
            strAll = sprintf('to b%s \n, to ic %s\n %s', str, str2, str3);


            publish(filename,cfg)
            title(strAll);

            saveas(gcf,[filename '.pdf']);         
           saveas(gcf,[filename '.jpeg']);

        end
        
        %%
           iCre = 1;
        inhsl = somsel;
        inh   = false(length(info),1);
        inh(inhsl) = true;
        for k = inhsl
            if k<168 | k>180
                str = ['rc_' num2str(nIctalPeriods)];
                filename = fullfile(datadir_manuscript, 'rc', str);
                inp2 = load(filename, 'R');    
                idx_it = find(strcmp(dirs,info(k).directory) & strcmp(R.neurontype,cre_label{iCre}));
                c50 = nanmean(inp2.R.coeffs_base(idx_it,5));
                id = find(info(k).light_levels>c50,1,'first');
            else
                id = round(info(k).nlevels/2);
            end
            avg_base_high(k,:) = squeeze(nanmean(R.avg_all_base(k,id,:),2));
            avg_ictal_high(k,:,:) = squeeze(nanmean(R.avg_all_ictal(k,:,id,:),3));
        end
        
        
        baseNorm = permute(shiftdim(avg_base_high,-1),[2 1 3]);
        baseNorm = repmat(baseNorm,[1 1 1]);
        mod = cat(2,baseNorm,avg_ictal_high);%-baseNorm;    
        for iCre = 1
            if iCre==2
                inhsl = [89 91 92 95 96 100 104 115];
                inh   = false(length(info),1);
                inh(inhsl) = true;
            elseif iCre==1
                inhsl = somsel;
                inh   = false(length(info),1);
                inh(inhsl) = true;
            end                
                
            sl = any(avg_base_high>0,2) & strcmp(R.cre,cre_label{iCre})' & inh(:);
            pyrsel = S.rc(1).drug(1).comparison(3).selection_logical{1} | S.rc(1).drug(1).comparison(3).selection_logical{2};
            mn = squeeze(nanmean(mod(sl & pyrsel,:,:),1));
            sm = squeeze(nanstd(mod(sl & pyrsel,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), imagesc(t,0:nIctalPeriods+1,mn)        
            xlim([tBeg tEnd])
            colorbar

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgrateraw_heatmap_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
            saveas(gcf,[filename '.jpeg']);

            tpre = nearest(t,-0.2):nearest(t,-0.005);
            avgPre = nanmean(mod(sl & pyrsel,:,tpre),3);           
            modMod = (mod(sl & pyrsel,:,:)-repmat(avgPre,[1 1 length(t)]));% ./ (mod(sl & pyrsel,:,:)+repmat(avgPre,[1 1 length(t)]))
            t0 = nearest(t,0.005):nearest(t,0.05);             
            avPost = nanmean(modMod(:,:,t0),3);
            avPost = avPost;% - repmat(avPost(:,2),[1 nIctalPeriods+1]);

            mn = squeeze(nanmean(avPost(:,:,:),1));
            sm = squeeze(nanstd(avPost(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), 
            errorbar(0:nIctalPeriods+1,mn,sm,'bo-')
             ylim([-1 0])
             xlim([-0.5 5.5])
 %           plotmeansem(0:nIctalPeriods,mn,sm,sm,'k-','k--')
            xlabel('time')
            ylabel('average modulation')

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgrateraw_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
            publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);         
            saveas(gcf,[filename '.jpeg']);
                                                
            tpre = nearest(t,-0.2):nearest(t,-0.005);
            avgPre = nanmean(mod(sl & pyrsel,:,tpre),3);
            modMod = (mod(sl & pyrsel,:,:)-repmat(avgPre,[1 1 length(t)])) ./ (mod(sl & pyrsel,:,:)+repmat(avgPre,[1 1 length(t)]))
            mn = squeeze(nanmean(modMod(:,:,:),1));
            sm = squeeze(nanstd(modMod(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), imagesc(t,0:nIctalPeriods+1,conv2(mn,ones(1,1)./1,'same'))
             xlim([tBeg tEnd])
            colorbar

            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgratemod_heatmap_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;
             publish(filename,cfg)
            saveas(gcf,[filename '.pdf']);
           saveas(gcf,[filename '.jpeg']);

            t0 = nearest(t,0.005):nearest(t,0.05);             
            avPost = nanmean(modMod(:,:,t0),3);
            avPost = avPost;% - repmat(avPost(:,2),[1 nIctalPeriods+1]);

            mn = squeeze(nanmean(avPost(:,:,:),1));
            sm = squeeze(nanstd(avPost(:,:,:),1) ./ sqrt(sum(sl & pyrsel)));
            figure('Visible', 'off'), 
            errorbar(0:nIctalPeriods+1,mn,sm,'bo-')
            xlim([-0.5 5.5])
            xlabel('time')
            ylabel('average modulation')
            ylim([-1 0])
          %  xlim([-0.5 4.5])
            set(gca,'TickDir', 'out')
            set(gca,'Box', 'off')
            filename = fullfile(directory_name,['rspsth_' cre_label{iCre} 'MEDIUMavgratemod_psth']);      
            xlabel('time')
            ylabel('cells')
            cfg.height = 2.2;
            cfg.width = 2.2;

            for k = 1:size(modMod,2)
                [H(k),pval(k)]=ttest(avPost(:,k))
                [pvalR(k)]=signrank(avPost(:,k))            
            end

            pvalR_to_base = NaN(1,5);
            for k = 2:size(modMod,2)
                [pvalR_to_base(k)]=signrank(avPost(:,k)-avPost(:,1))            
            end

            pvalR_to_ictal = NaN(1,5);
            for k = 3:size(modMod,2)
                [pvalR_to_ictal(k)]=signrank(avPost(:,k)-avPost(:,2))            
            end

            str = [];
            for k = 2:size(modMod,2)
                str = [str ' ' sprintf('%.2f', pvalR_to_base(k))];
            end
            str2 = [];
            for k = 2:size(modMod,2)
                str2 = [str2 ' ' sprintf('%.2f', pvalR_to_ictal(k))];
            end
                 str3 = [];
            for k = 1:size(avPost,2)
                str3 = [str3 ' ' sprintf('%.2f', pvalR(k))];
            end
            strAll = sprintf('to b%s \n, to ic %s\n %s', str, str2, str3);


            publish(filename,cfg)
            title(strAll);

            saveas(gcf,[filename '.pdf']);         
           saveas(gcf,[filename '.jpeg']);

        end
        
    end    
 
end
