function [hist_count_new]=tree_sector_control(hist_count,n_step,deg_step)

n_sector=360/deg_step; %number of sector
cont=1;
hist_count1=reshape(hist_count,n_step,n_sector);
hist_count2=hist_count1;
for i=1:n_step;
    a=median(hist_count1(i,:)); 
    a=round(a-0.4*a);
    for ang=1:n_sector
        if hist_count1(i,ang)<a
            ang1=ang+(n_sector/2); ang1=round(ang1);
            pos=mod(ang1,n_sector); 
            if pos==0 
                pos=round(n_sector/2); 
            end
            hist_count2(i,ang)=hist_count1(i,pos);
        end
    end
end
hist_count_new=reshape(hist_count2,1,n_sector*n_step);
% stem(hist_count)
% figure (2)
% stem(hist_count_new)
end