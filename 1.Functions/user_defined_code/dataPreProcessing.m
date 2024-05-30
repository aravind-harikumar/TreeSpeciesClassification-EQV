function dataAtt = dataPreProcessing(singleTreeLiDARdata)
% Write normalized data to a table for performance improvement
lidarDataArr = normalizeLiDARData(write2table(singleTreeLiDARdata));

% treeWidth =  max(lidarDataArr(:,1)); treeWidth2 = max(lidarDataArr(:,2)); % to calculate max wisth/breadth to set plot width
% dataAtt.maxTreeWidth = max(treeWidth, treeWidth2); % Keep it as 5 if issues arise
% dataAtt.mintreeHeight = min(lidarDataArr(:,3));
% dataAtt.maxtreeHeight = max(lidarDataArr(:,3));
% dataAtt.treeHeight = dataAtt.maxtreeHeight - dataAtt.mintreeHeight;
% dataAtt.htDeduction = dataAtt.treeHeight*0; % to get rid of ground noise points

% Crown height
%lidarDataArr = lidarDataArr(and(lidarDataArr(:,3) > min(lidarDataArr(:,3))+ dataAtt.htDeduction, lidarDataArr(:,3) < max(lidarDataArr(:,3))),:);
%dataAtt.minCrownHeight = getMinCrownHeight(lidarDataArr);
%dataAtt.maxCrownHeight = max(lidarDataArr(:,3));
%dataAtt.crownHeight = dataAtt.maxCrownHeight - dataAtt.minCrownHeight;

% Identify the center point of the tree (in top view).
%dataAtt.retMaxXYZ = findMaxHeightXY(lidarDataArr);

% Sparsified LiDAR data Array
%lidarDataArrSampled = lidarDataArr(lidarDataDensityArr(:,1) >= 0.0000,:);
%dataAtt.lidarDataArray =  [lidarDataArrSampled(:,1:8) zeros(size(lidarDataArrSampled,1),5 )] ;
dataAtt.lidarDataArray = lidarDataArr;
dataAtt.XMax = max(dataAtt.lidarDataArray(:,1));
dataAtt.XMin = min(dataAtt.lidarDataArray(:,1));

dataAtt.YMax = max(dataAtt.lidarDataArray(:,2));
dataAtt.YMin = min(dataAtt.lidarDataArray(:,2));

dataAtt.ZMax = max(dataAtt.lidarDataArray(:,3));
dataAtt.ZMin = min(dataAtt.lidarDataArray(:,3));

end