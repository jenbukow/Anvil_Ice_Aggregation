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
load("Vertical_Profiles/full_domain/OLR.mat");
olr_mean = squeeze(nanmean(OLR,1));
load("Vertical_Profiles/anvil_only/OLR_ANVIL.mat");
olr_mean_thick = squeeze(nanmean(OLR_thick,1));
olr_mean_thin  = squeeze(nanmean(OLR_thin,1));
olr_mean_anvil = squeeze(nanmean(OLR_anvil,1));
AGG = ["LOW","MID","HIGH"];
SIM = ["ARG1.1","AUS1.1","DRC1.1","PHI1.1","WPO1.1"];

for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j);
        agg = AGG(i);
        FILE  = "Vertical_Profiles/full_domain/INTCOND_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(INTCOND_ave,1);
        nstart = nt-6*4;
        nstart = 1;

        ITC1 = INTCOND_ave(:,1);
        ITC_ave(j,i,:) = nanmean(ITC1);
        ITC2 = INTCOND_sum(:,1);
        ITC_add(j,i,:) = nanmean(ITC2);

        FILE  = "Vertical_Profiles/full_domain/IWP_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(IWP_ave,1);
        nstart = nt-6*4;
        nstart = 1;

        IWP1 = IWP_ave(:,1);
        IWP_ave2(j,i,:) = nanmean(IWP1);
        IWP2 = IWP_sum(:,1);
        IWP_add(j,i,:) = nanmean(IWP2);
    end
end
ITC_mean = squeeze(nanmean(ITC_ave,1));
ITC_sum  = squeeze(nanmean(ITC_add,1));
IWP_mean = squeeze(nanmean(IWP_ave2,1));
IWP_sum  = squeeze(nanmean(IWP_add,1));

for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j);
        agg = AGG(i);
        FILE  = "Vertical_Profiles/anvil_only/INTCOND_ANVIL_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(INTCOND_ave_thick,1);
        nstart = nt-6*4;
        nstart = 1;

        ITC_thick1 = INTCOND_ave_thick(:,1);
        ITC_thick_ave(j,i,:) = nanmean(ITC_thick1);
        ITC_thick2 = INTCOND_sum_thick(:,1);
        ITC_thick_add(j,i,:) = nanmean(ITC_thick2);
        ITC_thin1 = INTCOND_ave_thin(:,1);
        ITC_thin_ave(j,i,:)  = nanmean(ITC_thin1);
        ITC_thin2 = INTCOND_sum_thin(:,1);
        ITC_thin_add(j,i,:)  = nanmean(ITC_thin2);
        ITC_anvil1 = INTCOND_ave_anvil(:,1);
        ITC_anvil_ave(j,i,:) = nanmean(ITC_anvil1);
        ITC_anvil2 = INTCOND_sum_anvil(:,1);
        ITC_anvil_add(j,i,:) = nanmean(ITC_anvil2);

        FILE  = "Vertical_Profiles/anvil_only/IWP_ANVIL_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(IWP_ave_thick,1);
        nstart = nt-6*4;
        nstart = 1;

        IWP_thick1 = IWP_ave_thick(:,1);
        IWP_thick_ave(j,i,:) = nanmean(IWP_thick1(:,1));
        IWP_thick2 = IWP_sum_thick(:,1);
        IWP_thick_add(j,i,:) = nanmean(IWP_thick2);
        IWP_thin1 = IWP_ave_thin(:,1);
        IWP_thin_ave(j,i,:)  = nanmean(IWP_thin1);
        IWP_thin2 = IWP_sum_thin(:,1);
        IWP_thin_add(j,i,:)  = nanmean(IWP_thin2);
        IWP_anvil1 = IWP_ave_anvil(:,1);
        IWP_anvil_ave(j,i,:) = nanmean(IWP_anvil1);
        IWP_anvil2 = IWP_sum_anvil(:,1);
        IWP_anvil_add(j,i,:) = nanmean(IWP_anvil2);
    end
end
ITC_mean_thick = squeeze(nanmean(ITC_thick_ave,1));
ITC_sum_thick  = squeeze(nansum(ITC_thick_add,1));
ITC_mean_thin  = squeeze(nanmean(ITC_thin_ave,1));
ITC_sum_thin   = squeeze(nansum(ITC_thin_add,1));
ITC_mean_anvil = squeeze(nanmean(ITC_anvil_ave,1));
ITC_sum_anvil  = squeeze(nansum(ITC_anvil_add,1));
IWP_mean_thick = squeeze(nanmean(IWP_thick_ave,1));
IWP_sum_thick  = squeeze(nansum(IWP_thick_add,1));
IWP_mean_thin  = squeeze(nanmean(IWP_thin_ave,1));
IWP_sum_thin   = squeeze(nansum(IWP_thin_add,1));
IWP_mean_anvil = squeeze(nanmean(IWP_anvil_ave,1));
IWP_sum_anvil  = squeeze(nansum(IWP_anvil_add,1));

for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j);
        agg = AGG(i);
        FILE  = "./Vertical_Profiles/full_domain/RAIN_2D_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(rainrate,1);
        %nstart = nt-6*4;
        nstart = 1;

        switch simname
            case "ARG1.1"
                nstartsw = 1;
                nendsw   = 22;
            case "AUS1.1"
                nstartsw = 1;
                nendsw   = 6;
            case "DRC1.1"
                nstartsw = 1;
                nendsw   = 44;
            case "PHI1.1"
                nstartsw = 1;
                nendsw   = 42;
            case "WPO1.1"
                nstartsw = 11;
                nendsw   = 61;               
        end

        rainrate1(j,i,:)  = nanmean(rainrate(nstart:end,:,:),'all');
        accprecip1(j,i,:) = nanmean(accprecip(end,:,:),'all'); % take the last timesetp of accumulated precip
        rainrate2(j,i,:)  = nansum(rainrate(nstart:end,:,:),'all');
        accprecip2(j,i,:) = nansum(accprecip(end,:,:),'all');

    end
end
rainrate_mean  = squeeze(nanmean(rainrate1,1));
accprecip_mean = squeeze(nanmean(accprecip1,1));
rainrate_sum   = squeeze(nanmean(rainrate2,1));
accprecip_sum  = squeeze(nanmean(accprecip2,1));

for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j);
        agg = AGG(i);
        FILE  = "./Vertical_Profiles/anvil_only/RAIN_2D_ANVIL_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(rainrate_thick,1);
        %nstart = nt-6*4;
        nstart = 1;

        switch simname
            case "ARG1.1"
                nstartsw = 1;
                nendsw   = 22;
            case "AUS1.1"
                nstartsw = 1;
                nendsw   = 6;
            case "DRC1.1"
                nstartsw = 1;
                nendsw   = 44;
            case "PHI1.1"
                nstartsw = 1;
                nendsw   = 42;
            case "WPO1.1"
                nstartsw = 11;
                nendsw   = 61;               
        end

        rainrate_thick1(j,i,:)  = nanmean(rainrate_thick(nstart:end,:,:),'all');
        accprecip_thick1(j,i,:) = nanmean(accprecip_thick(end,:,:),'all'); % take the last timesetp of accumulated precip
        rainrate_thin1(j,i,:)   = nanmean(rainrate_thin(nstart:end,:,:),'all');
        accprecip_thin1(j,i,:)  = nanmean(accprecip_thin(end,:,:),'all'); % take the last timesetp of accumulated precip
        rainrate_anvil1(j,i,:)  = nanmean(rainrate_anvil(nstart:end,:,:),'all');
        accprecip_anvil1(j,i,:) = nanmean(accprecip_anvil(end,:,:),'all'); % take the last timesetp of accumulated precip
        
        rainrate_thick2(j,i,:)  = nansum(rainrate_thick(nstart:end,:,:),'all');
        accprecip_thick2(j,i,:) = nansum(accprecip_thick(end,:,:),'all'); % take the last timesetp of accumulated precip
        rainrate_thin2(j,i,:)   = nansum(rainrate_thin(nstart:end,:,:),'all');
        accprecip_thin2(j,i,:)  = nansum(accprecip_thin(end,:,:),'all'); % take the last timesetp of accumulated precip
        rainrate_anvil2(j,i,:)  = nansum(rainrate_anvil(nstart:end,:,:),'all');
        accprecip_anvil2(j,i,:) = nansum(accprecip_anvil(end,:,:),'all'); % take the last timesetp of accumulated precip
        
    end
end

rainrate_mean_thick  = squeeze(nanmean(rainrate_thick1,1));
accprecip_mean_thick = squeeze(nanmean(accprecip_thick1,1));
rainrate_mean_thin   = squeeze(nanmean(rainrate_thin1,1));
accprecip_mean_thin  = squeeze(nanmean(accprecip_thin1,1));
rainrate_mean_anvil  = squeeze(nanmean(rainrate_anvil1,1));
accprecip_mean_anvil = squeeze(nanmean(accprecip_anvil1,1));
rainrate_sum_thick   = squeeze(nanmean(rainrate_thick2,1));
accprecip_sum_thick  = squeeze(nanmean(accprecip_thick2,1));
rainrate_sum_thin    = squeeze(nanmean(rainrate_thin2,1));
accprecip_sum_thin   = squeeze(nanmean(accprecip_thin2,1));
rainrate_sum_anvil   = squeeze(nanmean(rainrate_anvil2,1));
accprecip_sum_anvil  = squeeze(nanmean(accprecip_anvil2,1));

%%

textlim1 = 0.02; textlim2 = 0.93;
f=figure('Position', [10 10 1100 800]);
tiledlayout(2,3,'TileSpacing','Compact');
sz = 100;
x=[1,2,3];
xlims = [0.75,3.25];
gridtrans = 0.075;

ax = nexttile(1);
hold on; grid on; box on;
plot(x,olr_mean,'Color',gray,'LineWidth',0.5)
scatter(x(1),olr_mean(1),sz ,'k','filled')
scatter(x(2),olr_mean(2),sz ,'filled','k')
scatter(x(3),olr_mean(3),sz ,'filled','k')
ylabel('OLR [W/m^2]')
title('Domain Average OLR')
ax.TitleHorizontalAlignment = 'left';
xlim(xlims)
ylim([0,285])
xticks([x])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'a)','units','normalized','FontSize',12,'FontWeight','normal')

ax = nexttile(2);
hold on; grid on; box on;
plot(x,IWP_mean,'Color',gray,'LineWidth',0.5)
scatter(x(1),IWP_mean(1),sz ,'k','filled')
scatter(x(2),IWP_mean(2),sz ,'filled','k')
scatter(x(3),IWP_mean(3),sz ,'filled','k')
ylabel('IWP [mm]')
title('Domain Average IWP')
ax.TitleHorizontalAlignment = 'left';
%ylim([0,12.5])
xlim(xlims)
xticks([x])
ylim([0,.38])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'b)','units','normalized','FontSize',12,'FontWeight','normal')

ax = nexttile(3);
hold on; grid on; box on;
plot(x,accprecip_mean,'Color',gray,'LineWidth',0.5)
scatter(x(1),accprecip_mean(1),sz ,'k','filled')
scatter(x(2),accprecip_mean(2),sz ,'filled','k')
scatter(x(3),accprecip_mean(3),sz ,'filled','k')
ylabel('Accumlated Precipitation [mm]')
title('Domain Accumlated Precipitation')
ax.TitleHorizontalAlignment = 'left';
xlim(xlims)
xticks([x])
ylim([0,10.5])
% yticks([0,2,4,6,8,10])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'c)','units','normalized','FontSize',12,'FontWeight','normal')

ax = nexttile(4);
hold on; grid on; box on;
plot(x,olr_mean_thick,'Color',lightgreen,'LineWidth',0.5)
plot(x,olr_mean_thin,'Color',lightblue,'LineWidth',0.5)
plot(x,olr_mean_anvil,'Color',gray,'LineWidth',0.5)
scatter(x(1),olr_mean_anvil(1),sz ,'filled','MarkerFaceColor','k')
scatter(x(2),olr_mean_anvil(2),sz ,'filled','MarkerFaceColor','k')
scatter(x(3),olr_mean_anvil(3),sz ,'filled','MarkerFaceColor','k')
scatter(x(1),olr_mean_thick(1),sz ,'filled','MarkerFaceColor',green)
scatter(x(2),olr_mean_thick(2),sz ,'filled','MarkerFaceColor',green)
scatter(x(3),olr_mean_thick(3),sz ,'filled','MarkerFaceColor',green)
scatter(x(1),olr_mean_thin(1),sz ,'filled','MarkerFaceColor',blue)
scatter(x(2),olr_mean_thin(2),sz ,'filled','MarkerFaceColor',blue)
scatter(x(3),olr_mean_thin(3),sz ,'filled','MarkerFaceColor',blue)
ylabel('Anvil OLR [W/m^2]')
title('Anvil OLR','FontSize',12)
ax.TitleHorizontalAlignment = 'left';
yline(0,'Color',gray,'LineWidth',0.5,'LineStyle',':')
xlim([0.75,3.25])
ylim([0,260])
xticks([x])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'d)','units','normalized','FontSize',12,'Color','k','FontWeight','normal')
legend('','','','Total Anvil','','','Thick Anvil','','','Thin Anvil','Location','southwest')
ax.GridAlpha = gridtrans;
legend('','','','Total Anvil','','','Thick Anvil','','','Thin Anvil','Location','southwest','FontSize',12)

ax = nexttile(5);
hold on; grid on; box on;
plot(x,IWP_mean_thick,'Color',lightgreen,'LineWidth',0.5)
plot(x,IWP_mean_thin,'Color',lightblue,'LineWidth',0.5)
plot(x,IWP_mean_anvil,'Color',gray,'LineWidth',0.5)
scatter(x(1),IWP_mean_anvil(1),sz ,'filled','MarkerFaceColor','k')
scatter(x(2),IWP_mean_anvil(2),sz ,'filled','MarkerFaceColor','k')
scatter(x(3),IWP_mean_anvil(3),sz ,'filled','MarkerFaceColor','k')
scatter(x(1),IWP_mean_thick(1),sz ,'filled','MarkerFaceColor',green)
scatter(x(2),IWP_mean_thick(2),sz ,'filled','MarkerFaceColor',green)
scatter(x(3),IWP_mean_thick(3),sz ,'filled','MarkerFaceColor',green)
scatter(x(1),IWP_mean_thin(1),sz ,'filled','MarkerFaceColor',blue)
scatter(x(2),IWP_mean_thin(2),sz ,'filled','MarkerFaceColor',blue)
scatter(x(3),IWP_mean_thin(3),sz ,'filled','MarkerFaceColor',blue)
ylabel('Anvil IWP [mm]')
title('Anvil IWP','FontSize',12)
ax.TitleHorizontalAlignment = 'left';
yline(0,'Color',gray,'LineWidth',0.5,'LineStyle',':')
xlim([0.75,3.25])
ylim([0,2.2])
xticks([x])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'e)','units','normalized','FontSize',12,'Color','k','FontWeight','normal')
ax.GridAlpha = gridtrans;

ax = nexttile(6);
hold on; grid on; box on;
plot(x,accprecip_mean_thick,'Color',lightgreen,'LineWidth',0.5)
plot(x,accprecip_mean_thin,'Color',lightblue,'LineWidth',0.5)
plot(x,accprecip_mean_anvil,'Color',gray,'LineWidth',0.5)
scatter(x(1),accprecip_mean_anvil(1),sz ,'filled','MarkerFaceColor','k')
scatter(x(2),accprecip_mean_anvil(2),sz ,'filled','MarkerFaceColor','k')
scatter(x(3),accprecip_mean_anvil(3),sz ,'filled','MarkerFaceColor','k')
scatter(x(1),accprecip_mean_thick(1),sz ,'filled','MarkerFaceColor',green)
scatter(x(2),accprecip_mean_thick(2),sz ,'filled','MarkerFaceColor',green)
scatter(x(3),accprecip_mean_thick(3),sz ,'filled','MarkerFaceColor',green)
scatter(x(1),accprecip_mean_thin(1),sz ,'filled','MarkerFaceColor',blue)
scatter(x(2),accprecip_mean_thin(2),sz ,'filled','MarkerFaceColor',blue)
scatter(x(3),accprecip_mean_thin(3),sz ,'filled','MarkerFaceColor',blue)
ylabel('Anvil Accumlated Precipitation [mm]')
title('Anvil Accumlated Precipitation')
ax.TitleHorizontalAlignment = 'left';
yline(0,'Color',gray,'LineWidth',0.5,'LineStyle',':')
xlim([0.75,3.25])
ylim([0,37])
xticks([x])
xticklabels({'AGG-LOW','AGG-MID','AGG-HIGH'})
text(ax,textlim1,textlim2,'f)','units','normalized','FontSize',12,'Color','k','FontWeight','normal')
ax.GridAlpha = gridtrans;