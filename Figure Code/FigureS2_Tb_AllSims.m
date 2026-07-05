clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 10);
set(0,'DefaultAxesFontWeight', 'normal');
%set(0,'DefaultTextFontSize',14);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)
gray=[208 206 206]/255;
darkgray=[44, 47, 48]/255;
green = [0, 217, 69]/255;
blue = [0, 60, 255]/255;

%%
start=[1 1 6]; stop=[Inf Inf 1];
simname = 'ARG1.1';
k = 100;
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
agg = 'LOW';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
lat_arg=ncread(fullFileName,'xlat'); lon_arg=ncread(fullFileName,'xlon');
lat_arg=lat_arg(250,:); lon_arg=lon_arg(:,250);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_arg_low,perim_thin_arg_low] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_arg_low = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'MID';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_arg_mid,perim_thin_arg_mid] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_arg_mid = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'HIGH';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_arg_high,perim_thin_arg_high] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_arg_high = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

simname = 'AUS1.1';
k = 90;
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
agg = 'LOW';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
lat_aus=ncread(fullFileName,'xlat'); lon_aus=ncread(fullFileName,'xlon');
lat_aus=lat_aus(250,:); lon_aus=lon_aus(:,250);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_aus_low,perim_thin_aus_low] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_aus_low = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'MID';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_aus_mid,perim_thin_aus_mid] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_aus_mid = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'HIGH';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_aus_high,perim_thin_aus_high] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_aus_high = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

simname = 'DRC1.1';
k = 130;
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
agg = 'LOW';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
lat_drc=ncread(fullFileName,'xlat'); lon_drc=ncread(fullFileName,'xlon');
lat_drc=lat_drc(250,:); lon_drc=lon_drc(:,250);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_drc_low,perim_thin_drc_low] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_drc_low = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'MID';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_drc_mid,perim_thin_drc_mid] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_drc_mid = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'HIGH';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_drc_high,perim_thin_drc_high] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_drc_high = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

simname = 'PHI1.1';
k = 130;
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
agg = 'LOW';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
lat_phi=ncread(fullFileName,'xlat'); lon_phi=ncread(fullFileName,'xlon');
lat_phi=lat_phi(250,:); lon_phi=lon_phi(:,250);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_phi_low,perim_thin_phi_low] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_phi_low = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'MID';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_phi_mid,perim_thin_phi_mid] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_phi_mid = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'HIGH';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_phi_high,perim_thin_phi_high] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_phi_high = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

simname = 'WPO1.1';
k = 130;
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
agg = 'LOW';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
lat_wpo=ncread(fullFileName,'xlat'); lon_wpo=ncread(fullFileName,'xlon');
lat_wpo=lat_wpo(250,:); lon_wpo=lon_wpo(:,250);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_wpo_low,perim_thin_wpo_low] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_wpo_low = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'MID';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_wpo_mid,perim_thin_wpo_mid] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_wpo_mid = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
agg = 'HIGH';
GEOIRPATH  = "./GEO_IR/" + simname + '-AGG-' + agg + '/GEO_IR/';
GEOIRFILE  = dir(fullfile(GEOIRPATH,'*.nc'));
baseFileName = GEOIRFILE(k).name;
fullFileName = fullfile(GEOIRPATH,baseFileName);
[BW_thick_buffer,BW_thin_buffer,BW_inter,perim_thick_wpo_high,perim_thin_wpo_high] = track_anvil(k,GEOIRFILE,GEOIRPATH,simname);
Tb11_wpo_high = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));

%%
textlim1 = 0.02; textlim2 = 0.93;
f=figure('Position', [10 10 700 900]);
tiledlayout(5,3,'TileSpacing','Compact');

ax = nexttile(1);
contourf(lon_arg,lat_arg,flipud(rot90(Tb11_arg_low)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
ax.TitleHorizontalAlignment = 'left';
title({'Anvil Area','AGG-LOW Tb'},'FontSize',10)
contour(lon_arg,lat_arg,flipud(rot90(perim_thick_arg_low)),'Color',green,'LineWidth',1.5)
contour(lon_arg,lat_arg,flipud(rot90(perim_thin_arg_low)),'Color',blue,'LineWidth',1.5)
xticks([-66,-64,-62,-60])
xticklabels({'-66°','-64°','-62°','-60°'})
yticks([-35,-33,-31,-29])
yticklabels({'-35°','-33°','-31°','-29°'})
text(ax,textlim1,textlim2,'a)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')
ylabel('Argentina','FontSize',10)

ax = nexttile(2);
contourf(lon_arg,lat_arg,flipud(rot90(Tb11_arg_mid)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
ax.TitleHorizontalAlignment = 'left';
title({'','AGG-MID Tb'},'FontSize',10)
contour(lon_arg,lat_arg,flipud(rot90(perim_thick_arg_mid)),'Color',green,'LineWidth',1.5)
contour(lon_arg,lat_arg,flipud(rot90(perim_thin_arg_mid)),'Color',blue,'LineWidth',1.5)
xticks([-66,-64,-62,-60])
xticklabels({'-66°','-64°','-62°','-60°'})
yticks([-35,-33,-31,-29])
yticklabels({'-35°','-33°','-31°','-29°'})
text(ax,textlim1,textlim2,'b)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(3);
contourf(lon_arg,lat_arg,flipud(rot90(Tb11_arg_high)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
c=colorbar;
c.Label.String = "11\mum Simulated Tb [K]";
c.Label.FontSize = 8;
hold on
ax.TitleHorizontalAlignment = 'left';
title({'','AGG-HIGH Tb'},'FontSize',10)
contour(lon_arg,lat_arg,flipud(rot90(perim_thick_arg_high)),'Color',green,'LineWidth',1.5)
contour(lon_arg,lat_arg,flipud(rot90(perim_thin_arg_high)),'Color',blue,'LineWidth',1.5)
xticks([-66,-64,-62,-60])
xticklabels({'-66°','-64°','-62°','-60°'})
yticks([-35,-33,-31,-29])
yticklabels({'-35°','-33°','-31°','-29°'})
text(ax,textlim1,textlim2,'c)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(4);
contourf(lon_aus,lat_aus,flipud(rot90(Tb11_aus_low)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_aus,lat_aus,flipud(rot90(perim_thick_aus_low)),'Color',green,'LineWidth',1.5)
contour(lon_aus,lat_aus,flipud(rot90(perim_thin_aus_low)),'Color',blue,'LineWidth',1.5)
yticks([-15,-13,-11,-9])
yticklabels({'-15°','-13°','-11°','-9°'})
xticks([124,128,132,136])
xticklabels({'124°','128°','132°','136°'})
text(ax,textlim1,textlim2,'d)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')
ylabel('Australia','FontSize',10)

ax = nexttile(5);
contourf(lon_aus,lat_aus,flipud(rot90(Tb11_aus_mid)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_aus,lat_aus,flipud(rot90(perim_thick_aus_mid)),'Color',green,'LineWidth',1.5)
contour(lon_aus,lat_aus,flipud(rot90(perim_thin_aus_mid)),'Color',blue,'LineWidth',1.5)
yticks([-15,-13,-11,-9])
yticklabels({'-15°','-13°','-11°','-9°'})
xticks([124,128,132,136])
xticklabels({'124°','128°','132°','136°'})
text(ax,textlim1,textlim2,'e)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(6);
contourf(lon_aus,lat_aus,flipud(rot90(Tb11_aus_high)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
c=colorbar;
c.Label.String = "11\mum Simulated Tb [K]";
c.Label.FontSize = 8;
hold on
contour(lon_aus,lat_aus,flipud(rot90(perim_thick_aus_high)),'Color',green,'LineWidth',1.5)
contour(lon_aus,lat_aus,flipud(rot90(perim_thin_aus_high)),'Color',blue,'LineWidth',1.5)
yticks([-15,-13,-11,-9])
yticklabels({'-15°','-13°','-11°','-9°'})
xticks([124,128,132,136])
xticklabels({'124°','128°','132°','136°'})
text(ax,textlim1,textlim2,'f)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(7);
contourf(lon_drc,lat_drc,flipud(rot90(Tb11_drc_low)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_drc,lat_drc,flipud(rot90(perim_thick_drc_low)),'Color',green,'LineWidth',1.5)
contour(lon_drc,lat_drc,flipud(rot90(perim_thin_drc_low)),'Color',blue,'LineWidth',1.5)
yticks([-10,-6,-2,2])
yticklabels({'-10°','-6°','-2°','2°'})
xticks([18,20,22,24,26])
xticklabels({'18°','20°','22°','24°','26°'})
text(ax,textlim1,textlim2,'g)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')
ylabel('Congo','FontSize',10)

ax = nexttile(8);
contourf(lon_drc,lat_drc,flipud(rot90(Tb11_drc_mid)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_drc,lat_drc,flipud(rot90(perim_thick_drc_mid)),'Color',green,'LineWidth',1.5)
contour(lon_drc,lat_drc,flipud(rot90(perim_thin_drc_mid)),'Color',blue,'LineWidth',1.5)
yticks([-10,-6,-2,2])
yticklabels({'-10°','-6°','-2°','2°'})
xticks([18,20,22,24,26])
xticklabels({'18°','20°','22°','24°','26°'})
text(ax,textlim1,textlim2,'h)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(9);
contourf(lon_drc,lat_drc,flipud(rot90(Tb11_drc_high)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
c=colorbar;
c.Label.String = "11\mum Simulated Tb [K]";
c.Label.FontSize = 8;
hold on
contour(lon_drc,lat_drc,flipud(rot90(perim_thick_drc_high)),'Color',green,'LineWidth',1.5)
contour(lon_drc,lat_drc,flipud(rot90(perim_thin_drc_high)),'Color',blue,'LineWidth',1.5)
yticks([-10,-6,-2,2])
yticklabels({'-10°','-6°','-2°','2°'})
xticks([18,20,22,24,26])
xticklabels({'18°','20°','22°','24°','26°'})
text(ax,textlim1,textlim2,'i)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(10);
contourf(lon_phi,lat_phi,flipud(rot90(Tb11_phi_low)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_phi,lat_phi,flipud(rot90(perim_thick_phi_low)),'Color',green,'LineWidth',1.5)
contour(lon_phi,lat_phi,flipud(rot90(perim_thin_phi_low)),'Color',blue,'LineWidth',1.5)
yticks([14,16,18,20])
yticklabels({'14°','16°','18°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'j)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')
ylabel('Philippines','FontSize',10)

ax = nexttile(11);
contourf(lon_phi,lat_phi,flipud(rot90(Tb11_phi_mid)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_phi,lat_phi,flipud(rot90(perim_thick_phi_mid)),'Color',green,'LineWidth',1.5)
contour(lon_phi,lat_phi,flipud(rot90(perim_thin_phi_mid)),'Color',blue,'LineWidth',1.5)
yticks([14,16,18,20])
yticklabels({'14°','16°','18°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'k)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(12);
contourf(lon_phi,lat_phi,flipud(rot90(Tb11_phi_high)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
c=colorbar;
c.Label.String = "11\mum Simulated Tb [K]";
c.Label.FontSize = 8;
hold on
contour(lon_phi,lat_phi,flipud(rot90(perim_thick_phi_high)),'Color',green,'LineWidth',1.5)
contour(lon_phi,lat_phi,flipud(rot90(perim_thin_phi_high)),'Color',blue,'LineWidth',1.5)
yticks([14,16,18,20])
yticklabels({'14°','16°','18°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'l)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(13);
contourf(lon_wpo,lat_wpo,flipud(rot90(Tb11_wpo_low)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_wpo,lat_wpo,flipud(rot90(perim_thick_wpo_low)),'Color',green,'LineWidth',1.5)
contour(lon_wpo,lat_wpo,flipud(rot90(perim_thin_wpo_low)),'Color',blue,'LineWidth',1.5)
yticks([11,13,15])
yticklabels({'11°','13°','15°'})
xticks([136,138,140,142])
xticklabels({'136°','138°','140°','142°'})
text(ax,textlim1,textlim2,'m)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')
ylabel('Western Pacific','FontSize',10)

ax = nexttile(14);
contourf(lon_wpo,lat_wpo,flipud(rot90(Tb11_wpo_mid)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
hold on
contour(lon_wpo,lat_wpo,flipud(rot90(perim_thick_wpo_mid)),'Color',green,'LineWidth',1.5)
contour(lon_wpo,lat_wpo,flipud(rot90(perim_thin_wpo_mid)),'Color',blue,'LineWidth',1.5)
yticks([11,13,15])
yticklabels({'11°','13°','15°'})
xticks([136,138,140,142])
xticklabels({'136°','138°','140°','142°'})
text(ax,textlim1,textlim2,'n)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')

ax = nexttile(15);
contourf(lon_wpo,lat_wpo,flipud(rot90(Tb11_wpo_high)),80,'LineStyle','none')
cmap = cmocean('ice','negative') ;
colormap(cmap)
clim([200,300])
c=colorbar;
c.Label.String = "11\mum Simulated Tb [K]";
c.Label.FontSize = 8;
hold on
contour(lon_wpo,lat_wpo,flipud(rot90(perim_thick_wpo_high)),'Color',green,'LineWidth',1.5)
contour(lon_wpo,lat_wpo,flipud(rot90(perim_thin_wpo_high)),'Color',blue,'LineWidth',1.5)
yticks([11,13,15])
yticklabels({'11°','13°','15°'})
xticks([136,138,140,142])
xticklabels({'136°','138°','140°','142°'})
text(ax,textlim1,textlim2,'o)','units','normalized','FontSize',10,'Color','w','FontWeight','normal')