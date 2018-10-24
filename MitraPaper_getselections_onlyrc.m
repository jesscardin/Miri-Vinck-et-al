function [S] = MitraPaper_getselections(R,Stat,reporCrit)

global info
include_rc_labels = {'include_all','exclude_all_rc', 'include_rc_rs',  'only_rc'};
ptz_labels        = {'ptz', 'pilo'}; 
comparisons       = {'pv-som', 'som-fs-som-nonfs'};
comparison_labels{1} = {'pv', 'som'};
comparison_labels{2} = {'som-fs', 'som-nonfs'}; 
color_labels{1} = {'g', 'b'};
color_labels{2} = {'c', 'm'};

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

for include_rc = 4
    for doPtz = 1  
        if doPtz==1
            drug_selection = ~ptzsel;
        else
            drug_selection = ptzsel;
        end

        for iComparison = 1:length(comparisons)
            if iComparison==1                    
                % first select the PV and SOM
                selection = cell(1,2);
                for iType = [1]
                    if include_rc==1 
                        selection{iType} = R.neurontype_indx==iType & drug_selection; 
                    elseif include_rc==2 || include_rc==3
                        selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==0; 
                    elseif include_rc==4
                        selection{iType} = R.neurontype_indx==iType & drug_selection & rc_indx==1;
                    end
                end              
                
               for iType = [3]
                    if include_rc==1 
                        selection{2} = R.neurontype_indx==iType & drug_selection; 
                    elseif include_rc==2 || include_rc==3
                        selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==0; 
                    elseif include_rc==4
                        selection{2} = R.neurontype_indx==iType & drug_selection & rc_indx==1;
                    end
                end              

            elseif iComparison==2
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
            elseif iComparison==3
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