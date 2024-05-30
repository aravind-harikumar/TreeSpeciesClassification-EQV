%%find the largest value that will be used to compute the normalization in Height+Rho_Constant division

function [max_larg]=FindMaxCrownSpanTree(InputFolderLidar,species)
    
max_tree=0;
%maxradiusarr = [];
for iii = 1:size(species,2)
    
        path = [InputFolderLidar species{1,iii} '/'];
        trees = dir([path '*.las']);
        
    for jjj = 1:size(trees,1)
        
        P2 = read_LAS([path trees(jjj,1).name]);
        Xseed = P2(P2(:,3)==max(P2(:,3)),1);
        Yseed = P2(P2(:,3)==max(P2(:,3)),2);
              
        P2(:,1) = P2(:,1) - Xseed(1);
        P2(:,2) = P2(:,2) - Yseed(1);
        P2(:,3) = P2(:,3) - min(P2(:,3));
        P2(:,7)=sqrt(P2(:,1).^2+P2(:,2).^2);
        
        radius = quantile(sqrt((P2(:,1)).^2 + (P2(:,2)).^2),0.95 ); 
        
        %maxradiusarr = [maxradiusarr; radius];
        
        ii=1;
        for i=1:1:size(P2,1)
            if (sqrt((P2(i,1))^2 + (P2(i,2))^2))<=radius
                P(ii,:)=P2(i,:);
                ii=ii+1;
            end
        end
        
        if max_tree<max(P(:,7))
            max_tree=max(P(:,7));
        end
        
    end
    max_dir(iii)=max_tree;
end
%opp = [max(maxradiusarr), min(maxradiusarr), mean(maxradiusarr)]
max_larg=max(max_dir);

end