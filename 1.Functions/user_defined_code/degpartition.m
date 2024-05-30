%% deg partition
%calculate the relative angle for each point of the tree
function [P]=degpartition(P)
    dyDSM = P(:,2); dxDSM = P(:,1);
    % check angle (I quadrante)
    alfa=atan((dyDSM)./(dxDSM))*180/pi();
    %dist = sqrt((dyDSM.^ 2)+(dxDSM.^ 2));
    % check angle (II quadrante)
    rows = find(and(dxDSM<0,dyDSM>=0)==1);
    alfa(rows,:)=180+alfa(rows,:);
    % check angle (III quadrante)
    rows = find(and(dxDSM<0,dyDSM<0)==1);
    alfa(rows,:)=180+alfa(rows,:);
    % check angle (IV quadrante)
    rows = find(and(dxDSM>0,dyDSM<0)==1);
    alfa(rows,:)=360+alfa(rows,:);
    P(:,7) = alfa;
    P(isnan(P(:,7)),7)=0;
end