clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 18 );
set(0,'DefaultAxesFontWeight', 'normal');
set(0,'DefaultTextFontSize',16);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)
blue =[3, 69, 252]/255;
darkblue= [6, 39, 105]/255;
lightblue = [108, 209, 230]/255;
gray=[79, 78, 78]/255;
darkgray=[44, 47, 48]/255;
blue1 = [55, 89, 206]/255;
purple = [93, 51, 161]/255;
green = [71, 166, 111]/255;
%orange = [224, 121, 65]/255;
orange = [237, 144, 31]/255;
pink = [125, 30, 62]/255;
%% straight from rams 6.3.04 
%Celcius temperature
temps   = [ 0.,  -5., -10., -14., -15., -16., -20., -25., -30., -35., -40., -50.];
%Aggregation efficiency 
efftemp   =[0.20, 0.15, 0.20, 0.60, 0.65, 0.60, 0.10, 0.08, 0.06, 0.04, 0.025, 0.020];
efftemp2  = [nan, nan, nan,  nan, 0.65, 0.60, 0.10, 0.08, 0.06, 0.04, 0.025, 0.020];
efftemp3  = [0.20, 0.15, 0.20, 0.60, 0.65, nan, nan, nan, nan, nan, nan, nan];
agg_mid   = efftemp;
agg_mid2  = efftemp2;
agg_mid3  = efftemp3;
agg_high  = [0.20, 0.15, 0.20, 0.60, 0.65, 0.60, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2];
agg_high2 = [nan, nan, nan,  nan, 0.65, 0.60, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2];
agg_high3 = [0.20, 0.15, 0.20, 0.60, 0.65, nan, nan, nan, nan, nan, nan, nan];
agg_low   = [0.20, 0.15, 0.20, 0.60, 0.65, 0.60, 0.033, 0.025, 0.017, 0.011, 0.0026, 0.001];
agg_low2  = [nan, nan, nan, nan, 0.65, 0.60, 0.033, 0.025, 0.017, 0.011, 0.0026, 0.001];
agg_low3  = [0.20, 0.15, 0.20, 0.60, 0.65, nan, nan, nan, nan, nan, nan, nan];
top_shading    = [0.5,0.5,0.5,0.85,0.9,0.85,0.5,0.5,0.5,0.5,0.5,0.5];
bottom_shading = [0,0,0,0.35,0.4,0.35,0,0,0,0,0,0];
warm = [0.20, 0.15, 0.20, 0.60, 0.65, nan, nan, nan, nan, nan, nan, nan];

%%

f=figure('Position', [10 10 650 580]);
ax = gca;
hold on;
boundedline(temps,agg_high,top_shading-agg_high,'cmap',gray,'transparency', 0.15,'alpha');
plot(temps,agg_low2,'Color',green,'LineWidth',4.0)
plot(temps,agg_mid2,'Color',blue1,'LineWidth',4.0)
plot(temps,agg_high2,'Color',orange,'LineWidth',4.0)
%plot(temps,warm,'Color',darkgray,'LineWidth',4.0)
plot(temps,agg_high3,'Color',orange,'LineStyle','-','LineWidth',4.0)
plot(temps,agg_mid3,'Color',blue1,'LineStyle','--','LineWidth',4.0)
plot(temps,agg_low3,'Color',green,'LineStyle',':','LineWidth',4.0)
ylim([0,1.05])
xlim([-50,-5])
ax.TitleHorizontalAlignment = 'left';
ylabel('Ice Aggregation Efficiency [0-1]')
xlabel('Environmental Temperature [C]')
title('Ice Aggregation Efficiency')
legend('','','AGG-LOW','AGG-MID','AGG-HIGH','Location','northwest')
box on; grid on;

