function loadfile(iFile)
%%
global info
global datadir_manuscript
for iFile = 1:length(info)
    iFile
    if info(iFile).has_rc==0

        % read in the opto files 
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
        try
            [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);
        catch
            TimeStamp = [];
        end                      
        TimeStampFirstIctal = info(iFile).seizure_onset+info(iFile).ictalspike*10^6;            
        TimeStampSeizureOnset = info(iFile).seizure_onset+info(iFile).seizure_autodetect_absolute*10^6;                
    else % write something new that produces the same stuff for RC
        % read in the data and the timestamps
        fieldSelection = ones(1,5);    
        extractHeader  = 1;
        [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(info(iFile).directory, 'optopulses.ntt'), fieldSelection,extractHeader, 1);

        if sum(diff(TimeStamp)>1.5*10^6)<10, 
            disp('no need to do this one'),continue, end   

        % compute the baseline rate
        rate_base(iFile) = MitraPaper_rate_opto(fullfile(info(iFile).directory, info(iFile).name), TimeStamp, info(iFile).nlevels,info(iFile).base_start_pulse, info(iFile).base_end_pulse);

        %ictal for RC files
        ts1 = info(iFile).injection_start_pulse;
        ts2 = info(iFile).seizure_onset_pulse;    
        TimeStampFirstIctal  = TimeStamp(ts2)  + info(iFile).ictalspike*10^6;               
        TimeStampSeizureOnset = TimeStamp(ts2) + info(iFile).seizure_autodetect_absolute*10^6;       
    end
            
    format long
    disp('first ictal timestamp')
    disp('seizure onset timestamp')
    TimeStampFirstIctal
    TimeStampSeizureOnset
    info(iFile).stable_until
    iFile
end
    