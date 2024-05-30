function [accuracy,ConfusionMatrix,realpredict] = CalculateConfusionMatrix(trLabels,trSet,vLabels,vSet,bestc,nome,OutputPath)

trLabels=trLabels';
cmd = [' -t 5 -c ', num2str(bestc)];

predictres = zeros(size(vSet,1),size(unique(trLabels),1));

for i_class = unique(trLabels')
    [Xtrn,ttrn] = trainOAA(i_class,trSet,trLabels'); %OAA
    model = svmtrain(ttrn',Xtrn,cmd);
    [a, b, dec_values] = svmpredict(vLabels,vSet,model);
    predictres(:,i_class)=dec_values;
end

all_labels = unique(trLabels');
realpredict = zeros(1,size(vSet,1));

for i_sample=1:1:size(predictres,1)
    predict=[predictres(i_sample,:)' all_labels'];
    predict=sortrows(predict,1);
    realpredict(i_sample)=predict(max(trLabels),2);
end
save([OutputPath num2str(nome)],'realpredict');
accuracy=(size(find(vLabels'==realpredict),2)*100)/size(vSet,1);

% Calcualte confusion matrix
n_classes = max(vLabels);
ConfusionMatrix = zeros(max(vLabels)+2);

for right_class = unique(vLabels')    
    n_samples_class = size(nonzeros((vLabels'==right_class)),1);
    test = (vLabels'==right_class).*realpredict;
    for i_other_classes = unique(trLabels')
        ConfusionMatrix(i_other_classes,right_class) = size(find(test==i_other_classes),2);
    end
    SamplesClass = sum(ConfusionMatrix(:,right_class));
    ConfusionMatrix(n_classes+1,right_class)=SamplesClass;
    ConfusionMatrix(n_classes+2,right_class)=ConfusionMatrix(right_class,right_class)*100./SamplesClass;
end

for i_class = unique(trLabels')
    SamplesClass = sum(ConfusionMatrix(i_class,:));
    ConfusionMatrix(i_class,n_classes+1)=SamplesClass;
    ConfusionMatrix(i_class,n_classes+2)=ConfusionMatrix(i_class,i_class)*100./SamplesClass;
end
end