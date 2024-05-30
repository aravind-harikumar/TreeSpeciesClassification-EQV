function [Xtrn,ttrn]=trainOAA(i_class,Xlabel,tlabel)

%% One against all, i_class is again all the other classes

 X1trn=zeros(1,size(Xlabel,2));
 X2trn=zeros(1,size(Xlabel,2));
 t1trn=[];
 t2trn=[];

%% One Against All

i_one=1;
i_all=1;

    for i_sample=1:1:size(Xlabel,1)
        if(tlabel(i_sample)==i_class)
            X1trn(i_one,:)=Xlabel(i_sample,:);
            t1trn(i_one)=+1;
            i_one=i_one+1;
        else
            X2trn(i_all,:)=Xlabel(i_sample,:);
            t2trn(i_all)=-1;
            i_all=i_all+1;
        end
    end

Xtrn=[X1trn;X2trn];
ttrn=[t1trn t2trn];
end