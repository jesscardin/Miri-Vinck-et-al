function [] = Mitra01_batch_getwaveforms(dirsel)

% Requires STARTUP_OPTO to be run
%
% changed 4/9/2015 by Mitra Miri and Martin Vinck

% just setting some globals
addpath('C:\Users\Mitra\Documents\4Mitra\Code\Common\Various\')
Mitra01_info;
global info
n_files = length(info);

if nargin<1
    dirsel = 1:n_files;
end

% loop over files
for i_file = dirsel(:)'		
    
    dataDir = info(i_file).directory_brain;
    dirInfo      = dir(dataDir);  
    fileNames    = {}; names = {};
    cnt = 0;
    nFiles     = length(dirInfo);
    for iFile = 1:nFiles
      if isempty(strfind(dirInfo(iFile).name, 'MU')), continue,end
      if ~isempty(strfind(dirInfo(iFile).name, 'dat')), continue,end
      cnt = cnt + 1;
      names{cnt}     = dirInfo(iFile).name;
      fileNames{cnt} = fullfile(dataDir, dirInfo(iFile).name);
    end

    % check the nums and only copy those    
    nUnits = length(names);  
    num    = zeros(1,nUnits);
    for iUnit = 1:nUnits
      num(iUnit) = str2num(names{iUnit}(3:4));
    end

    celnum = str2num(info(i_file).name(3));
    beg    = (celnum-1)*4+1;
    ed     = (celnum)*4;
    
    numbers = beg:ed;
    if ~isempty(info(i_file).munumbers)
        numbers = info(i_file).munumbers;
    end
    isRecorded  = ismember(num, numbers);
    isUnit = isRecorded;

    names = names(isUnit);
    fileNames = fileNames(isUnit);

    fieldSelection = ones(1,5);    
    extractHeader  = 1;
   
    [TimeStamp,B,C,D,data,F] = Nlx2MatSpike(fullfile(dataDir, ['TT', num2str(celnum) '.ntt']), fieldSelection,extractHeader, 1);  % in mitra
    % check automatically how many timestamps to use and how many to get rid off
    dataAll = [];
    T_all   = [];
    
    for iFile = 1:length(fileNames)

      fieldSelection = ones(1,5);    
      extractHeader  = 1;
      try
        [TimeStamp,B,C,D,data,F] = Nlx2MatCSC(fileNames{iFile}, fieldSelection,extractHeader, 1);  % in mitra
      catch
        lasterr
        continue,
      end
      T_all = [T_all TimeStamp];
    end  

    % do the histogram on the timestamps to see which channels have the common timestamps
    [A,B,C] = unique(T_all);
    N = histc(T_all, A);
    hasAllChans = N==max(N);
    fprintf('keeping %d out of %d timestamps for %s', sum(hasAllChans), length(N), dataDir);
    goodStamps = A(hasAllChans);

    fsdownsample = 40000;
    spikedata = load(fullfile(info(i_file).directory, info(i_file).name));
    wave = squeeze(nanmean(spikedata.spike.waveform{1},1));
    E    = var(wave,[],2);
    [val,ind] = max(E);
    wv  = [];
    
   % wv = zeros(size(spikedata.spike.waveform{1},1), 
    for iFile = 1:length(fileNames)

      fieldSelection = ones(1,5);    
      extractHeader  = 1;
      try
        [TimeStamp,B,C,D,data,F] = Nlx2MatCSC(fileNames{iFile}, fieldSelection,extractHeader, 1);      
      catch
        lasterr
        continue,
      end

      keepStamps = ismember(TimeStamp, goodStamps);
      TimeStamp  = TimeStamp(keepStamps);
      data       = data(:,keepStamps);
      hdr = ft_read_header(fileNames{iFile});

      fprintf('Processing %s\n', fileNames{iFile});

      % extract information frmo the data
      Fs        = hdr.Fs;
      NRecords  = length(TimeStamp); % number of blocks of 512
      blockSize = size(data,1);
      if blockSize~=512, error('the expected block size was 512, something changed in Neuralynx format, please check'); end

      % see if there are any gaps in the data
      d = double(TimeStamp(2:end)-TimeStamp(1:end-1));
      d = d(:);
      maxJump  = ceil(10^6./(Fs-1))*blockSize;
      gapCorrectedTimeStampPerSample =  nanmean(d(d<maxJump),1)/512;    
      ts1 = TimeStamp(1);
      tsE = TimeStamp(end);  

      % check if some block has a wrong timestamp
      minJump = min(d);
      ts_range_predicted = (NRecords-1)*blockSize*gapCorrectedTimeStampPerSample;
      ts_range_observed  = double(tsE-ts1);
      if abs(ts_range_predicted-ts_range_observed)>minJump
         warning('discontinuous recording, predicted number of timestamps and observed number of timestamps differ by %2.2f \n Please consult the wiki on http://fieldtrip.fcdonders.nl/getting_started/neuralynx?&#discontinuous_recordings',...
           abs(ts_range_predicted-ts_range_observed) );       
      end

      % sort the timestamps, sometimes the blocks get out of order with neuralynx
      [val,indx] = sort(TimeStamp);
      [A,I] = unique(val); % consider only the unique values
      indx = indx(I);

      % create subsubsample interleave to 2kHz to save space, we don't need 40k for this analysis
      subSampleInterLeave = hdr.Fs/fsdownsample;
      data         = data(:,indx);
      TimeStamp    = TimeStamp(indx);
      data         = data(:); % make a vector from the data
      data         = data(1:subSampleInterLeave:end);

      % interpolate the timestamps within each block and get one timestamp per sample from this
      TimeStamp = repmat(TimeStamp, [blockSize 1]); 
      TimeStampPerSecond = 10^6; % this is always the case with the digital lynx
      addTs      = [0:(TimeStampPerSecond/hdr.Fs):(blockSize-1)*(TimeStampPerSecond/hdr.Fs)]';
      addTs      = repmat(addTs,[1 size(TimeStamp,2)]);
      TimeStamp = TimeStamp + addTs; % add the interpolated number of timestamps per block timestamp
      TimeStamp = TimeStamp(:);
      TimeStamp = TimeStamp(1:subSampleInterLeave:end);

      % rewrite the header to account for the subsampling
      hdr.nSamples           = length(data);    
      hdr.TimeStampPerSample = gapCorrectedTimeStampPerSample;
      hdr.TimeStampPerSample = double(hdr.TimeStampPerSample)*subSampleInterLeave;
      hdr.Fs                 = fsdownsample;

      spikedata = load(fullfile(info(i_file).directory, info(i_file).name));
      [N,B]=histc(spikedata.spike.timestamp{1},TimeStamp);
   
      % now we need to cut out the waveforms quickly.
      lp = linspacevec(B-60, B+61, 122);
      todel = any(lp<0 | lp>length(data),2);
      lp(todel,:) = [];
      wv(iFile,:,:) = data(lp) ;   
      iFile
      i_file
    end            
    spike.timestamp{1} = spikedata.spike.timestamp{1}(~todel);
    spike.waveform{1} = permute(wv,[2 1 3]);
    spike.label{1} = spikedata.spike.label;
    spike.hdr      = spikedata.spike.hdr;            
    
    % save this file
    filename = fullfile(info(i_file).directory, [info(i_file).name '_wvlong']);
    save(filename, 'spike')
end     