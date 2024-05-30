function [AccTS, label_TS, teststats] = MainSVM_CV(TRs,TSs) 
%addpath('./functions')
%addpath('./libsvm-mat-3.0-1-win')

v=1; %versione
%===========================================================
% SVM parameters
%===========================================================
C_values = 10:20:1000; %crossvalidation value

OutputPath = './3.OutputPathSVM/';if exist(OutputPath,'dir')==0;mkdir(OutputPath);end

trSource = cell2matr(TRs');
tsSource = cell2matr(TSs');

trSet = trSource(:,1:end-1); 
trLabels = trSource(:,end);
tsSet = tsSource(:,1:end-1); 
tsLabels = tsSource(:,end);
%===========================================================
% MODEL SELECTION 
%===========================================================
[~,bestc]=PAR_Cross_ValidationINTER(trSet,trLabels',C_values);
%save([OutputPath 'bestc' ],'bestc');

%===========================================================
% Confusion Matrix on Test Set
%===========================================================

[AccTS,CM_TS,label_TS] = CalculateConfusionMatrix(trLabels',trSet,tsLabels,tsSet,bestc,'etichette_TS',OutputPath);
save([OutputPath 'CM_TS_' num2str(v)],'CM_TS');
%CM_TS =confusionmat(label_TS,tsLabels);

if(length(unique(label_TS)) == 4)
    OA = (CM_TS(1,1) + CM_TS(2,2) + CM_TS(3,3) + CM_TS(4,4))*100/ size(tsSet,1)% sum(CM_TS(:));
elseif(length(unique(label_TS)) == 5)
    OA = (CM_TS(1,1) + CM_TS(2,2) + CM_TS(3,3) + CM_TS(4,4) + CM_TS(5,5))*100/ size(tsSet,1)% sum(CM_TS(:));
else
    OA = (CM_TS(1,1) + CM_TS(2,2))*100/ size(tsSet,1)% sum(CM_TS(:));
end

teststats = confusionmatStats(tsLabels,label_TS);

[AccTR,CM_TR,label_TR] = CalculateConfusionMatrix(trLabels',trSet,trLabels,trSet,bestc,'etichette_TS',OutputPath);
save([OutputPath 'CM_TR_' num2str(v)],'CM_TR');
label_TS=label_TS';
end




