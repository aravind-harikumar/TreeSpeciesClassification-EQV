%%label control funtion, generate a .mat that indicate the mislabeled samples

function [label_check]=label_control(trees,label)
cont=1;
for i=1:20 %iterator nuber are fixed for this dataset, if the dataset will change in size, these value should be changed 
    if label(i,1)~=1        
        Corr_Label(cont)=1;
        Assigned_Label(cont)=label(i,1);
        tree(cont)={trees{1,1}(i,1).name};
        cont=cont+1;
    end
end
for i=21:40 %iterator nuber are fixed for this dataset, if the dataset will change in size, these value should be changed
    if label(i,1)~=2        
        Corr_Label(cont)=2;
        Assigned_Label(cont)=label(i,1);
        tree(cont)={trees{1,2}(i-20,1).name};
        cont=cont+1;
    end
end
for i=41:60 %iterator nuber are fixed for this dataset, if the dataset will change in size, these value should be changed
    if label(i,1)~=3        
        Corr_Label(cont)=3;
        Assigned_Label(cont)=label(i,1);
        tree(cont)={trees{1,3}(i-40,1).name};
        cont=cont+1;
    end
end
for i=61:80 %iterator nuber are fixed for this dataset, if the dataset will change in size, these value should be changed
    if label(i,1)~=4       
        Corr_Label(cont)=4;
        Assigned_Label(cont)=label(i,1);
        tree(cont)={trees{1,4}(i-60,1).name};
        cont=cont+1;
    end
end
label_check=table(Corr_Label',Assigned_Label',tree');

end