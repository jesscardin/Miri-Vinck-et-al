function [R] = MitraPaper_compute_rc_curves(nIctalPeriods,bins)

MitraPaper_info
global info
global datadir_manuscript
nFiles = length(info);
celltype = {};

for nIctalPeriods = [4]
    clear R
    coeffs_base = NaN(nFiles,8);
    coeffs_ictal = NaN(nFiles,nIctalPeriods+2,8);
    fitBase = NaN(nFiles,1000);
    fitIctal = NaN(nFiles,nIctalPeriods+2,1000);
    levAllBase = NaN(nFiles,1000);
    levAllIctal = NaN(nFiles,nIctalPeriods+2,1000);

    for iFile = 1:nFiles
        iFile
        if info(iFile).has_rc==0 || info(iFile).exclude_rc==1
           continue
        else % write something new that produces the same stuff for RC
            fieldSelection = ones(1,5);    
            extractHeader  = 1;
            [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);

            intens = [];
            for iLevel = 1:info(iFile).nlevels
                [rate_base(iFile).level(iLevel),intens(iLevel)] = MitraPaper_rate_opto_rc(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse,iLevel,squeeze(data(1,1,:)));
            end
       %   if ~issorted(intens), disp('intensities are not properly sorted, Mitra!'), keyboard, end
            prob1 = []; prob2 = []; prob2_booty = [];
            for iLevel = 1:info(iFile).nlevels
                prob1(iLevel) = mean(rate_base(iFile).level(iLevel).trial);
                prob2(iLevel) = mean(double(rate_base(iFile).level(iLevel).trial>0));   
            end

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
            elseif info(iFile).exclude_rc_numlevels ==2
                levels = levels(1:end-2);
                responses = responses(1:end-2);
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
                W_coef = fminsearch(@MitraPaper_sig,[xx(k) yy(k) zz(k) ww(k)]); % minimizes the error by fitting the parameters 
                yhats = W_coef(1) + W_coef(2)./(1+exp(-(levels-W_coef(3))/W_coef(4)));
                err(cnt) = sum(abs(responses - yhats).^2);
                W_coeff_all(cnt,:) = W_coef;
            end
            [val,mn] = min(err); % finds the best fit across all initializations
            origerr = var(responses);
            Rsq = 1-err(mn)./origerr;
            W_coef = W_coeff_all(mn,:);
            levelinterp = linspace(levels(1), levels(end), 1000);
            yhat = W_coef(1) + W_coef(2)./(1+exp(-(levelinterp-W_coef(3))/W_coef(4)));

            % find the 50 % point
            perc_point50 = 0.5*(max(yhat)-min(yhat)) + yhat(1);
            indx = nearest(yhat,perc_point50);
            coeffs_base(iFile,:) = [W_coef levelinterp(indx) yhat(1) yhat(end) perc_point50];
         %   keyboard
            
            levLog = log10(levelinterp./levelinterp(indx));
            levAllBase(iFile,:) = levLog;
            fitBase(iFile,:) = yhat;
            
            %ictal for RC files
            ts1 = info(iFile).injection_start_pulse;
            ts2 = info(iFile).seizure_onset_pulse; 

          %ictal for RC files
            ts22 = info(iFile).seizure_onset_pulse;    
            ts22  = TimeStamp(ts22) + info(iFile).ictalspike*10^6;                  
            ts22 = nearest(TimeStamp,ts22);
            ts2  = ts22;
            m1 = mod(info(iFile).injection_start_pulse,info(iFile).nlevels);
            m2 = mod(ts2,info(iFile).nlevels);
            d = m1-m2;
            ts2 = ts2 + d;

    %keyboard        
            ts33 = ts2;
            ts33  = TimeStamp(ts33) + 45*10^6;                  
            ts33 = nearest(TimeStamp,ts33);
            ts3  = ts33;
            m1 = mod(info(iFile).injection_start_pulse,info(iFile).nlevels);
            m2 = mod(ts3,info(iFile).nlevels);
            d = m1-m2;
            ts3 = ts3 + d;
            if ts3>length(TimeStamp)-info(iFile).nlevels
                ts3 = length(TimeStamp)-info(iFile).nlevels;
            end

            ts44 = ts2;
            ts44  = TimeStamp(ts44) + 90*10^6;                  
            ts44 = nearest(TimeStamp,ts44);
            ts4  = ts44;
            m1 = mod(ts2,info(iFile).nlevels);
            m2 = mod(ts4,info(iFile).nlevels);
            d = m1-m2;
            ts4 = ts4 + d;
            if ts4>length(TimeStamp)-info(iFile).nlevels
                ts4 = length(TimeStamp)-info(iFile).nlevels;
            end

            
            startsIctal = [ts2 : info(iFile).nlevels : ts3];

            startsSeizure = [ts3 : info(iFile).nlevels : ts4];
        
            starts = [info(iFile).injection_start_pulse : info(iFile).nlevels : ts22];
            nn  = round(linspace(1, length(starts), nIctalPeriods+1)); 
            for iIctalPeriod = 1:nIctalPeriods+2
            %     [rc_ictal(iFile,iIctalPeriod)] = ...
            %     Mitra01_rate_opto(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,ts(iIctalPeriod), ts(iIctalPeriod+1));


               if iIctalPeriod==nIctalPeriods+1
                   if length(startsIctal)<2, continue,end
                   tsStart = startsIctal(1);
                   tsEnd   = startsIctal(end);
               elseif iIctalPeriod==nIctalPeriods+2
                   if length(startsSeizure)<2, continue,end               
                   tsStart = startsSeizure(1);
                   tsEnd   = startsSeizure(end);
               else                              
                tsStart = starts(nn(iIctalPeriod));
                tsEnd   = starts(nn(iIctalPeriod+1))-1;
               end
            
%               tsStart = starts(nn(iIctalPeriod));
 %              tsEnd   = starts(nn(iIctalPeriod+1))-1;
               intens = [];
               for iLevel = 1:info(iFile).nlevels
                    [rate_ictal(iFile).level(iLevel),intens(iLevel)] = MitraPaper_rate_opto_rc(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,tsStart,tsEnd,iLevel,squeeze(data(1,1,:)));
                end
             %   if ~issorted(intens), disp('intensities are not properly sorted, Mitra!'), keyboard, end
                % do sigmoid fit
                prob1 = []; prob2 = []; 
                for iLevel = 1:info(iFile).nlevels
                    prob1(iLevel) = mean(rate_ictal(iFile).level(iLevel).trial);
                    prob2(iLevel) = mean(double(rate_ictal(iFile).level(iLevel).trial>0));   
                end
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
                elseif info(iFile).exclude_rc_numlevels ==2
                    levels = levels(1:end-2);
                    responses = responses(1:end-2);
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
                    W_coef = fminsearch(@MitraPaper_sig,[xx(k) yy(k) zz(k) ww(k)]);
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
                perc_point50 = 0.5*(max(yhat)-min(yhat)) + yhat(1);
                indx = nearest(yhat,perc_point50);
                coeffs_ictal(iFile,iIctalPeriod,:) = [W_coef levelinterp(indx) yhat(1) yhat(end) perc_point50];  
                
                levLog = log10(levelinterp./levelinterp(indx));
                levAllIctal(iFile,iIctalPeriod,:) = levLog;
                fitIctal(iFile,iIctalPeriod,:) = yhat;
            
            
            end
        end        
        celltype{iFile} = info(iFile).neuron_type;       
    end

    % concatenate all the data and give it back as a result structure
    R.coeffs_base = coeffs_base;
    R.coeffs_ictal = coeffs_ictal;
    R.fitIctal = fitIctal;
    R.fitBase  = fitBase;
    R.levAllIctal = levAllIctal;
    R.levAllBase = levAllBase;
    
    outputdir = fullfile(datadir_manuscript, 'rc');
    mkdir(outputdir)
    str = ['rc_' num2str(nIctalPeriods)];
    filename = fullfile(outputdir, str);
    save(filename, 'R');
end





    
    



