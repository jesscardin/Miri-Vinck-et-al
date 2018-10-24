function [] = Cardin01_lev0_readlfp(dirsel, overwrite)

global outputDirCardin2

% the analysis type, string to find data directories and name files
analysis  = 'lev0_readlfp';

fsdownsample = 2000;

% get the session information
info = Cardin01_lev0_info_01;

% loop over the various directories and read in the spike files
nDirs = length(info);
if nargin<1
  dirsel = 1:nDirs;
end

for iDir = dirsel

  outputDir = fullfile(outputDirCardin2, analysis,info(iDir).dir);
  mkdir(outputDir);
  outputFilename = fullfile(outputDir, analysis);
  if exist([outputFilename '.mat'], 'file') & overwrite==0, continue,end
  
  dataDir       = fullfile(info(iDir).root, info(iDir).dir);
  dirInfo      = dir(dataDir);  
  fileNames    = {}; names = {};
  cnt = 0;
  nFiles     = length(dirInfo);
  for iFile = 1:nFiles
    if isempty(strfind(dirInfo(iFile).name, 'LFP')) && isempty(strfind(dirInfo(iFile).name, 'lfp')), continue,end
    cnt = cnt + 1;
    names{cnt}     = dirInfo(iFile).name;
    fileNames{cnt} = fullfile(dataDir, dirInfo(iFile).name);
  end
  
  % check the nums and only copy those    
  nUnits = length(names);  
  num    = zeros(1,nUnits);
  for iUnit = 1:nUnits
    num(iUnit) = str2num(names{iUnit}(4));
  end
  
  isRecorded  = ismember(num, info(iDir).elecs);
  isReference = ismember(num, info(iDir).reference);
  isUnit = isRecorded & ~isReference;

  names = names(isUnit);
  fileNames = fileNames(isUnit);

  % check automatically how many timestamps to use and how many to get rid off
  dataAll = [];
  T_all   = [];
  for iFile = 1:length(fileNames)
  
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    try
      [TimeStamp,B,C,D,data,F] = Nlx2MatCSC_v3(fileNames{iFile}, fieldSelection,extractHeader, 1);      
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
  
  dataAll = [];
  for iFile = 1:length(fileNames)
  
    fieldSelection = ones(1,5);    
    extractHeader  = 1;
    try
      [TimeStamp,B,C,D,data,F] = Nlx2MatCSC_v3(fileNames{iFile}, fieldSelection,extractHeader, 1);      
    catch
      lasterr
      continue,
    end

    keepStamps = ismember(TimeStamp, goodStamps);
    TimeStamp  = TimeStamp(keepStamps);
    data       = data(:,keepStamps);
    %if any(keepStamps==0), keyboard; end
    % read in the header using FieldTrip
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

    % do the interpolation if something goes wrong here
    if any(unique(diff(TimeStamp))~=500) % sampling frequency
      % do interpolation
      newTs = TimeStamp(1):500:TimeStamp(end);
      data = interp1(TimeStamp, data, newTs);
      TimeStamp = newTs;
      disp('correcting the timestamps')
    end
    
    % rewrite the header to account for the subsampling
    hdr.nSamples           = length(data);    
    hdr.TimeStampPerSample = gapCorrectedTimeStampPerSample;
    hdr.TimeStampPerSample = double(hdr.TimeStampPerSample)*subSampleInterLeave;
    hdr.Fs                 = fsdownsample;
    
    % constrct a raw fieldtrip structure to save the wheel data to the disk and do further
    % analysis
    dataLfp.time{1}  = [0:hdr.nSamples-1]./hdr.Fs;
    dataLfp.trial{1} = data(:)';
    dataLfp.hdr      = hdr;
    dataLfp.fsample  = hdr.Fs;
    dataLfp.label    = {names{iFile}(1:end-4)};
    dataLfp.cfg      = [];
    dataLfp.time_timestamp{1} = TimeStamp(:)'; % this is not a standard fieldtrip field but we create it anyway    
    
    if ~isempty(dataAll)      
      dataAll = ft_appenddata([],dataAll,dataLfp);
    else
      dataAll = dataLfp;
    end
  end
  % save some information for how we saved the file, and the calling script itself
  S = dbstack;  
  dataAll.cfg.callinfo.file = S.file;
  dataAll.cfg.callinfo.date = date;
  if isfield(dataAll, 'trial')
    dataAll = ft_checkdata(dataAll, 'datatype', 'raw', 'feedback', 'yes');
  end
  filePath = which(S.file);

  cmd = ['cp ' filePath ' ' fullfile(outputDir, ['copy_' S.file])];
  unix(cmd);

  % save the data to the disk
  save(outputFilename, 'dataAll','-v7.3');  
end
  
  
  
  
  


