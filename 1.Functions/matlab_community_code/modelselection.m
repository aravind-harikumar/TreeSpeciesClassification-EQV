function [param accy]= modelselection(X, Y, Xval, Yval, C, gamma)

classes = max(Y);
i=1;
accy=[];
param=[];
for c=1:size(C,2)
    for g=1:size(gamma,2)
        param = [param; C(c), gamma(g)]
        parameters = ['-t 2 -c ', num2str(C(c)), ' -g ',num2str(gamma(g))]; % identify model param
        accy(i)=SVMoneversusall_samecrossvalidation(X,Y',Xval,Yval',parameters);%OAA over validation data.
        i=i+1;
    end
end