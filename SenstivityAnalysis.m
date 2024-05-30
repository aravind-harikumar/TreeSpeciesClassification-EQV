function [SensitivityMatrix,teststats] = SenstivityAnalysis(astepArr,rstep,hstep,InputFolderLidar,species,dataindice,parameters)

SensitivityMatrix =[]; TRs_deg ={}; TSs_deg={};
row_count = 1;

% get max radius among all trees in the folder
max_crown_span = FindMaxCrownSpanTree(InputFolderLidar,species); %trova larghezza massima
max_crown_height = find_max_heigth(InputFolderLidar,species); %trova larghezza massima

% Loop over elements in angular division array [1 4 8 12 16 24]
for angular_div=1:1:length(astepArr)
    
    % Loop over elements in radial division array
    for radial_div = rstep.min:rstep.step:rstep.max
        
        % Loop over elements in height division array
        for height_div = hstep.min:hstep.step:hstep.max
            
            % Generate EQV features
            [TSs_deg_tot, ~] = GenerateEQVFeatureMain(InputFolderLidar,...
                species, astepArr(angular_div), radial_div, max_crown_span, max_crown_height, height_div, parameters);
            
            for a=1:size(TSs_deg_tot,1)
                TRs_deg{a,1}=TSs_deg_tot{a,1}(dataindice.train,:);
                TSs_deg{a,1}=TSs_deg_tot{a,1}(dataindice.test,:);
            end
            
            %MainSVM_CV
            [AccTS, label_TS, teststats] = MainSVM_CV(TRs_deg,TSs_deg);
            
            %print result
            SensitivityMatrix(row_count,1:4)=[astepArr(angular_div) radial_div height_div AccTS];
            display([astepArr(angular_div) radial_div height_div AccTS]);
            
            row_count = row_count+1;
        end
        
    end
    
end

end

