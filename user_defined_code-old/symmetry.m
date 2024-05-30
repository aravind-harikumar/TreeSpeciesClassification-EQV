%%check the symmetry of each tree, for each height step the function will
%%control the median value of each degree sector, if one of these is less
%%than a threshold the function will add points from another degree sector
%%of the same height sector

function [P_simm]=symmetry(P,n_step,deg_step)

[P]=degpartition(P);
n_sector=360/deg_step; %number of sector
delta=max(P(:,3))/n_step; % delta partition

cont1=1;
for i_step=1:n_step
    DeltaL=delta*(i_step-1);
    DeltaH=delta*i_step;
    P_delta=P(and(P(:,3)>=DeltaL,P(:,3)<DeltaH),:);
    cont=1;
    for i_sector=1:n_sector
        TetaL = ((i_sector- 1) .* deg_step);
        TetaH = (i_sector .* deg_step);
        P_teta=P_delta(and(P_delta(:,7)>=TetaL,P_delta(:,7)<TetaH),:);
        P_teta_cell{cont}=P_teta;
        a(cont)=size(P_teta,1);
        cont=cont+1;
    end
    m=median(a); m=round(m);
    m=round(m-0.4*m);
    clear P_simm_sez;
    for i_sector=1:n_sector
        if size(P_teta_cell{i_sector},1)<m % con "<=m" cambia anche sezioni con stesso num di elem, non ha senso
            ang1=i_sector+(n_sector/2); ang1=round(ang1);
            pos=mod(ang1,n_sector);
            if pos==0
                pos=round(n_sector); %se sono a n_sector/2, sommando n_sector/2 e facendo il mod, tornerei a n_sec/2
            end
            if sum(a)~=0
                while size(P_teta_cell{pos},1)<m && pos~=i_sector
                    pos=pos+1; %se la cella è vuota guardo la successiva
                    pos=mod(pos,n_sector);
                    if pos==0
                        pos=1;
                    end
                end
            end
            P_simm_sez{i_sector}=P_teta_cell{pos};
            [~,rho] = cart2pol(P_simm_sez{i_sector}(:,1),P_simm_sez{i_sector}(:,2));
            if i_sector<pos
                theta=deg2rad(P_simm_sez{i_sector}(:,7)+mod(round(sqrt((i_sector-pos)^2)),n_sector)*deg_step);
                [P_simm_sez{i_sector}(:,1),P_simm_sez{i_sector}(:,2)] = pol2cart(theta,rho);
            else
                theta=deg2rad(P_simm_sez{i_sector}(:,7)-mod(round(sqrt((i_sector-pos)^2)),n_sector)*deg_step);
                [P_simm_sez{i_sector}(:,1),P_simm_sez{i_sector}(:,2)] = pol2cart(theta,rho);
            end
        else %se non ha problemi ci metto quello che era già presente prima
            P_simm_sez{i_sector}=P_teta_cell{i_sector};
        end
        %clear a;
    end
    P_simm_matr=cell2matr(P_simm_sez);
    P_simm(cont1:(cont1+size(P_simm_matr,1)-1),:)=P_simm_matr;
    cont1=cont1+size(P_simm_matr,1);
    
end
P_simm=P_simm(:,1:6);


% scatter3(P_simm(:,1),P_simm(:,2),P_simm(:,3),30,P_simm(:,3),'filled')
% figure (2)
% scatter3(P(:,1),P(:,2),P(:,3),30,P(:,3),'filled')
end





