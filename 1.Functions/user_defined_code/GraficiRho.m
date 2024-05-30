clc;clear;close all



Res = importdata('Acc_startingcode_rho_k_3.mat');


colormap = [       0    0.4470    0.7410
                0.8500    0.3250    0.0980
                0.9290    0.6940    0.1250
                0.4940    0.1840    0.5560
                0.4660    0.6740    0.1880
                0.3010    0.7450    0.9330
                0.6350    0.0780    0.1840
                   0         0    1.0000
                     0    0.5000         0
                1.0000         0         0
                     0    0.7500    0.7500
                0.7500         0    0.7500
                0.7500    0.7500         0
                0.2500    0.2500    0.2500];

Res1=Res(1:40,:);
rho_step = unique(Res1(:,1));

hFig = figure(1);
set(hFig, 'Position', [100 200 1400 800]) 
for i_rho_step = 1 :size(rho_step) 
    
    data = Res1(Res1(:,1)==rho_step(i_rho_step),:);
    %scatter(data(:,2),data(:,3),'r')
    
    plot(data(:,2),data(:,3),'--o','LineWidth',1.5,...
                       'MarkerEdgeColor',colormap(i_rho_step,:),...
                       'MarkerFaceColor',colormap(i_rho_step,:),...
                       'MarkerSize',10)
    
    set(gca,'ylim',[40 max(Res1(:,3))+10])
    hold on
    entry{i_rho_step} = num2str(rho_step(i_rho_step));
end
xlabel('# height steps')
ylabel('accuracy %')
lgd = legend(entry);
title('Rho');





%%

Res2=Res(41:end,:);
rho_step = unique(Res2(:,1));

hFig = figure(2);
set(hFig, 'Position', [100 200 1400 800]) 
for i_rho_step = 1 :size(rho_step) 
    
    data = Res2(Res2(:,1)==rho_step(i_rho_step),:);
    %scatter(data(:,2),data(:,3),'r')
    
    plot(data(:,2),data(:,3),'--o','LineWidth',1.5,...
                       'MarkerEdgeColor',colormap(i_rho_step,:),...
                       'MarkerFaceColor',colormap(i_rho_step,:),...
                       'MarkerSize',10)
    
    set(gca,'ylim',[40 max(Res2(:,3))+10])
    hold on
    entry{i_rho_step} = num2str(rho_step(i_rho_step));
end
xlabel('# height steps')
ylabel('accuracy %')
lgd = legend(entry);
title('Rho');
