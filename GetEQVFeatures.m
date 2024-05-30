%generation of the EQV feature vector for a single tree with the
%combination of Height + Rho + Theta Constant division

function [FeatureArray,IBF] = GetEQVFeatures(P, sector_step_cnt, noRadDivs, max_crown_span, max_crown_height, noHeightDiv, parameters)

%number of sector
sector_angle_step = 360/sector_step_cnt;

% get height step
maxHeight  = max(P(:,3)); 
if(parameters.isConstantHeight)
    maxHeight  = max_crown_height; % get tree-independent radial sector width
end
hstep=maxHeight/noHeightDiv;

% get max radius
[distval(1), Idx(1)] = max(P(:,1)); [distval(2), Idx(2)] = min(P(:,1));
[distval(3), Idx(3)] = max(P(:,2)); [distval(4), Idx(4)] = min(P(:,2));
[~, maxDistIdx] = max(abs(distval));
extPntDist  = distval(maxDistIdx); % get tree-dependent radial sector width
% get tree-dependent radial sector width
if(parameters.isConstantRadius)
    extPntDist  = max_crown_span; % get tree-independent radial sector width
end
radial_step = abs(extPntDist/noRadDivs);

% get max tree height & correspoding data point index
%[~, maxHtPointIdx] = max(P(:,3));
%maxHtPointXY = P(maxHtPointIdx,1:2);
maxHtPointXY = [mean(P(:,1)) mean(P(:,2))];

% percentile divisions
percentileArr = [5:5:100]; % for testing more fine intervals
% percentileArr = [20:20:100];

% Feature Array initialization
Feature1Dim = length(percentileArr)*1;
Feature2Dim = noHeightDiv*1;
Feature3Dim = 4*0;
FeatureArray = zeros(1,(sector_step_cnt*noRadDivs*(Feature1Dim + Feature2Dim + Feature3Dim)));

IBF.radialIndices = []; 
IBF.radialIndices1 = []; IBF.radialIndices2 = []; IBF.radialIndices3 = [];
IBF.radialIndices4 = []; IBF.radialIndices5 = []; IBF.radialIndices6 = []; 
IBF.heigthIndices = []; IBF.meanIndices = []; 
IBF.sdIndices = []; IBF.skewIndices = []; IBF.kurtIndices = [];
IBF.heigthPDIndices = [];

featureindx =0;
% loop over angular sectors
for sectorDivCnt=1:1:sector_step_cnt
    TetaL = ((sectorDivCnt- 1) .* sector_angle_step); % low end of anglualr sector
    TetaH = (sectorDivCnt .* sector_angle_step); % high end of anglualr sector
    P_teta=P(and( P(:,7)>=TetaL, P(:,7)<TetaH ),:); % get all points within the anglualr sector.
    disttoCenter = pdist2(maxHtPointXY,P_teta(:,1:2))'; % get horizontal distance of each point to tree stem.
    
    % loop over radial sections
    for RadialDivCnt = 1:1:noRadDivs
        radiusDivL = ((RadialDivCnt- 1) .* radial_step);  % low end of radial section
        radiusDivH = (RadialDivCnt .* radial_step); % high end of radial section
        rdSet = P_teta(and(disttoCenter>=radiusDivL, disttoCenter<=radiusDivH),:); % get all points within the radius range.      
        %plot3(rdSet(:,1),rdSet(:,2),rdSet(:,3),'*'); axis equal;
        
        [FeatureArray,featureindx,IBF] = GenerateFeatureSet(rdSet, hstep, noHeightDiv, featureindx, percentileArr,FeatureArray, parameters.isgloblaNorm,IBF);   
        
    end
end
end