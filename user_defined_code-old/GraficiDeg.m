clc;clear;close all


Res = importdata('Acc_startingcode_deg_1.mat');


colormap = [       0    0.4470    0.7410
                0.8500    0.3250    0.0980
                0.9290    0.6940    0.1250
                0.4940    0.1840    0.5560
                0.4660    0.6740    0.1880
                0.3010    0.7450    0.9330
                0.6350    0.0780    0.1840];

deg = unique(Res(:,1));

hFig = figure(1);
set(hFig, 'Position', [100 200 1400 800]) 
for i_deg = 1 :size(deg) 
    
    data = Res(Res(:,1)==deg(i_deg),:);
    %scatter(data(:,2),data(:,3),'r')
    
    plot(data(:,2),data(:,3),'--o','LineWidth',1.5,...
                       'MarkerEdgeColor',colormap(i_deg,:),...
                       'MarkerFaceColor',colormap(i_deg,:),...
                       'MarkerSize',10)
    
    set(gca,'ylim',[40 max(Res(:,3))+10])
    hold on
    entry{i_deg} = num2str(deg(i_deg));
end
xlabel('# height steps')
ylabel('accuracy %')
lgd = legend(entry);
title('Theta')


Res = importdata('Acc_startingcode_deg_2.mat');


deg = unique(Res(:,1));

hFig = figure(2);
set(hFig, 'Position', [100 200 1400 800]) 
for i_deg = 1 :size(deg) 
    
    data = Res(Res(:,1)==deg(i_deg),:);
    %scatter(data(:,2),data(:,3),'r')
    
    plot(data(:,2),data(:,3),'--o','LineWidth',1.5,...
                       'MarkerEdgeColor',colormap(i_deg,:),...
                       'MarkerFaceColor',colormap(i_deg,:),...
                       'MarkerSize',10)
    
    set(gca,'ylim',[40 max(Res(:,3))+10])
    hold on
    entry{i_deg} = num2str(deg(i_deg));
end
xlabel('# height steps')
ylabel('accuracy %')
lgd = legend(entry);
title('Theta')


Res = importdata('Acc_startingcode_deg_3.mat');


deg = unique(Res(:,1));

hFig = figure(3);
set(hFig, 'Position', [100 200 1400 800]) 
for i_deg = 1 :size(deg) 
    
    data = Res(Res(:,1)==deg(i_deg),:);
    %scatter(data(:,2),data(:,3),'r')
    
    plot(data(:,2),data(:,3),'--o','LineWidth',1.5,...
                       'MarkerEdgeColor',colormap(i_deg,:),...
                       'MarkerFaceColor',colormap(i_deg,:),...
                       'MarkerSize',10)
    
    set(gca,'ylim',[40 max(Res(:,3))+10])
    hold on
    entry{i_deg} = num2str(deg(i_deg));
end
xlabel('# height steps')
ylabel('accuracy %')
lgd = legend(entry);
title('Theta')




