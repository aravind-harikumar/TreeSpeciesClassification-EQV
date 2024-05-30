function [FeatureArray,featureindx,IBF] = GenerateFeatureSet(rdSet,hstep,noHtDiv,featureindx,percentileArr,FeatureArray,isgloblaNorm,IBF)

getPecetileFeatureSetALLReturns = true;
getPecetileFeatureSetReturnWise = false; %*
getPecetileFeatureSetALLPoints = true; %*
getPecetileFeatureSetALLMean = false;
getIntensityFeatures = false;

firstReturns = rdSet(rdSet(:,6)==1,:);
secondReturns = rdSet(rdSet(:,6)==2,:);
thirdReturns = rdSet(rdSet(:,6)==3,:);
fourthReturns = rdSet(rdSet(:,6)==4,:);
fifthReturns = rdSet(rdSet(:,6)==5,:);
sixthReturns = rdSet(rdSet(:,6)==6,:);

% ----------------------------------------------------------------------------------------------------
%                                           ALL RETURNS PERCENTILES
% ----------------------------------------------------------------------------------------------------

% % Indice by feature array initialization
% IBF.radialIndices = []; IBF.heigthIndices = []; IBF.heigthPDIndices = [];

if(getPecetileFeatureSetALLReturns)
    
    %------------------------------------------------%
    % Feature set 1: percentile feature generation (All returns)
    %------------------------------------------------%
    hist_percentile_arr = []; ht_hist_percentile = 0;
    for percCnt = 1:1:length(percentileArr);
        PercntileValue = prctile(rdSet(:,3), percentileArr(percCnt));
        ht_hist_percentile=ht_hist_percentile+1;
        hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    end
    if(not(isgloblaNorm))
        % perform height norm
        hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    end
    FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    IBF.radialIndices  = [IBF.radialIndices (featureindx+1:featureindx+length(percentileArr))];
    featureindx = featureindx + length(percentileArr); % increment index count
end

% ----------------------------------------------------------------------------------------------------
%                              1st, 2nd, 3rd and 4th RETURNS PERCENTILES
% ----------------------------------------------------------------------------------------------------

if(getPecetileFeatureSetReturnWise)
    
    % Indice by feature array initialization
    %%IBF.radialIndices = []; IBF.heigthIndices = []; IBF.heigthPDIndices = [];
    %------------------------------------------------%
    % Feature set 1: percentile feature generation (1st returns)
    %------------------------------------------------%
    hist_percentile_arr = []; ht_hist_percentile = 0;
    for percCnt = 1:1:length(percentileArr);
        PercntileValue = prctile(firstReturns(:,3), percentileArr(percCnt));
        %PercntileValue = prctile(rdSet(:,3), percentileArr(percCnt));
        ht_hist_percentile=ht_hist_percentile+1;
        hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    end
    if(not(isgloblaNorm))
        % perform height norm
        hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    end
    FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    IBF.radialIndices1  = [IBF.radialIndices1 (featureindx+1:featureindx+length(percentileArr))];
    featureindx = featureindx + length(percentileArr); % increment index count
    
    
    %------------------------------------------------%
    % Feature set 2: percentile feature generation (2nd returns)
    %------------------------------------------------%
    hist_percentile_arr = []; ht_hist_percentile = 0;
    for percCnt = 1:1:length(percentileArr);
        PercntileValue = prctile(secondReturns(:,3), percentileArr(percCnt));
        ht_hist_percentile=ht_hist_percentile+1;
        hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    end
    if(not(isgloblaNorm))
        % perform height norm
        hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    end
    FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    IBF.radialIndices2  = [IBF.radialIndices2 (featureindx+1:featureindx+length(percentileArr))];
    featureindx = featureindx + length(percentileArr); % increment index count
    
    
    %------------------------------------------------%
    % Feature set 3: percentile feature generation (3rd returns)
    %------------------------------------------------%
    hist_percentile_arr = []; ht_hist_percentile = 0;
    for percCnt = 1:1:length(percentileArr);
        PercntileValue = prctile(thirdReturns(:,3), percentileArr(percCnt));
        ht_hist_percentile=ht_hist_percentile+1;
        hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    end
    if(not(isgloblaNorm))
        % perform height norm
        hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    end
    FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    IBF.radialIndices3  = [IBF.radialIndices3 (featureindx+1:featureindx+length(percentileArr))];
    featureindx = featureindx + length(percentileArr); % increment index count
    
    
    %------------------------------------------------%
    % Feature set 4: percentile feature generation (4th returns)
    %------------------------------------------------%
    hist_percentile_arr = []; ht_hist_percentile = 0;
    for percCnt = 1:1:length(percentileArr);
        PercntileValue = prctile(fourthReturns(:,3), percentileArr(percCnt));
        ht_hist_percentile=ht_hist_percentile+1;
        hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    end
    if(not(isgloblaNorm))
        % perform height norm
        hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    end
    FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    IBF.radialIndices4  = [IBF.radialIndices4 (featureindx+1:featureindx+length(percentileArr))];
    featureindx = featureindx + length(percentileArr); % increment index count
    
    %         %------------------------------------------------%
    %     % Feature set 5: percentile feature generation (5th returns)
    %     %------------------------------------------------%
    %     hist_percentile_arr = []; ht_hist_percentile = 0;
    %     for percCnt = 1:1:length(percentileArr);
    %         PercntileValue = prctile(fifthReturns(:,3), percentileArr(percCnt));
    %         ht_hist_percentile=ht_hist_percentile+1;
    %         hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    %     end
    %     if(not(isgloblaNorm))
    %         % perform height norm
    %         hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    %     end
    %     FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    %     IBF.radialIndices5  = [IBF.radialIndices5 (featureindx+1:featureindx+length(percentileArr))];
    %     featureindx = featureindx + length(percentileArr); % increment index count
    %
    %
    %         %------------------------------------------------%
    %     % Feature set 5: percentile feature generation (6th returns)
    %     %------------------------------------------------%
    %     hist_percentile_arr = []; ht_hist_percentile = 0;
    %     for percCnt = 1:1:length(percentileArr);
    %         PercntileValue = prctile(sixthReturns(:,3), percentileArr(percCnt));
    %         ht_hist_percentile=ht_hist_percentile+1;
    %         hist_percentile_arr(1,ht_hist_percentile) = PercntileValue; % form histogram
    %     end
    %     if(not(isgloblaNorm))
    %         % perform height norm
    %         hist_percentile_arr = hist_percentile_arr/max(hist_percentile_arr(:));
    %     end
    %     FeatureArray(1,(featureindx+1: featureindx+length(percentileArr))) = hist_percentile_arr;
    %     IBF.radialIndices6  = [IBF.radialIndices6 (featureindx+1:featureindx+length(percentileArr))];
    %     featureindx = featureindx + length(percentileArr); % increment index count
    
    
end

% ----------------------------------------------------------------------------------------------------
%                                       ALL POINT COUNT
% ----------------------------------------------------------------------------------------------------

if(getPecetileFeatureSetALLPoints)
    
    %-------------------------------------------------%
    % Feature set 1: point density feature generation
    %-------------------------------------------------%
    hist_pcnt_arr =[]; ht_hist_pcnt = 0;
    for step_cnt=1:noHtDiv
        DeltaL=hstep*(step_cnt-1);
        DeltaH=hstep*step_cnt;
        if step_cnt ~= noHtDiv
            P_teta_delta = rdSet(and(rdSet(:,3)>=DeltaL,rdSet(:,3)<DeltaH),:);
        else
            P_teta_delta = rdSet(and(rdSet(:,3)>=DeltaL,rdSet(:,3)<=DeltaH),:);
        end
        [m, ~]=size(P_teta_delta);
        ht_hist_pcnt=ht_hist_pcnt+1;
        hist_pcnt_arr(ht_hist_pcnt,1)=m;
    end
    if(not(isgloblaNorm))
        % perform height norm
        hist_pcnt_arr = hist_pcnt_arr/max(hist_pcnt_arr(:));
    end
    FeatureArray(1,(featureindx+1: featureindx+noHtDiv)) = hist_pcnt_arr;
    IBF.heigthIndices = [IBF.heigthIndices (featureindx+1:featureindx+noHtDiv)];
    featureindx = featureindx + noHtDiv; % increment index count
end

% ----------------------------------------------------------------------------------------------------
%                                       ALL POINT COUNT MEAN
% ----------------------------------------------------------------------------------------------------

if(getPecetileFeatureSetALLMean)
    
    % %-------------------------------------------------%
    % % Feature set 1:
    % %-------------------------------------------------%
    
    hist_mean = []; ht_hist_mean = 0;
    
    ht_hist_mean=ht_hist_mean+1;
    hist_mean(1,ht_hist_mean) = mean(rdSet(:,3)); % form histogram
    hist_mean(1,ht_hist_mean+1) = std(rdSet(:,3)); % form histogram
    hist_mean(1,ht_hist_mean+2) = skewness(rdSet(:,3)); % form histogram
    hist_mean(1,ht_hist_mean+3) = kurtosis(rdSet(:,3)); % form histogram
    %hist_mean(1,ht_hist_mean+4) = kurtosis(rdSet(:,6)); % 0 to 20%
    %C11 Ratio between the height of the equivalent centers for the grids within each profile and the crown
    %length (average for 8 profiles)
    %Ratio between the number of the grids for the stem-related space and all of the grids for a tree
    %(stem-related space: 1/3 tree height from bottom, 1/2 crown diameter)
    % TE3 Equivalent crown diameter 
    % TE8 Ratio between LS and LCS
    % TE9 Mean height for all of the grids representing a tree
    
    FeatureArray(1,(featureindx+1:featureindx+4)) = hist_mean;
    IBF.meanIndices  = [IBF.meanIndices (featureindx+1:featureindx+1)];
    IBF.sdIndices  = [IBF.sdIndices (featureindx+2:featureindx+2)];
    IBF.skewIndices  = [IBF.skewIndices (featureindx+3:featureindx+3)];
    IBF.kurtIndices  = [IBF.kurtIndices (featureindx+4:featureindx+4)];
    featureindx = featureindx + 4; % increment index count
    
end

if(getIntensityFeatures)
    
end

end


% %-------------------------------------------------%
% % Feature set 1:
% %-------------------------------------------------%
% hist_pcomp_arr =[]; ht_hist_pcnt = 0;
% for step_cnt=1:noHtDiv
%     DeltaL=hstep*(step_cnt-1);
%     DeltaH=hstep*step_cnt;
%     if step_cnt ~= noHtDiv
%         P_teta_delta = rdSet(and(rdSet(:,3)>=DeltaL,rdSet(:,3)<DeltaH),:);
%     else
%         P_teta_delta = rdSet(and(rdSet(:,3)>=DeltaL,rdSet(:,3)<=DeltaH),:);
%     end
%     %EQVCenter = [mean(P_teta_delta(:,1)) mean(P_teta_delta(:,2))];
%     EQVCenter = [0 0];
%     ht_hist_pcnt=ht_hist_pcnt+1;
%     %[cIdx,cDist] = pdist2(EQVCenter,P_teta_delta(:,1:2),'K',10,'Distance','euclidean');
%     cDist = pdist2(EQVCenter,P_teta_delta(:,1:2));
%     hist_pcomp_arr(ht_hist_pcnt,1)= mean(cDist);
% end
% if(not(isgloblaNorm))
%     % perform height norm
%     hist_pcomp_arr = hist_pcomp_arr/max(hist_pcomp_arr(:));
% end
% FeatureArray(1,(featureindx+1: featureindx+noHtDiv)) = hist_pcomp_arr;
% IBF.heigthPDIndices = [IBF.heigthPDIndices (featureindx+1:featureindx+noHtDiv)];
% featureindx = featureindx + noHtDiv; % increment index count