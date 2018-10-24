 function [] = MitraPaper_waveformparameters
%%
global info
global datadir_manuscript
global figuredir_manuscript
global figuredir

outputDir = fullfile(datadir_manuscript, 'waves');
mkdir(outputDir)
nFiles = length(info);

%%
ttnames = {}; dirnames = {};
for k = 1:length(info)
    [a,b]= fileparts(info(k).directory);
    dirnames{k} = b;
    ttnames{k} = info(k).name;
end
%%
outputDir = fullfile(figuredir, 'waves');
dirInfo = dir(outputDir);
wvAll = [];
celltype = {};
for k = 3:length(dirInfo)
    indx = strfind(dirInfo(k).name,'_');
    indx2 = strfind(dirInfo(k).name, 'TT');
    isdir = (strcmp(dirnames,dirInfo(k).name(indx(1)+1:indx2-2)));
    ttname = dirInfo(k).name(indx2:end-4);
    isunit = strcmp(ttnames,ttname);
    indx = find(isdir & isunit);
    inp = load(fullfile(outputDir, dirInfo(k).name));
    %inp.iFile = indx(1);
    if isempty(indx), continue,end
    celltype{indx(1)} = inp.celltype{inp.iFile};
    if info(inp.iFile).exclude_waveform==1
        celltype{indx(1)} = 'ignore';
    end
    wvAll(indx(1),:) = inp.wv.avg(1,inp.ind,:);
    mn = wvAll(indx(1),:);
    ed = nearest(inp.wv.time,0.001);
   [vl,iup]   = nanmax(mn(1:end));
   [vl,idown] = nanmin(mn(iup:ed));
   idown = idown + iup - 1;
   [nLeads nSamples nSpikes] = size(mn);          
   % --- normalize amplitude ratio of spike waveforms if requested
   r = mn(:,iup)-mn(:,idown);
   mn = 2*mn./ repmat(r,1,nSamples); %makes it have amp of 2
   mn = mn + -repmat(mn(:,idown)+1,1,nSamples); % put the minus on -1    
   wvAll(indx(1),:) = mn;
end
%%    
wv = inp.wv;
ispv = (strcmp(celltype,'PV'));
issom = (strcmp(celltype,'SOM'));
isrs = (strcmp(celltype,'RS'));

ct = nearest(wv.time,0);
ed = nearest(inp.wv.time,0.001);

[val,mx] = nanmax(wvAll(:,:),[],2);
[val,mn] = nanmin(wvAll(:,ct:ed),[],2);
mn = mn + ct - 1;
p2t = 1000*(mn-mx)/40000;

ct2 = nearest(wv.time,0.0009);
repor = (wvAll(:,ct2));

Stat.repor = repor;
Stat.p2t   = p2t;
Stat.ispv  = ispv;
Stat.issom = issom;
Stat.isrs  = isrs;
Stat.time  = inp.wv.time;
Stat.wvAll = wvAll;

filename = fullfile(datadir_manuscript, 'waveform_parameters', 'waveform_parameters');
mkdir(fullfile(datadir_manuscript, 'waveform_parameters'));
save(filename, 'Stat');


