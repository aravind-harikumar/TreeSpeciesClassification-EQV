function out = getMaxAccuracyRow(inputMat,AccCol)
[~, MAxIndx] = max(inputMat(:,AccCol));
out = inputMat(MAxIndx,:);
end