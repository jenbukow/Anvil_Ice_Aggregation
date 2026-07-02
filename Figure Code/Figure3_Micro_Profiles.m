clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 12);
set(0,'DefaultAxesFontWeight', 'normal');
%set(0,'DefaultTextFontSize',14);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)

gray      = [128, 125, 125]/255;
lightgray = [208 206 206]/255;
darkgray  = [44, 47, 48]/255;

blue = [60, 94, 186]/255;
darkblue = [9, 26, 61]/255;
lightblue = [82, 132, 179]/255;
LB = [0 176 240]/255;
midblue = [38, 103, 166]/255;
lightblue2 = [150, 194, 227]/255;

darkgreen  = [35, 74, 47]/255;
midgreen   = [74, 133, 83]/255;
lightgreen = [137, 201, 145]/255;

darkpurple  = [34, 19, 66]/255;
midpurple   = [114, 70, 156]/255;
lightpurple = [182, 163, 191]/255;

darkorange  = [150, 73, 2]/255;
midorange   = [207, 130, 60]/255;
lightorange = [219, 175, 132]/255;

% darkred = [92, 13, 20]/255;
% midred = [166, 91, 93]/255;
% lightred = [209, 155, 155]/255;

darkmagenta  = [97, 11, 61]/255;
midmagenta   = [166, 83, 121]/255;
lightmagenta = [189, 142, 163]/255;

%%
% start=[1 1 6]; stop=[Inf Inf 1];
AGG = ["LOW","MID","HIGH"];
SIM = ["ARG1.1","AUS1.1","DRC1.1","PHI1.1","WPO1.1"];

for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j)
        agg = AGG(i);
        FILE  = "Vertical_Profiles/anvil_only/MP_MASS_ANVIL_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(qa_ave_thick,1);
        nstart = 1;

        qa_thick(j,i,:) = nanmean(qa_ave_thick(nstart:end,:),1);
        qc_thick(j,i,:) = nanmean(qc_ave_thick(nstart:end,:),1);
        qd_thick(j,i,:) = nanmean(qd_ave_thick(nstart:end,:),1);
        qg_thick(j,i,:) = nanmean(qg_ave_thick(nstart:end,:),1);
        qh_thick(j,i,:) = nanmean(qh_ave_thick(nstart:end,:),1);
        qi_thick(j,i,:) = nanmean(qi_ave_thick(nstart:end,:),1);
        qr_thick(j,i,:) = nanmean(qr_ave_thick(nstart:end,:),1);
        qs_thick(j,i,:) = nanmean(qs_ave_thick(nstart:end,:),1);
        qv_thick(j,i,:) = nanmean(qv_ave_thick(nstart:end,:),1);
        rime_ice_thick(j,i,:) = nanmean(qg_ave_thick(nstart:end,:)+qh_ave_thick(nstart:end,:),1);
        
        qa_thin(j,i,:)  = nanmean(qa_ave_thin(nstart:end,:),1);
        qc_thin(j,i,:)  = nanmean(qc_ave_thin(nstart:end,:),1);
        qd_thin(j,i,:)  = nanmean(qd_ave_thin(nstart:end,:),1);
        qg_thin(j,i,:)  = nanmean(qg_ave_thin(nstart:end,:),1);
        qh_thin(j,i,:)  = nanmean(qh_ave_thin(nstart:end,:),1);
        qi_thin(j,i,:)  = nanmean(qi_ave_thin(nstart:end,:),1);
        qr_thin(j,i,:)  = nanmean(qr_ave_thin(nstart:end,:),1);
        qs_thin(j,i,:)  = nanmean(qs_ave_thin(nstart:end,:),1);
        qv_thin(j,i,:)  = nanmean(qv_ave_thin(nstart:end,:),1);
        rime_ice_thin(j,i,:) = nanmean(qg_ave_thin(nstart:end,:)+qh_ave_thin(nstart:end,:),1);

        qa_anvil(j,i,:) = nanmean(qa_ave_anvil(nstart:end,:),1);
        qc_anvil(j,i,:) = nanmean(qc_ave_anvil(nstart:end,:),1);
        qd_anvil(j,i,:) = nanmean(qd_ave_anvil(nstart:end,:),1);
        qg_anvil(j,i,:) = nanmean(qg_ave_anvil(nstart:end,:),1);
        qh_anvil(j,i,:) = nanmean(qh_ave_anvil(nstart:end,:),1);
        qi_anvil(j,i,:) = nanmean(qi_ave_anvil(nstart:end,:),1);
        qr_anvil(j,i,:) = nanmean(qr_ave_anvil(nstart:end,:),1);
        qs_anvil(j,i,:) = nanmean(qs_ave_anvil(nstart:end,:),1);
        qv_anvil(j,i,:) = nanmean(qv_ave_anvil(nstart:end,:),1);
        rime_ice_anvil(j,i,:) = nanmean(qg_ave_anvil(nstart:end,:)+qh_ave_anvil(nstart:end,:),1);
    end
end

qa_thick_mean = squeeze(nanmean(qa_thick,1));
qc_thick_mean = squeeze(nanmean(qc_thick,1));
qd_thick_mean = squeeze(nanmean(qd_thick,1));
qg_thick_mean = squeeze(nanmean(qg_thick,1));
qh_thick_mean = squeeze(nanmean(qh_thick,1));
qi_thick_mean = squeeze(nanmean(qi_thick,1));
qr_thick_mean = squeeze(nanmean(qr_thick,1));
qs_thick_mean = squeeze(nanmean(qs_thick,1));
qv_thick_mean = squeeze(nanmean(qv_thick,1));
rime_ice_thick_mean = squeeze(nanmean(rime_ice_thick,1));

qa_thin_mean = squeeze(nanmean(qa_thin,1));
qc_thin_mean = squeeze(nanmean(qc_thin,1));
qd_thin_mean = squeeze(nanmean(qd_thin,1));
qg_thin_mean = squeeze(nanmean(qg_thin,1));
qh_thin_mean = squeeze(nanmean(qh_thin,1));
qi_thin_mean = squeeze(nanmean(qi_thin,1));
qr_thin_mean = squeeze(nanmean(qr_thin,1));
qs_thin_mean = squeeze(nanmean(qs_thin,1));
qv_thin_mean = squeeze(nanmean(qv_thin,1));
rime_ice_thin_mean = squeeze(nanmean(rime_ice_thin,1));

qa_anvil_mean = squeeze(nanmean(qa_anvil,1));
qc_anvil_mean = squeeze(nanmean(qc_anvil,1));
qd_anvil_mean = squeeze(nanmean(qd_anvil,1));
qg_anvil_mean = squeeze(nanmean(qg_anvil,1));
qh_anvil_mean = squeeze(nanmean(qh_anvil,1));
qi_anvil_mean = squeeze(nanmean(qi_anvil,1));
qr_anvil_mean = squeeze(nanmean(qr_anvil,1));
qs_anvil_mean = squeeze(nanmean(qs_anvil,1));
qv_anvil_mean = squeeze(nanmean(qv_anvil,1));
rime_ice_anvil_mean = squeeze(nanmean(rime_ice_anvil,1));

%%
Z = xlsread("Z_RAMS.xlsx")/1000;
ind0 = 51; ind20 = 80; ind30 = 91; ind40 = 101;
n = 15;
textlim1 = 0.05; textlim2 = 0.96;
f=figure('Position', [10 10 1000 400]);
tiledlayout(1,5,'TileSpacing','Compact');
gray=[208 206 206]/255;
darkgray=[44, 47, 48]/255;

ax = nexttile(1);
hold on; grid on; box on;
yline(Z(ind40),':','color',darkblue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind20),':','color',blue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind0),':','color',lightblue,'LineWidth',1.0,Layer='bottom')
plot(10^4*smooth(qi_anvil_mean(1,:),n),Z,'Color',darkorange)
plot(10^4*smooth(qi_anvil_mean(2,:),n),Z,'Color',midorange)
plot(10^4*smooth(qi_anvil_mean(3,:),n),Z,'Color',lightorange)
legend('','','','LOW','MID','HIGH')
ylim([0,21])
xlim([0,1.85])
ylabel('Height [km]')
xlabel('Ice MR [g/kg]')
title('Pristine Ice')
xticks([0,0.5,1.0,1.5])
ax.TitleHorizontalAlignment = 'left';
text(ax,textlim1,textlim2,'a)','units','normalized','FontSize',10,'Color','k','FontWeight','normal')

ax = nexttile(2);
hold on; grid on; box on;
yline(Z(ind40),':','color',darkblue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind20),':','color',blue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind0),':','color',lightblue,'LineWidth',1.0,Layer='bottom')
plot(10^4*smooth(qs_anvil_mean(1,:),n),Z,'Color',darkmagenta)
plot(10^4*smooth(qs_anvil_mean(2,:),n),Z,'Color',midmagenta)
plot(10^4*smooth(qs_anvil_mean(3,:),n),Z,'Color',lightmagenta)
legend('','','','LOW','MID','HIGH')
ylim([0,21])
title('Snow')
ax.TitleHorizontalAlignment = 'left';
xlim([0,.15])
%ylabel('Height [km]')
xlabel('Snow MR [g/kg]')
text(ax,textlim1,textlim2,'b)','units','normalized','FontSize',10,'Color','k','FontWeight','normal')

ax = nexttile(3);
hold on; grid on; box on;
yline(Z(ind40),':','color',darkblue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind20),':','color',blue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind0),':','color',lightblue,'LineWidth',1.0,Layer='bottom')
plot(10^4*smooth(qa_anvil_mean(1,:),n),Z,'Color',darkpurple)
plot(10^4*smooth(qa_anvil_mean(2,:),n),Z,'Color',midpurple)
plot(10^4*smooth(qa_anvil_mean(3,:),n),Z,'Color',lightpurple)
legend('','','','LOW','MID','HIGH')
ylim([0,21])
xlim([0,1.85])
xticks([0,0.5,1.0,1.5])
%ylabel('Height [km]')
xlabel('Aggregate MR [g/kg]')
title('Aggregates')
ax.TitleHorizontalAlignment = 'left';
text(ax,textlim1,textlim2,'c)','units','normalized','FontSize',10,'Color','k','FontWeight','normal')

ax = nexttile(4);
hold on; grid on; box on;
yline(Z(ind40),':','color',darkblue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind20),':','color',blue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind0),':','color',lightblue,'LineWidth',1.0,Layer='bottom')
plot(10^4*smooth(rime_ice_anvil_mean(1,:),n),Z,'Color',darkgreen)
plot(10^4*smooth(rime_ice_anvil_mean(2,:),n),Z,'Color',midgreen)
plot(10^4*smooth(rime_ice_anvil_mean(3,:),n),Z,'Color',lightgreen)
legend('','','','LOW','MID','HIGH')
ylim([0,21])
xlim([0,1.85])
xticks([0,0.5,1.0,1.5])
%xlim([0,.3])
%ylabel('Height [km]')
xlabel('Rimed Ice MR [g/kg]')
title('Graupel + Hail')
ax.TitleHorizontalAlignment = 'left';
text(ax,textlim1,textlim2,'d)','units','normalized','FontSize',10,'Color','k','FontWeight','normal')

ax = nexttile(5);
hold on; grid on; box on;
yline(Z(ind40),':','color',darkblue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind20),':','color',blue,'LineWidth',1.0,Layer='bottom')
yline(Z(ind0),':','color',lightblue,'LineWidth',1.0,Layer='bottom')
plot(10^4*smooth(qr_anvil_mean(1,:),n),Z,'Color',darkblue)
plot(10^4*smooth(qr_anvil_mean(2,:),n),Z,'Color',midblue)
plot(10^4*smooth(qr_anvil_mean(3,:),n),Z,'Color',lightblue2)
legend('','','','LOW','MID','HIGH')
ylim([0,21])
xlim([0,1.85])
xticks([0,0.5,1.0,1.5])
%ylabel('Height [km]')
xlabel('Rain MR [g/kg]')
title('Rain')
ax.TitleHorizontalAlignment = 'left';
text(ax,textlim1,textlim2,'e)','units','normalized','FontSize',10,'Color','k','FontWeight','normal')
