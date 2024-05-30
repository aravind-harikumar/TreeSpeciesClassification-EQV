%Height + Degree features extraction,

function [TRs,trees_tot]=GenerateEQVFeatureMain(InputFolderLidar, species, angular_div, radial_div, max_crown_span, max_crown_height, height_div, parameters)

TRs = cell(size(species,2),1);

for iii = 1:size(species,2)
    
    path = [InputFolderLidar species{1,iii} '/'];
    trees = dir([path '*.las']);
    sd = {};
    ooo =1;
    for jjj = 1:size(trees,1)
        
%         try
%             P2 = read_LAS([path trees(jjj,1).name]);
%             
%         catch
%             sd{ooo} = trees(jjj,1).name;
%             ooo = ooo+1;
%         end
%         Xseed = P2(P2(:,3)==max(P2(:,3)),1);
%         Yseed = P2(P2(:,3)==max(P2(:,3)),2);
%         
%         P2(:,1) = P2(:,1) - Xseed(1);
%         P2(:,2) = P2(:,2) - Yseed(1);
%         P2(:,3) = P2(:,3) - min(P2(:,3));
%         
%         %       plot3(P2(:,1), P2(:,2), P2(:,3),'.','MarkerSize',5,'Color',[0 0.5 0]);
%         %       axis([-5 5 -5 5 0 30]);
%         %       camproj perspective; rotate3d on; axis vis3d; axis equal; axis on; view(-45, 15); grid on;
%         
%         %deleting the lower points of the tree (from ground to 80 cm)
%         g = find(P2(:,3)<0.8);
%         P2(g(1),:) = 0;
%         g(1) = [];
%         P2(g,:) = [];
%         
%         radius = quantile(sqrt((P2(:,1)).^2 + (P2(:,2)).^2),0.95 );
%         
%         ii=1;
%         for i=1:1:size(P2,1)
%             if (sqrt((P2(i,1))^2 + (P2(i,2))^2))<=radius
%                 P(ii,:)=P2(i,:);
%                 ii=ii+1;
%             end
%         end
%         [P]=degpartition(P);

        % read and center lasdata.
        ALLDetails = dataPreProcessing(LoadData([path trees(jjj,1).name]));
        P2 = ALLDetails.lidarDataArray;
        
        %deleting the lower points of the tree (from ground to 80 cm)
        g = find(P2(:,3)<0.8);
        
        %selecting points of the tree within 0.95 percetile of the radius
        %(to remove noisy points)
        P2(g(1),:) = 0;
        g(1) = []; P2(g,:) = [];
        radius = quantile(sqrt((P2(:,1)).^2 + (P2(:,2)).^2),0.95);
        ii=1;
        for i=1:1:size(P2,1)
            if (sqrt((P2(i,1))^2 + (P2(i,2))^2))<=radius
                P(ii,:)=P2(i,:);
                ii=ii+1;
            end
        end
        
        % add angle detail i.e, direction of point around the stem  (for angualar quantization).
        [P]=degpartition(P);
        
        %% Generate Sectors
        %[hist_count]=hist_gen_rho_delta_radial_height_norm(P,n_step,deg_step,radial_step);
        [hist_count,IBF]=GetEQVFeatures(P,angular_div, radial_div, max_crown_span, max_crown_height, height_div, parameters);
        %[hist_coudnt]=hist_gen_deg(P,n_step,deg_step);
        %if you want to use the max tree step normalization,
        %you have to de-comment it inside hist_gen_deg function and comment this one
        if(parameters.isgloblaNorm)
            hist_count(1,IBF.radialIndices)=hist_count(1,IBF.radialIndices)/max(hist_count(1,IBF.radialIndices)); %%%%max tree normalization%%%%
            hist_count(1,IBF.radialIndices1)=hist_count(1,IBF.radialIndices1)/max(hist_count(1,IBF.radialIndices1)); %%%%max tree normalization%%%%
            hist_count(1,IBF.radialIndices2)=hist_count(1,IBF.radialIndices2)/max(hist_count(1,IBF.radialIndices2)); %%%%max tree normalization%%%%
            hist_count(1,IBF.radialIndices3)=hist_count(1,IBF.radialIndices3)/max(hist_count(1,IBF.radialIndices3)); %%%%max tree normalization%%%%
            hist_count(1,IBF.radialIndices4)=hist_count(1,IBF.radialIndices4)/max(hist_count(1,IBF.radialIndices4)); %%%%max tree normalization%%%%
            hist_count(1,IBF.radialIndices5)=hist_count(1,IBF.radialIndices5)/max(hist_count(1,IBF.radialIndices5)); %%%%max tree normalization%%%%
            hist_count(1,IBF.radialIndices6)=hist_count(1,IBF.radialIndices6)/max(hist_count(1,IBF.radialIndices6)); %%%%max tree normalization%%%%
            hist_count(1,IBF.heigthIndices)=hist_count(1,IBF.heigthIndices)/max(hist_count(1,IBF.heigthIndices)); %%%%max tree normalization%%%%
            hist_count(1,IBF.meanIndices)=hist_count(1,IBF.meanIndices)/max(hist_count(1,IBF.meanIndices)); %%%%max tree normalization%%%%
            hist_count(1,IBF.sdIndices)=hist_count(1,IBF.sdIndices)/max(hist_count(1,IBF.sdIndices)); %%%%max tree normalization%%%%
            hist_count(1,IBF.skewIndices)=hist_count(1,IBF.skewIndices)/max(hist_count(1,IBF.skewIndices)); %%%%max tree normalization%%%%
            hist_count(1,IBF.kurtIndices)=hist_count(1,IBF.kurtIndices)/max(hist_count(1,IBF.kurtIndices)); %%%%max tree normalization%%%%
            hist_count(1,IBF.heigthPDIndices)=hist_count(1,IBF.heigthPDIndices)/max(hist_count(1,IBF.heigthPDIndices)); %%%%max tree normalization%%%%
        end
        hist_count(isnan(hist_count)) = 0;
        hist_count_dir(jjj,:)=hist_count;
        clear P;
    end
    
    TRs{iii}=hist_count_dir;
    trees_tot{iii}=trees;
    clear hist_count_dir;  %in caso di cartelle con un numero differente di elementi
    
end
end
