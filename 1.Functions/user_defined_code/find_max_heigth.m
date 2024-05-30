%%find the largest value that will be used to compute the normalization in Height+Rho_Constant division
function [max_larg]=find_max_heigth(InputFolderLidar,species)
%max_tree=0;
%InputFolderLidar = '';
%InputFolderLidar = [cd('.') '/2.Dataset/ManuallySegmentedDataset_new/Dataset_50_trees/'];
%species = {'ar','la','pc','ab'};
max_tree_height = 0;
maxhtArr = [];
%max_dir =[];
for iii = 1: size(species,2)  
    path = [InputFolderLidar species{1,iii} '/'];
    trees = dir([path '*.las']);

    for jjj = 1:size(trees,1)

    ALLDetails = dataPreProcessing(LoadData([path trees(jjj,1).name]));
    P2 = ALLDetails.lidarDataArray;
    %P2 = read_LAS([path trees(jjj,1).name]);
    Xseed = P2(P2(:,3)==max(P2(:,3)),1);
    Yseed = P2(P2(:,3)==max(P2(:,3)),2);

    P2(:,1) = P2(:,1) - Xseed(1);
    P2(:,2) = P2(:,2) - Yseed(1);
    P2(:,3) = P2(:,3) - min(P2(:,3));

   % maxhtArr = [maxhtArr; max(P2(:,3))];
    if max_tree_height<max(P2(:,3))
        max_tree_height = max(P2(:,3));
    end

    end
max_dir(iii)=max_tree_height;
end

%opp = [max(maxhtArr), min(maxhtArr), mean(maxhtArr)]

max_larg=max(max_dir);

end





% 43.62