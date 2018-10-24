 function [R] = Mitra01_main_isi_RC_v1(nIctalPeriods,bins)
%
if nargin<2
    bins = 0:0.002:1;
end
Mitra01_info;
global info
global figuredir
figuredir_file = fullfile(figuredir, 'rc_curves_fits');
mkdir(figuredir_file);

nFiles = length(info);
%[isi_base, logratio_base, rate_base, isi_ictal, logratio_base, rate_ictal, isi_seizure, logratio_seizure, rate_seizure] = deal([]);
celltype = {};
coeffs_base = NaN(nFiles,7);
coeffs_ictal = NaN(nFiles,nIctalPeriods,7);
for iFile =1:nFiles
    iFile
    iFile
    if info(iFile).has_rc==0 || info(iFile).exclude_rc==1
       continue
    else % write something new that produces the same stuff for RC
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
        [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
     
        intens = [];
        for iLevel = 1:info(iFile).nlevels
            [rate_base(iFile).level(iLevel),intens(iLevel)] = Mitra01_rate_opto_rc(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse,iLevel,squeeze(data(1,1,:)));
        end
       if ~issorted(intens), disp('intensities are not properly sorted, Mitra!'), keyboard, end
        % do sigmoid fit
        prob1 = []; prob2 = []; prob2_booty = [];
        for iLevel = 1:info(iFile).nlevels
            prob1(iLevel) = mean(rate_base(iFile).level(iLevel).trial);
            prob2(iLevel) = mean(double(rate_base(iFile).level(iLevel).trial>0));   
            % derive a standard error estimate
            for iBooty = 1:100
                nTrials = size(rate_base(iFile).level(iLevel).trial,1);
                randsmp = randsample(nTrials,nTrials,true);
                prob2_booty(iLevel,iBooty) =  mean(double(rate_base(iFile).level(iLevel).trial(randsmp)>0)); 
            end
        end
        sm = nanstd(prob2_booty,[],2);
        if length(info(iFile).light_levels)~=info(iFile).nlevels, disp('number levels doesnt match'), keyboard; end
        global levels
        global responses
        responses = prob2;
        if info(iFile).nlevels>length(info(iFile).light_levels)
            indx = 1:length(info(iFile).light_levels);
        else
            indx = 1:info(iFile).nlevels;
        end
        responses = responses(indx);
        levels = info(iFile).light_levels;     
        
        if info(iFile).exclude_rc_numlevels ==0
%            levels = info(iFile).light_levels;     
            
        elseif info(iFile).exclude_rc_numlevels ==1
            levels = levels(1:end-1);
            responses = responses(1:end-1);
            sm = sm(1:end-1);            
        elseif info(iFile).exclude_rc_numlevels ==2
            levels = levels(1:end-2);
            responses = responses(1:end-2);
            sm = sm(1:end-2);
        end
            
            
        % make the selection of the light levels
        % baseline + scale + 50 perc point + slope
        [xx,yy,zz,ww] = ndgrid(0:0.25:1, 0:0.25:1, linspace(levels(1), levels(end), 3), 0:1:4); % creates a grid for all the parameters, to have different optimization
        xx = xx(:); yy = yy(:); zz = zz(:); ww = ww(:);
        n = size(xx,1);
        err = [];
        cnt = 0;
        for k = 1:10:n % loops over all the whole grid (just put to 10 for speed)
            cnt = cnt + 1;
            %k
            W_coef = fminsearch(@Mitra01_sig,[xx(k) yy(k) zz(k) ww(k)]); % minimizes the error by fitting the parameters 
            yhats = W_coef(1) + W_coef(2)./(1+exp(-(levels-W_coef(3))/W_coef(4)));
            err(cnt) = var(responses - yhats);
            W_coeff_all(cnt,:) = W_coef;
        end
        [val,mn] = min(err); % finds the best fit across all initializations
        origerr = var(responses);
        Rsq = 1-err(mn)./origerr;
        W_coef = W_coeff_all(mn,:);
        levelinterp = linspace(levels(1), levels(end), 1000);
        yhat = W_coef(1) + W_coef(2)./(1+exp(-(levelinterp-W_coef(3))/W_coef(4)));
         
        W_coef = fminsearch(@Mitra01_sig,[0 1 1 1]);
        levelinterp = linspace(levels(1), levels(end), 1000);
        yhat2 = W_coef(1) + W_coef(2)./(1+exp(-(levelinterp-W_coef(3))/W_coef(4)));
        
        % find the 50 % point
        perc_point50 = 0.5*(max(yhat2)-min(yhat2)) + yhat2(1);
        indx = nearest(yhat2,perc_point50);
        coeffs_base(iFile,:) = [W_coef levelinterp(indx) yhat2(1) yhat2(end)];
        figure, 
        plot(levelinterp, yhat2,'k')
        hold on
        plot([levelinterp(indx) levelinterp(indx)], [0 1],'k')
        
        %ictal for RC files
        ts1 = info(iFile).injection_start_pulse;
        ts2 = info(iFile).seizure_onset_pulse; 
        starts = [info(iFile).injection_start_pulse : info(iFile).nlevels : info(iFile).seizure_onset_pulse];
        nn  = round(linspace(1, length(starts), nIctalPeriods+1)); 
        for iIctalPeriod = 1:nIctalPeriods
        %     [rc_ictal(iFile,iIctalPeriod)] = ...
        %     Mitra01_rate_opto(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,ts(iIctalPeriod), ts(iIctalPeriod+1));
          
           tsStart = starts(nn(iIctalPeriod));
           tsEnd   = starts(nn(iIctalPeriod+1))-1;
           intens = [];
           for iLevel = 1:info(iFile).nlevels
                [rate_ictal(iFile).level(iLevel),intens(iLevel)] = Mitra01_rate_opto_rc(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,tsStart,tsEnd,iLevel,squeeze(data(1,1,:)));
            end
            if ~issorted(intens), disp('intensities are not properly sorted, Mitra!'), keyboard, end
            % do sigmoid fit
            prob1 = []; prob2 = []; prob2_booty = [];
            for iLevel = 1:info(iFile).nlevels
                prob1(iLevel) = mean(rate_ictal(iFile).level(iLevel).trial);
                prob2(iLevel) = mean(double(rate_ictal(iFile).level(iLevel).trial>0));   
                % derive a standard error estimate
                for iBooty = 1:100
                    nTrials = size(rate_ictal(iFile).level(iLevel).trial,1);
                    randsmp = randsample(nTrials,nTrials,true);
                    prob2_booty(iLevel,iBooty) =  mean(double(rate_ictal(iFile).level(iLevel).trial(randsmp)>0)); 
                end
            end
            sm = nanstd(prob2_booty,[],2);
            if length(info(iFile).light_levels)~=info(iFile).nlevels, disp('number levels doesnt match'), keyboard; end
            global levels
            global responses
            responses = prob2;
            if info(iFile).nlevels>length(info(iFile).light_levels)
                indx = 1:length(info(iFile).light_levels);
            else
                indx = 1:info(iFile).nlevels;
            end
            responses = responses(indx);
            levels = info(iFile).light_levels;     

            if info(iFile).exclude_rc_numlevels ==0
    %            levels = info(iFile).light_levels;     

            elseif info(iFile).exclude_rc_numlevels ==1
                levels = levels(1:end-1);
                responses = responses(1:end-1);
                sm = sm(1:end-1);                        
            elseif info(iFile).exclude_rc_numlevels ==2
                levels = levels(1:end-2);
                responses = responses(1:end-2);
                sm = sm(1:end-2);                        
            end

            % make the selection of the light levels

            [xx,yy,zz,ww] = ndgrid(0:0.25:1, 0:0.25:1, linspace(levels(1), levels(end), 3), 0:1:4);
            xx = xx(:); yy = yy(:); zz = zz(:); ww = ww(:);
            n = size(xx,1);
            err = [];
            cnt = 0;
            for k = 1:10:n 
                cnt = cnt + 1;
                %k
                W_coef = fminsearch(@Mitra01_sig,[xx(k) yy(k) zz(k) ww(k)]);
                yhats = W_coef(1) + W_coef(2)./(1+exp(-(levels-W_coef(3))/W_coef(4)));
                err(cnt) = var(responses - yhats);
                W_coeff_all(cnt,:) = W_coef;
            end
            [val,mn] = min(err);
            origerr = var(responses);
            Rsq = 1-err(mn)./origerr;
            W_coef = W_coeff_all(mn,:);
            levelinterp = linspace(levels(1), levels(end), 1000);
            yhat = W_coef(1) + W_coef(2)./(1+exp(-(levelinterp-W_coef(3))/W_coef(4)));

            %W_coef = fminsearch(@Mitra01_sig,[0 1 1 1]);
            %levelinterp = linspace(levels(1), levels(end), 1000);
            % find the 50           
            perc_point50 = 0.5*(max(yhat)-min(yhat)) + yhat(1);
            indx = nearest(yhat,perc_point50);
            coeffs_ictal(iFile,iIctalPeriod,:) = [W_coef levelinterp(indx) yhat(1) yhat(end)];
            if iIctalPeriod==nIctalPeriods
                hold on
                plot(levelinterp, yhat,'r')
                hold on
                plot([levelinterp(indx) levelinterp(indx)], [0 1],'r')
            end
        end
    end        
    celltype{iFile} = info(iFile).neuron_type;       
end

% concatenate all the data and give it back as a result structure
R.coeffs_base = coeffs_base;
R.coeffs_ictal = coeffs_ictal;
    
    




    
    



