function [S] = MitraPaper_getselections(R,Stat,reporCrit)

global info
include_rc_labels   = {'include_all','exclude_all_rc', 'include_rc_rs',  'only_rc'};
ptz_labels          = {'ptz', 'pilo', 'ptz_and_pilo'}; 
comparisons         = {'pv-som-rsnonfs', 'rsfs-rsnonfs', 'som-fs-som-nonfs', 'pv-fs-pv-nonfs', 'rs-nonfs-pv-som-rs-fs'};%;, 'rs-nonfs-nonpv'};
comparison_labels{1} = {'pv', 'rs-nonfs', 'som'};
comparison_labels{2} = {'rs-nonfs', 'rs-fs'};
comparison_labels{3} = {'som-fs', 'som-nonfs'}; 
comparison_labels{4} = {'pv-fs', 'pv-nonfs'};   
comparison_labels{5} = {'pv', 'rs-nonfs','som', 'rs-fs'};
%comparison_labels{6} = {'rs-nonfs','rs-nonfs-nonpv'};

color_labels{1} = {'g', 'k', 'b'};
color_labels{2} = {'k', 'r'};
color_labels{3} = {'c', 'm'};
color_labels{4} = {'g', 'r'};
color_labels{5} = {'g', 'k', 'b','r'};
%color_labels{6} = {'k', 'm'};

nSessions = length(R.neurontype);
info = info(1:nSessions);
rc_indx           = false(length(info),1);
for ii = 1:length(info)
    rc_indx(ii) = info(ii).has_rc;
end    
ptzsel = true(length(rc_indx),1);   
ptzsel([1:139 163:length(info)]) = false;
clear S;

isrsnonfs = false(length(info),1);
for k = 1:length(info)
    if ~isempty(info(k).RS_type) & strcmp(info(k).RS_type,'non-fs'), 
        isrsnonfs(k) = 1;
    end
end

exclude_instable = true(length(info),1);
exclude_instable([140 149 150]) = false;

exclude_bad = true(length(info),1);
exclude_bad([5 50]) = false;

for iDir = 1:length(info)
    cre{iDir} = info(iDir).cre;
end

for k = 1:length(info)
    R.neurontype{k} = info(k).neuron_type;
end


Stat.repor(168:197) = -1;

for include_rc = 1:4
    for doPtz = 1:3  
        if doPtz==2 & include_rc>1, continue,end 
        if doPtz==1
            drug_selection = ~ptzsel(:) & exclude_bad(:);
        elseif doPtz==2
            drug_selection = ptzsel(:) & exclude_instable(:) & exclude_bad(:);
        else
            drug_selection = (ptzsel(:) & exclude_instable(:)) | (~ptzsel(:) & exclude_bad(:));
        end            

        for iComparison = 1:length(comparisons)
            if iComparison==1                    
                % first select the PV and SOM
                selection = cell(1,3);
                for iType = [1 3]
                    if include_rc==1 
                        selection{iType} = R.neurontype_indx==iType & drug_selection; 
                    elseif include_rc==2 || include_rc==3
                        selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==0; 
                    elseif include_rc==4
                        selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==1;
                    end
                end              
                iType = 2;
                if include_rc==1 || include_rc==3
                    selection{iType} = R.neurontype_indx==iType & drug_selection & (Stat.repor<reporCrit | isrsnonfs); 
                elseif include_rc==2 
                    selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor<reporCrit | isrsnonfs); 
                elseif include_rc==4
                    selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor<reporCrit | isrsnonfs);
                end
            elseif iComparison==2
                selection = cell(1,2);
                iType = 2;
                if include_rc==1 ||  include_rc==3
                    selection{1} = R.neurontype_indx==iType & drug_selection & (Stat.repor<reporCrit | isrsnonfs); 
                elseif include_rc==2 
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor<reporCrit | isrsnonfs); 
                elseif include_rc==4
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor<reporCrit | isrsnonfs);
                end
                iType = 2;
                if include_rc==1  ||  include_rc==3
                    selection{2} = R.neurontype_indx==iType & drug_selection & (Stat.repor>reporCrit & ~isrsnonfs);
                elseif include_rc==2
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor>reporCrit & ~isrsnonfs); 
                elseif include_rc==4
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor>reporCrit & ~isrsnonfs);
                end
            elseif iComparison==3
                selection = cell(1,2);
                iType = 3;
                if include_rc==1 
                    selection{1} = R.neurontype_indx==iType & drug_selection & Stat.repor>reporCrit; 
                elseif include_rc==2 ||  include_rc==3
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & Stat.repor>reporCrit; 
                elseif include_rc==4
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & Stat.repor>reporCrit;
                end

                iType = 3;
                if include_rc==1 
                    selection{2} = R.neurontype_indx==iType & drug_selection & Stat.repor<reporCrit; 
                elseif include_rc==2 ||  include_rc==3
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & Stat.repor<reporCrit; 
                elseif include_rc==4
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & Stat.repor<reporCrit;
                end
            elseif iComparison==4
                selection = cell(1,2);
                iType = 1;
                if include_rc==1 
                    selection{1} = R.neurontype_indx==iType & drug_selection & Stat.repor>reporCrit; 
                elseif include_rc==2 ||  include_rc==3
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & Stat.repor>reporCrit; 
                elseif include_rc==4
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & Stat.repor>reporCrit;
                end

                iType = 1;
                if include_rc==1 
                    selection{2} = R.neurontype_indx==iType & drug_selection & Stat.repor<reporCrit; 
                elseif include_rc==2 ||  include_rc==3
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & Stat.repor<reporCrit; 
                elseif include_rc==4
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & Stat.repor<reporCrit;
                end                                        
            elseif iComparison==5
                selection = cell(1,4);
                for iType = [1]
                    if include_rc==1 
                        selection{iType} = R.neurontype_indx==iType & drug_selection; 
                    elseif include_rc==2 || include_rc==3
                        selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==0; 
                    elseif include_rc==4
                        selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==1;
                    end
                end      

                iType = 2;
                if include_rc==1 || include_rc==3
                    selection{3} = R.neurontype_indx==iType & drug_selection & (Stat.repor>reporCrit & ~isrsnonfs); 
                elseif include_rc==2 
                    selection{3} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor>reporCrit & ~isrsnonfs); 
                elseif include_rc==4
                    selection{3} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor>reporCrit & ~isrsnonfs);
                end

                for iType = [3]
                    if include_rc==1 
                        selection{4} = R.neurontype_indx==iType & drug_selection; 
                    elseif include_rc==2 || include_rc==3
                        selection{4} = R.neurontype_indx==iType & drug_selection & rc_indx==0; 
                    elseif include_rc==4
                        selection{4} = R.neurontype_indx==iType & drug_selection & rc_indx==1;
                    end
                end      
                
                iType = 2;
                if include_rc==1 || include_rc==3
                    selection{iType} = R.neurontype_indx==iType & drug_selection & (Stat.repor<reporCrit | isrsnonfs); 
                elseif include_rc==2 
                    selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor<reporCrit | isrsnonfs); 
                elseif include_rc==4
                    selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor<reporCrit | isrsnonfs);
                end
                
                
            elseif iComparison==6
                selection = cell(1,2);
                iType = 2;
                if include_rc==1 ||  include_rc==3
                    selection{1} = R.neurontype_indx==iType & drug_selection & (Stat.repor<reporCrit | isrsnonfs) & ~strcmp(cre,'PV')'; 
                elseif include_rc==2 
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor<reporCrit | isrsnonfs) & strcmp(cre,'PV')'; 
                elseif include_rc==4
                    selection{1} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor<reporCrit | isrsnonfs) & strcmp(cre,'PV')';
                end    
                
                if include_rc==1 ||  include_rc==3
                    selection{2} = R.neurontype_indx==iType & drug_selection & (Stat.repor<reporCrit | isrsnonfs) & strcmp(cre,'PV')'; 
                elseif include_rc==2 
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==0 & (Stat.repor<reporCrit | isrsnonfs) & strcmp(cre,'PV')'; 
                elseif include_rc==4
                    selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==1 & (Stat.repor<reporCrit | isrsnonfs) & strcmp(cre,'PV')';
                end    
            end                
            S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_logical = selection;
            for iSel = 1:length(selection)
                S.rc(include_rc).drug(doPtz).comparison(iComparison).selection_indx{iSel} = find(selection{iSel});
                S.rc(include_rc).drug(doPtz).comparison(iComparison).n(iSel) = sum(selection{iSel});
            end               
            S.rc(include_rc).drug(doPtz).comparison(iComparison).label = comparison_labels{iComparison};
            S.rc(include_rc).drug(doPtz).comparison(iComparison).drug_label = ptz_labels{doPtz};
            S.rc(include_rc).drug(doPtz).comparison(iComparison).rc_label = include_rc_labels{include_rc};
            S.rc_label = include_rc_labels;
            S.rc(include_rc).drug_label = ptz_labels;
            S.rc(include_rc).drug(doPtz).comparison_label = comparisons;
            S.rc(include_rc).drug(doPtz).comparison(iComparison).color_label = color_labels{iComparison};
        end
    end
end