clear;clc


n_step=60; % 60:10:150 #
deg_step=30; % 15:5:45 deg

TRs = cell(4,1);
InputFolderLidar = [cd('.') '/ManuallySegmentedDataset_new/Dataset_50_trees/'];
species = {'ab','ar','la','pc'};

for iii = 3%:4
    
    path = [InputFolderLidar species{1,iii} '/'];
    trees = dir([path '*.las']);
    
    for jjj = 20%:size(trees,1)
        
        P2 = read_LAS([path trees(jjj,1).name]);        
        Xseed = P2(P2(:,3)==max(P2(:,3)),1);
        Yseed = P2(P2(:,3)==max(P2(:,3)),2);        
        
        P2(:,1) = P2(:,1) - Xseed(1);
        P2(:,2) = P2(:,2) - Yseed(1);
        P2(:,3) = P2(:,3) - min(P2(:,3));
        
        radius = quantile(sqrt((P2(:,1)).^2 + (P2(:,2)).^2),0.95 );
        
        ii=1;
        for i=1:1:size(P2,1)
            if (sqrt((P2(i,1))^2 + (P2(i,2))^2))<=radius
                P(ii,:)=P2(i,:);
                ii=ii+1;
            end
        end
        
        %% symmetry
        [P_simm]=symmetry(P,n_step,deg_step);
        P_simm=degpartition(P_simm);
        %% generate sectors
        [hist_count1]=hist_gen_deg(P_simm,n_step,deg_step);
        hist_count1=hist_count1/sum(hist_count1);
        hist_count_dir(jjj,:)=hist_count1;
        clear P;
    end
    TRs{iii}=hist_count_dir;
    clear hist_count_dir;  %in caso di cartelle con un numero differente di elementi

end

%scatter3(P(:,1),P(:,2),P(:,3),30,P(:,3),'filled') %per vedere l'albero