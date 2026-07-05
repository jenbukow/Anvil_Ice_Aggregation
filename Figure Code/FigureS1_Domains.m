clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 10);
set(0,'DefaultAxesFontWeight', 'normal');
set(0,'DefaultTextFontSize',10);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)
addpath('../CDT-master/cdt'); 
addpath('../CDT-master/cdt/cdt_data/');
addpath('../slanCM/')
gray = [179, 182, 189]/255;
%%

nbdy = 25; %number of boundary pts to remove on each edge
simname ='AUS1.1-AGG-MID'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
savepath = "/tempest/jbukowski/MATLAB_TEST/AGG_Paper/INTCOND_PLOTS/" + simnameshort + "-" + simnameagg;

RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
numfiles_model = [length(RAMSFILES)]

dt_offset = (6*6)+1;
nz = 232;
nt = length(RAMSFILES_A)-dt_offset+1;

%%
NC = 256; % number of colors
RANGE1 = [1,160]; % which part of the colormap to use
%RANGE2 = [160,NC];
RANGE2 = [200,NC];
% colorbars that are used
cmap1 = (slanCM('lapaz',NC));
cmap2 = (slanCM('amethyst',NC));
cutoff = .2;
high = 6.1;
low = 0;
% interpolate both colormaps
cmap = zeros(NC,3);
i = 1:round((cutoff-low)/(high-low)*NC);
cmap(i,:) = interp1(cmap1(RANGE1(1):RANGE1(2),:),linspace(1,diff(RANGE1),length(i)));
i = round((cutoff-low)/(high-low)*NC)+1:NC;
cmap(i,:) = interp1(cmap2(RANGE2(1):RANGE2(2),:),linspace(1,diff(RANGE2),length(i)));

% 
% f=figure;
% imagesc((rot90(output_var)));
% colorbar
% %s.FaceColor = 'interp';
% saveas(f,'test.png')
% colormap(cmap)
% clim([0,6])
% %set(gca,'ColorScale','log')

%%

simname ='AUS1.1-AGG-MID'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
savepath = "/tempest/jbukowski/MATLAB_TEST/AGG_Paper/INTCOND_PLOTS/" + simnameshort + "-" + simnameagg;
RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
for k = 45:45
    trams=tmod(k)
    baseFileName = RAMSFILES_A(k).name;
    ramsfile = fullfile(RAMSPATH,baseFileName);
    baseFileName  = RAMSHEAD(k).name;
    headfile = fullfile(RAMSPATH,baseFileName);
    ITC_AUS = calc_itc(ramsfile,headfile);
    lat_aus = h5read(ramsfile,'/GLAT'); lat_aus = lat_aus(200,:);
    lon_aus = h5read(ramsfile,'/GLON'); lon_aus = lon_aus(:,200);
end

simname ='ARG1.1-AGG-MID'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
savepath = "/tempest/jbukowski/MATLAB_TEST/AGG_Paper/INTCOND_PLOTS/" + simnameshort + "-" + simnameagg;
RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
for k = 60:60
    trams=tmod(k)
    baseFileName = RAMSFILES_A(k).name;
    ramsfile = fullfile(RAMSPATH,baseFileName);
    baseFileName  = RAMSHEAD(k).name;
    headfile = fullfile(RAMSPATH,baseFileName);
    ITC_ARG = calc_itc(ramsfile,headfile);

    lat_arg = h5read(ramsfile,'/GLAT'); lat_arg = lat_arg(200,:);
    lon_arg = h5read(ramsfile,'/GLON'); lon_arg = lon_arg(:,200);
end

simname ='DRC1.1-AGG-MID'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
savepath = "/tempest/jbukowski/MATLAB_TEST/AGG_Paper/INTCOND_PLOTS/" + simnameshort + "-" + simnameagg;
RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
for k = 85:85
    trams=tmod(k)
    baseFileName = RAMSFILES_A(k).name;
    ramsfile = fullfile(RAMSPATH,baseFileName);
    baseFileName  = RAMSHEAD(k).name;
    headfile = fullfile(RAMSPATH,baseFileName);
    ITC_DRC = calc_itc(ramsfile,headfile);

    lat_drc = h5read(ramsfile,'/GLAT'); lat_drc = lat_drc(200,:);
    lon_drc = h5read(ramsfile,'/GLON'); lon_drc = lon_drc(:,200);
end

simname ='PHI1.1-AGG-MID'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
savepath = "/tempest/jbukowski/MATLAB_TEST/AGG_Paper/INTCOND_PLOTS/" + simnameshort + "-" + simnameagg;
RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
for k = 60:60
    trams=tmod(k)
    baseFileName = RAMSFILES_A(k).name;
    ramsfile = fullfile(RAMSPATH,baseFileName);
    baseFileName  = RAMSHEAD(k).name;
    headfile = fullfile(RAMSPATH,baseFileName);
    ITC_PHI = calc_itc(ramsfile,headfile);

    lat_phi = h5read(ramsfile,'/GLAT'); lat_phi = lat_phi(200,:);
    lon_phi = h5read(ramsfile,'/GLON'); lon_phi = lon_phi(:,200);
end

simname ='WPO1.1-AGG-MID'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
savepath = "/tempest/jbukowski/MATLAB_TEST/AGG_Paper/INTCOND_PLOTS/" + simnameshort + "-" + simnameagg;
RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
for k = 60:60
    trams=tmod(k)
    baseFileName = RAMSFILES_A(k).name;
    ramsfile = fullfile(RAMSPATH,baseFileName);
    baseFileName  = RAMSHEAD(k).name;
    headfile = fullfile(RAMSPATH,baseFileName);
    ITC_WPO = calc_itc(ramsfile,headfile);

    lat_wpo = h5read(ramsfile,'/GLAT'); lat_wpo = lat_wpo(200,:);
    lon_wpo = h5read(ramsfile,'/GLON'); lon_wpo = lon_wpo(:,200);
end
%%
% Define the latitude and longitude limits
latMin = min(lat_arg);
lonMin = min(lon_arg);
latMax = max(lat_arg);
lonMax = max(lon_arg);
lat_coords = [latMin, latMax, latMax, latMin, latMin];
lon_coords = [lonMin, lonMin, lonMax, lonMax, lonMin];
shape_arg  = geolineshape(lat_coords, lon_coords);

latMin = min(lat_aus);
lonMin = min(lon_aus);
latMax = max(lat_aus);
lonMax = max(lon_aus);
lat_coords = [latMin, latMax, latMax, latMin, latMin];
lon_coords = [lonMin, lonMin, lonMax, lonMax, lonMin];
shape_aus  = geolineshape(lat_coords, lon_coords);

latMin = min(lat_drc);
lonMin = min(lon_drc);
latMax = max(lat_drc);
lonMax = max(lon_drc);
lat_coords = [latMin, latMax, latMax, latMin, latMin];
lon_coords = [lonMin, lonMin, lonMax, lonMax, lonMin];
shape_drc  = geolineshape(lat_coords, lon_coords);

latMin = min(lat_phi);
lonMin = min(lon_phi);
latMax = max(lat_phi);
lonMax = max(lon_phi);
lat_coords = [latMin, latMax, latMax, latMin, latMin];
lon_coords = [lonMin, lonMin, lonMax, lonMax, lonMin];
shape_phi  = geolineshape(lat_coords, lon_coords);

latMin = min(lat_wpo);
lonMin = min(lon_wpo);
latMax = max(lat_wpo);
lonMax = max(lon_wpo);
lat_coords = [latMin, latMax, latMax, latMin, latMin];
lon_coords = [lonMin, lonMin, lonMax, lonMax, lonMin];
shape_wpo  = geolineshape(lat_coords, lon_coords);

%%
f=figure('Position', [10 10 1300 800],'visible','off');
t=tiledlayout(2,3,'TileSpacing','Compact');
textlim1 = 0.04; textlim2 = 0.93;
%nexttile(1);
gx = geoaxes(t);
gx.Layout.Tile = 1;
% Plot the shape on the geographic axes
geoplot(gx, shape_arg, 'Color', 'k', 'LineWidth', 2);
hold on
geoplot(gx, shape_aus, 'Color', 'k', 'LineWidth', 2);
geoplot(gx, shape_drc, 'Color', 'k', 'LineWidth', 2);
geoplot(gx, shape_phi, 'Color', 'k', 'LineWidth', 2);
geoplot(gx, shape_wpo, 'Color', 'k', 'LineWidth', 2);
geolimits(gx, [-60, 60], [-85, 155]);
geobasemap(gx, 'landcover')
title('Simulation Locations','FontSize',14)
gx.TitleHorizontalAlignment = 'left';
gx.LatitudeLabel.String="";
gx.LongitudeLabel.String="";
% gx.LatitudeAxis.TickLabels = "";
% gx.LongitudeAxis.TickLabels = "";
gx.LatitudeAxis.TickValues = [-60 -30 0 30 60];
gx.LongitudeAxis.TickValues = [-120 -60 0 60 120];
geotickformat(gx,'-dd')
text(gx,textlim1,textlim2,'a)','units','normalized','FontSize',12,'Color','k','FontWeight','bold')

ax = nexttile(2);
imagesc(lon_arg,lat_arg,flipud(rot90(ITC_ARG)));
set(gca,'layer','top');
colormap(cmap)
clim([0,6])
set(gca,'YDir','normal')
title('Argentina','FontSize',14)
axis on; grid on;
set(gca, 'GridLineStyle', '-', 'GridColor', gray,'GridLineWidth',1.5)
ax.TitleHorizontalAlignment = 'left';
xticks([-66,-64,-62,-60])
xticklabels({'-66°','-64°','-62°','-60°'})
yticks([-35,-34,-33,-32,-31,-30,-29])
yticklabels({'-35°','-34°','-33°','-32°','-31°','-30°','-29°'})
text(ax,textlim1,textlim2,'b)','units','normalized','FontSize',12,'Color','w','FontWeight','bold')
borders('countries','Color','k','LineWidth',0.5)

ax = nexttile(3);
imagesc(lon_aus,lat_aus,flipud(rot90(ITC_AUS)));
colormap(cmap)
c=colorbar;
c.Label.String = "Integrated Condensate [mm]";
c.Label.FontSize = 12;
clim([0,6])
set(gca,'YDir','normal')
title('Australia','FontSize',14)
axis on; grid on;
ax.TitleHorizontalAlignment = 'left';
set(gca, 'GridLineStyle', '-', 'GridColor', gray,'GridLineWidth',1.5)
yticks([-15,-14,-13,-12,-11,-10,-9,-8])
yticklabels({'-15°','-14°','-13°','-12°','-11°','-10°','-9°','-8°'})
xticks([124,126,128,130,132,134,136])
xticklabels({'124°','126°','128°','130°','132°','134°','136°'})
text(ax,textlim1,textlim2,'c)','units','normalized','FontSize',12,'Color','w','FontWeight','bold')
borders('countries','Color','k','LineWidth',0.5)

ax = nexttile(4);
imagesc(lon_drc,lat_drc,flipud(rot90(ITC_DRC)));
colormap(cmap)
clim([0,6])
set(gca,'YDir','normal')
title('Congo','FontSize',14)
axis on; grid on;
set(gca, 'GridLineStyle', '-', 'GridColor', gray,'GridLineWidth',1.5)
ax.TitleHorizontalAlignment = 'left';
yticks([-10,-8,-6,-4,-2,0,2])
yticklabels({'-10°','-8°','-6°','-4°','-2°','0°','2°'})
xticks([18,20,22,24,26])
xticklabels({'18°','20°','22°','24°','26°'})
text(ax,textlim1,textlim2,'d)','units','normalized','FontSize',12,'Color','w','FontWeight','bold')
borders('countries','Color','k','LineWidth',0.5)

ax = nexttile(5);
imagesc(lon_phi,lat_phi,flipud(rot90(ITC_PHI)));
colormap(cmap)
clim([0,6])
set(gca,'YDir','normal')
title('Philippines','FontSize',14)
axis on; grid on;
set(gca, 'GridLineStyle', '-', 'GridColor', gray,'GridLineWidth',1.5)
ax.TitleHorizontalAlignment = 'left';
yticks([14,15,16,17,18,19,20])
yticklabels({'14°','15°','16°','17°','18°','19°','20°'})
xticks([116,118,120,122])
xticklabels({'116°','118°','120°','122°'})
text(ax,textlim1,textlim2,'e)','units','normalized','FontSize',12,'Color','w','FontWeight','bold')
borders('countries','Color','k','LineWidth',0.5)

ax = nexttile(6);
imagesc(lon_wpo,lat_wpo,flipud(rot90(ITC_WPO)));
c=colorbar;
colormap(cmap)
clim([0,6])
set(gca,'YDir','normal')
title('Western Pacific','FontSize',14)
ax.TitleHorizontalAlignment = 'left';
c.Label.String = "Integrated Condensate [mm]";
c.Label.FontSize = 12;
yticks([11,12,13,14,15,16])
yticklabels({'11°','12°','13°','14°','15°','16°'})
xticks([136,138,140,142])
xticklabels({'136°','138°','140°','142°'})
axis on; grid on;
set(gca, 'GridLineStyle', '-', 'GridColor', gray,'GridLineWidth',1.5)
text(ax,textlim1,textlim2,'f)','units','normalized','FontSize',12,'Color','w','FontWeight','bold')
borders('countries','Color','k','LineWidth',0.5)

saveas(f,'test.png')
