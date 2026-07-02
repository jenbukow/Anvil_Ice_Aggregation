clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 10);
set(0,'DefaultAxesFontWeight', 'normal');
%set(0,'DefaultTextFontSize',14);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)
blue =[3, 69, 252]/255;
darkblue= [6, 39, 105]/255;
%lightblue = [108, 209, 230]/255;
gray=[171, 170, 169]/255;
darkgray=[44, 47, 48]/255;
blue1 = [55, 89, 206]/255;
purple = [93, 51, 161]/255;
green = [71, 166, 111]/255;
orange = [224, 121, 65]/255;
lightgreen = [186, 204, 189]/255;
lightblue = [184, 195, 212]/255;
green_track = [0, 217, 69]/255;
blue_track = [0, 60, 255]/255;
lightgray = [230, 230, 230]/255;
%%
% start=[1 1 6]; stop=[Inf Inf 1];
AGG = ["LOW","MID","HIGH"];
SIM = ["ARG1.1","AUS1.1","DRC1.1","PHI1.1","WPO1.1"];
for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j)

        switch simname
            case 'ARG1.1'
                k=100;
            case 'AUS1.1'
                k=90;
            otherwise
                k=130;
        end

        agg = AGG(i);
        GEOIRPATH  = "../GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
        GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
        baseFileName = GEOIRFILE(k).name;
        fullFileName = fullfile(GEOIRPATH,baseFileName);
        lat=ncread(fullFileName,'xlat'); lon=ncread(fullFileName,'xlon');
        lat=lat(250,:); lon=lon(:,250);
        nx = length(lon); ny = length(lat);
        area_tot   = nx*ny;
        [thick,thin,all] = track_anvil_area(k,GEOIRFILE,GEOIRPATH,simname);

        area_thick(j,i) = nansum(thick,'all');
        area_thin(j,i)  = nansum(thin,'all');
        area_all(j,i)   = nansum(all,'all');
        frac_thick(j,i) = area_thick(j,i)/area_tot;
        frac_thin(j,i)  = area_thin(j,i)/area_tot;
        frac_all(j,i)   = area_all(j,i)/area_tot;
        ratio(j,i)      = area_thick(j,i)/area_thin(j,i);

        start=[1 1 6]; stop=[Inf Inf 1];
        switch simname
            case 'DRC1.1'
                lambda11 = 5; lambda12 = 6; % 10.8 / 12.0 um
            otherwise
                lambda11 = 7;
        end
        baseFileName = GEOIRFILE(k).name;
        fullFileName = fullfile(GEOIRPATH, baseFileName);
        Tb_11 = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
        Tb_mean(j,i)     = nanmean(Tb_11,"all");

    end
end

dx=1.6; % grid spacing in km
area_all_mean = dx^2*nanmean(area_all);
area_thin_mean = dx^2*nanmean(area_thin);
area_thick_mean = dx^2*nanmean(area_thick);
ratio_mean = nanmean(ratio);
frac_thin_mean = nanmean(frac_thin);
frac_thick_mean = nanmean(frac_thick);
Tb_mean = round(nanmean(Tb_mean,1));

for i = 1:3
    change_area_all(i)   = 100*((area_all_mean(i)-area_all_mean(1))/area_all_mean(1));
    change_area_thick(i) = 100*((area_thick_mean(i)-area_thick_mean(1))/area_thick_mean(1));
    change_area_thin(i)  = 100*((area_thin_mean(i)-area_thin_mean(1))/area_thin_mean(1));
end

%%

simname = 'PHI1.1';
    switch simname
        case 'DRC1.1'
            lambda6  = 1; lambda7  = 2; % 6.2 / 7.3 um
            lambda11 = 5; lambda12 = 6; % 10.8 / 12.0 um
        otherwise
            %lambda11 could be 6 or 7
            lambda6  = 1; lambda7  = 3; % 6.2 / 7.3 um
            lambda11 = 7; lambda12 = 8; % 11.2 / 12.3 um
            lambda8  = 4;
    end
start=[1 1 6]; stop=[Inf Inf 1];

agg = 'LOW';
GEOIRPATH  = "../GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
k = 130;
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
lat=ncread(fullFileName,'xlat'); lon=ncread(fullFileName,'xlon');
lat=lat(250,:); lon=lon(:,250);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_low,perim_thin_low] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_low = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

agg = 'MID';
GEOIRPATH  = "../GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_mid,perim_thin_mid] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_mid = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

agg = 'HIGH';
GEOIRPATH  = "../GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_high,perim_thin_high] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_high = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
%%
textlim1 = 0.02; textlim2 = 0.93;
f=figure('Position', [10 10 1100 800]);
tiledlayout(2,3,'TileSpacing','Compact');
sz = 100;
x=[1,2,3];
xlims = [0.75,3.25];
Tb_string = string(Tb_mean);
gridtrans = 0.075; 

ax = nexttile(1);
contourf(lon,lat,flipud(rot90(Tb11_low)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
ax.TitleHorizontalAlignment = 'left';
title({'AGG-LOW Tb'},'FontSize',14)
contour(lon,lat,flipud(rot90(perim_thick_low)),'Color',green_track,'LineWidth',1.5)
contour(lon,lat,flipud(rot90(perim_thin_low)),'Color',blue_track,'LineWidth',1.5)
yticks([14,15,16,17,18,19,20])
yticklabels({'14°','15°','16°','17°','18°','19°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'a)','units','normalized','FontSize',12,'Color',lightgray,'FontWeight','normal')
% text(ax,textlim1,0.05,'$\bar{Tb}$ = ' + Tb_string(1) + ' K', 'Interpreter','latex','units','normalized','FontSize',12,'Color',lightgray,'FontWeight','normal')

ax = nexttile(2);
contourf(lon,lat,flipud(rot90(Tb11_mid)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
ax.TitleHorizontalAlignment = 'left';
title({'AGG-MID Tb'},'FontSize',14)
contour(lon,lat,flipud(rot90(perim_thick_mid)),'Color',green_track,'LineWidth',1.5)
contour(lon,lat,flipud(rot90(perim_thin_mid)),'Color',blue_track,'LineWidth',1.5)
yticks([14,15,16,17,18,19,20])
yticklabels({'14°','15°','16°','17°','18°','19°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'b)','units','normalized','FontSize',12,'Color',lightgray,'FontWeight','normal')
%text(ax,textlim1,0.05,'$\bar{Tb}$ = ' + Tb_string(2) + ' K', 'Interpreter','latex','units','normalized','FontSize',12,'Color','w','FontWeight','normal')


ax = nexttile(3);
contourf(lon,lat,flipud(rot90(Tb11_high)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
c=colorbar;
c.Label.String = "11\mum Simulated GEOIR Tb [K]";
c.Label.FontSize = 12;
hold on
ax.TitleHorizontalAlignment = 'left';
title({'AGG-HIGH Tb'},'FontSize',14)
contour(lon,lat,flipud(rot90(perim_thick_high)),'Color',green_track,'LineWidth',1.5)
contour(lon,lat,flipud(rot90(perim_thin_high)),'Color',blue_track,'LineWidth',1.5)
yticks([14,15,16,17,18,19,20])
yticklabels({'14°','15°','16°','17°','18°','19°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'c)','units','normalized','FontSize',12,'Color',lightgray,'FontWeight','normal')
% text(ax,textlim1,0.05,'$\bar{Tb}$ = ' + Tb_string(3) + ' K', 'Interpreter','latex','units','normalized','FontSize',12,'Color','w','FontWeight','normal')


ax = nexttile(4);
hold on; grid on; box on;
plot(x,area_all_mean/10^5,'Color',gray,'LineWidth',2.2)
scatter(x,area_all_mean/10^5,sz ,'k','filled')
plot(x,area_thick_mean/10^5,'Color',lightgreen,'LineWidth',2.2)
scatter(x,area_thick_mean/10^5,sz ,'filled','MarkerFaceColor',green)
plot(x,area_thin_mean/10^5,'Color',lightblue,'LineWidth',2.2)
scatter(x,area_thin_mean/10^5,sz ,'filled','b')
ylabel('Domain Anvil Area [10^5*km^2]')
title('Anvil Area','FontSize',14)
ax.TitleHorizontalAlignment = 'left';
ylim([0,12.5])
xlim(xlims)
xticks([x])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'d)','units','normalized','FontSize',12,'Color','k','FontWeight','normal')
legend('','Total Anvil','','Thick Anvil','','Thin Anvil','Location','southwest','FontSize',12)
ax.GridAlpha = gridtrans;

ax = nexttile(5);
hold on; grid on; box on;
plot(x,change_area_thick,'Color',lightgreen,'LineWidth',2.2)
scatter(x,change_area_thick,sz ,'filled','MarkerFaceColor',green)
plot(x,change_area_thin,'Color',lightblue,'LineWidth',2.2)
scatter(x,change_area_thin,sz ,'filled','b')
plot(x,change_area_all,'Color',gray,'LineWidth',2.2)
scatter(x,change_area_all,sz ,'k','filled')
ylabel('Change in Anvil Area [%]')
title('Percent Change in Anvil Area','FontSize',14)
ax.TitleHorizontalAlignment = 'left';
ylim([-125,125])
text(ax,textlim1,textlim2,'e)','units','normalized','FontSize',12,'Color','k','FontWeight','normal')
xlim(xlims)
xticks([x])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
%legend('','Total Anvil','','Thick Anvil','','Thin Anvil','Location','southwest','FontSize',12)
ax.GridAlpha = gridtrans;

ax = nexttile(6);
hold on; grid on; box on;
plot(x,ratio_mean,'Color',gray,'LineWidth',2.2)
scatter(x,ratio_mean,sz ,'k','filled')
ylabel('Ratio of Thick to Thin Anvil')
title('Ratio of Thick to Thin Anvil','FontSize',14)
xlim(xlims)
xticks([x])
ax.TitleHorizontalAlignment = 'left';
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'f)','units','normalized','FontSize',12,'Color','k','FontWeight','normal')
ylim([0,1.7])
ax.GridAlpha = gridtrans;