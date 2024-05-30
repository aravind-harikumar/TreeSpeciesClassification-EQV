clc;clear;close all;

InputPath = './';
InputName = 'Ads5.las';
OutputPath=InputPath;
AllSeed=[1 635921.61 5129313.96;2 635897.68 5129314.09;3 635929 5129327.42] ;%3 635929 5129327.42
DSM_las = read_LAS([InputPath InputName]);%manca il DSM
R=8;
n_sectors=8;
delta=0.3;
ThGround = 0.5;
for i_seed=1:size(AllSeed)
    
    EstSeed = AllSeed(i_seed,2);
    NordSeed = AllSeed(i_seed,3);
    ID = AllSeed(i_seed,1);
    %% check seed highest point     

    AroundSeed = DSM_las(and(DSM_las(:,1)<EstSeed+1,DSM_las(:,1)>EstSeed-1),:);
    AroundSeed = AroundSeed(and(AroundSeed(:,2)<NordSeed+1,AroundSeed(:,2)>NordSeed-1),:);

    X_Seed = AroundSeed(AroundSeed(:,3)==max(AroundSeed(:,3)),1);
    Y_Seed = AroundSeed(AroundSeed(:,3)==max(AroundSeed(:,3)),2);
        
    dyDSM = DSM_las(:,2)-Y_Seed(1);
    dxDSM = DSM_las(:,1)-X_Seed(1);
        
    ang = 360/n_sectors;
    alfa=atan((dyDSM)./(dxDSM))*180/pi();
    dist = sqrt((dyDSM.^ 2)+(dxDSM.^ 2)) ;

    %% check angle (II quadrante)
    rows = find(and(dxDSM<0,dyDSM>=0)==1);
    alfa(rows,:)=180+alfa(rows,:);

    %% check angle (III quadrante)
    rows = find(and(dxDSM<0,dyDSM<0)==1);
    alfa(rows,:)=180+alfa(rows,:);

    %% check angle (IV quadrante)
    rows = find(and(dxDSM>0,dyDSM<0)==1);
    alfa(rows,:)=360+alfa(rows,:);

    DSM = [DSM_las dist alfa [1:size(DSM_las,1)]'];
    P=[DSM(:,1:3),DSM(:,5),DSM(:,4),DSM(:,8:10)];

    sigma = 2;dim = 4; x = linspace(-dim / 2, dim / 2, dim);gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));gaussFilter = gaussFilter / sum (gaussFilter); % normalize

    TreePoints=[];
    %% Generate Sectors
    for i_sector = 1:n_sectors

            TetaL = ((i_sector- 1) .* ang);
            TetaH = (i_sector .* ang);

            P_teta=P(and(P(:,7)>=TetaL,P(:,7)<TetaH),:);
            if isempty(P_teta)==0

               %% quantize the distance
               Rmax = max(P_teta(:,6));
               S_teta = [];
                    for i_dist = 0:delta:(Rmax)
                        reducedsectorCHM=P_teta(and(P_teta(:,6)>i_dist,P_teta(:,6)<=i_dist+delta),:);
                        [Vmax,Imax]= max(reducedsectorCHM(:,3));
                        S_teta = [S_teta,Vmax];     
                    end
               %%check ground     
               if isempty(min(find(S_teta<=ThGround)))~=1
                  S_teta= S_teta(1,1:min(find(S_teta<=ThGround)));
               end 
               Ncol = size(S_teta,2);
               b=zeros(1,2*Ncol);
               b(1,Ncol+1:2*Ncol)=S_teta;

                    for i=1:Ncol
                        b(1,i)= S_teta(1,Ncol+1-i);
                    end
               yfiltCHM = conv (b, gaussFilter, 'same');
               MaxHeightIntFiltCHM = yfiltCHM(Ncol+1:2*Ncol);

               %bar(MaxHeightIntFiltCHM);
               Der_S_teta = gradient(MaxHeightIntFiltCHM); 
               MiddleIntervalCHM = size(MaxHeightIntFiltCHM,2);  
               
                    for i_interval=round(1.5/delta):(size(MaxHeightIntFiltCHM,2))
                        if (Der_S_teta(1,i_interval)>0) 
                            MiddleIntervalCHM = i_interval-1;%-2;
                            break
                        end
                    end

               Edge_teta=(MiddleIntervalCHM .* delta);
               SectorPointsAllCHM=DSM(and(DSM(:,9)>=TetaL,DSM(:,9)<TetaH),:);%punti compresi in ogni settore
               TreePoints  = [TreePoints;SectorPointsAllCHM(sqrt((SectorPointsAllCHM(:,1)-X_Seed(1)).^2+(SectorPointsAllCHM(:,2)-Y_Seed(1)).^2)<=Edge_teta,:)];
            end   
    end        
           
        InputName = ['Tree_' num2str(ID)];
        dlmwrite([ InputName '_Seg.txt'],TreePoints,'delimiter',' ','precision',10);
        system(['txt2las -parse xyzrics '   InputName '_Seg.txt']);
        %movefile([InputName '_Seg.las'],[OutputPath InputName '_Seg.las']);
        delete([pwd '/*.txt']);
end