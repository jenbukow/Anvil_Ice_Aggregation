clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 10);
set(0,'DefaultAxesFontWeight', 'normal');
%set(0,'DefaultTextFontSize',14);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)

lightgreen = [149, 219, 171]/255;
green = [26, 173, 74]/255;
darkgreen = [41, 105, 61]/255;
lightblue = [135, 162, 250]/255;
blue = [0, 60, 255]/255;
darkblue = [35, 57, 130]/255;
gray=[128, 125, 125]/255;
lightgray = [208 206 206]/255;
darkgray=[44, 47, 48]/255;

%%
Z = xlsread("Z_RAMS.xlsx")/1000;
ind0 = 51; ind20 = 80; ind30 = 91; ind40 = 101;
n = 15;

% start=[1 1 6]; stop=[Inf Inf 1];
AGG = ["LOW","MID","HIGH"];
SIM = ["ARG1.1","AUS1.1","DRC1.1","PHI1.1","WPO1.1"];

t = NaN(5,3,200);
t1 = datetime(2018,12,13,0,0,0);
t2 = datetime(2018,12,14,13,0,0);
t0 = t1:minutes(15):t2;
ntt = length(t0);
targ = nan(5,3,ntt);
CRE_LW_frac_thick  = NaN(5,3,ntt);
CRE_LW_frac_thin   = NaN(5,3,ntt);
CRE_LW_frac_anvil  = NaN(5,3,ntt);
CRE_SW_frac_thick  = NaN(5,3,ntt);
CRE_SW_frac_thin   = NaN(5,3,ntt);
CRE_SW_frac_anvil  = NaN(5,3,ntt);
CRE_NET_frac_thick = NaN(5,3,ntt);
CRE_NET_frac_thin  = NaN(5,3,ntt);
CRE_NET_frac_anvil = NaN(5,3,ntt);
CRE_LW_mean_thick1  = NaN(5,3,ntt);
CRE_LW_mean_thin1   = NaN(5,3,ntt);
CRE_LW_mean_anvil1  = NaN(5,3,ntt);
CRE_LW_mean_domain1 = NaN(5,3,ntt);
CRE_SW_mean_thick1  = NaN(5,3,ntt);
CRE_SW_mean_thin1   = NaN(5,3,ntt);
CRE_SW_mean_anvil1  = NaN(5,3,ntt);
CRE_SW_mean_domain1 = NaN(5,3,ntt);
CRE_NET_mean_thick1 = NaN(5,3,ntt);
CRE_NET_mean_thin1  = NaN(5,3,ntt);
CRE_NET_mean_anvil1 = NaN(5,3,ntt);
CRE_NET_mean_domain1 = NaN(5,3,ntt);
nthick = NaN(5,3,ntt);
nthin  = NaN(5,3,ntt);
nanvil = NaN(5,3,ntt);

for j = 1:5 % loop through sims
    for i = 1:3 % loop through aggs
        simname = SIM(j);
        agg = AGG(i);
        FILE  = "./Vertical_Profiles/anvil_only/CRE_ANVIL_" + simname + "_" + agg + ".mat";
        load(FILE);
        nt = size(CRE_LW_mean_thick,1);
        %nstart = nt-6*4;
        nstart = 1;
        tt = get_sim_time_local(simname);
        [~, idx1] = min(abs(t0 - tt(1))); 
        [~, idx2] = min(abs(t0 - tt(end))); 
        targ(j,i,idx1:idx2)=1;

        switch simname
            case "ARG1.1"
                nstartsw = 1;
                nendsw   = 22;
                nstartlw = 23;
            case "AUS1.1"
                nstartsw = 1;
                nendsw   = 1;
                nstartlw = 1;
                idx1 = idx1 -1 ;
                idx2 = idx2  +1;
            case "DRC1.1"
                nstartsw = 1;
                nendsw   = 44;
                nstartlw = 45;
            case "PHI1.1"
                nstartsw = 1;
                nendsw   = 42;
                nstartlw = 43;
            case "WPO1.1"
                nstartsw = 11;
                nendsw   = 61;
                nstartlw = 62;
        end

        CRE_LW_mean_thick1(j,i,idx1:idx2)  = nanmean(CRE_LW_mean_thick(nstart:end,:,:),[2,3]);
        CRE_LW_mean_thin1(j,i,idx1:idx2)   = nanmean(CRE_LW_mean_thin(nstart:end,:,:),[2,3]);
        CRE_LW_mean_anvil1(j,i,idx1:idx2)  = nanmean(CRE_LW_mean_anvil(nstart:end,:,:),[2,3]);
        CRE_LW_mean_domain1(j,i,idx1:idx2) = nanmean(CRE_LW_mean_domain(nstart:end,:,:),[2,3]);  
        CRE_SW_mean_thick1(j,i,idx1:idx2)  = nanmean(CRE_SW_mean_thick(nstart:end,:,:),[2,3]);
        CRE_SW_mean_thin1(j,i,idx1:idx2)   = nanmean(CRE_SW_mean_thin(nstart:end,:,:),[2,3]);
        CRE_SW_mean_anvil1(j,i,idx1:idx2)  = nanmean(CRE_SW_mean_anvil(nstart:end,:,:),[2,3]);
        CRE_SW_mean_domain1(j,i,idx1:idx2) = nanmean(CRE_SW_mean_domain(nstart:end,:,:),[2,3]);          
        CRE_NET_mean_thick1(j,i,idx1:idx2) = nanmean(CRE_NET_mean_thick(nstart:end,:,:),[2,3]);
        CRE_NET_mean_thin1(j,i,idx1:idx2)  = nanmean(CRE_NET_mean_thin(nstart:end,:,:),[2,3]);
        CRE_NET_mean_anvil1(j,i,idx1:idx2) = nanmean(CRE_NET_mean_anvil(nstart:end,:,:),[2,3]);
        CRE_NET_mean_domain1(j,i,idx1:idx2) = nanmean(CRE_NET_mean_domain(nstart:end,:,:),[2,3]);  

        CRE_LW_frac_thick(j,i,idx1:idx2)   = nanmean(CRE_LW_mean_frac_thick(nstart:end,:,:),[2,3]);
        CRE_LW_frac_thin(j,i,idx1:idx2)    = nanmean(CRE_LW_mean_frac_thin(nstart:end,:,:),[2,3]);
        CRE_LW_frac_anvil(j,i,idx1:idx2)   = nanmean(CRE_LW_mean_frac_anvil(nstart:end,:,:),[2,3]);
        CRE_SW_frac_thick(j,i,idx1:idx2)   = nanmean(CRE_SW_mean_frac_thick(nstart:end,:,:),[2,3]);
        CRE_SW_frac_thin(j,i,idx1:idx2)    = nanmean(CRE_SW_mean_frac_thin(nstart:end,:,:),[2,3]);
        CRE_SW_frac_anvil(j,i,idx1:idx2)   = nanmean(CRE_SW_mean_frac_anvil(nstart:end,:,:),[2,3]);
        CRE_NET_frac_thick(j,i,idx1:idx2)  = nanmean(CRE_NET_mean_frac_thick(nstart:end,:,:),[2,3]); %%check start time
        CRE_NET_frac_thin(j,i,idx1:idx2)   = nanmean(CRE_NET_mean_frac_thin(nstart:end,:,:),[2,3]);   %%check start time
        CRE_NET_frac_anvil(j,i,idx1:idx2)  = nanmean(CRE_NET_mean_frac_anvil(nstart:end,:,:),[2,3]);

        frac_thick(j,i,idx1:idx2) = cloud_frac_thick(nstart:end,1);
        frac_thin(j,i,idx1:idx2)  = cloud_frac_thin(nstart:end,1);
        frac_anvil(j,i,idx1:idx2) = cloud_frac_anvil(nstart:end,1);

        nthick(j,i,idx1:idx2) = ncloud_thick(nstart:end,1);
        nthin(j,i,idx1:idx2)  = ncloud_thin(nstart:end,1);
        nanvil(j,i,idx1:idx2) = ncloud_anvil(nstart:end,1);
    end
end

CRE_LW_mean_frac_thick  = squeeze(nanmean(CRE_LW_frac_thick,1));
CRE_LW_mean_frac_thin   = squeeze(nanmean(CRE_LW_frac_thin,1));
CRE_LW_mean_frac_anvil  = squeeze(nanmean(CRE_LW_frac_anvil,1));
CRE_SW_mean_frac_thick  = squeeze(nanmean(CRE_SW_frac_thick,1));
CRE_SW_mean_frac_thin   = squeeze(nanmean(CRE_SW_frac_thin,1));
CRE_SW_mean_frac_anvil  = squeeze(nanmean(CRE_SW_frac_anvil,1));
CRE_NET_mean_frac_thick = squeeze(nanmean(CRE_NET_frac_thick,1));
CRE_NET_mean_frac_thin  = squeeze(nanmean(CRE_NET_frac_thin,1));
CRE_NET_mean_frac_anvil = squeeze(nanmean(CRE_NET_frac_anvil,1));
% CRE_NET_mean_frac_thick = CRE_LW_mean_frac_thick + CRE_SW_mean_frac_thick;
% CRE_NET_mean_frac_thin  = CRE_LW_mean_frac_thin  + CRE_SW_mean_frac_thin;
% CRE_NET_mean_frac_anvil = CRE_LW_mean_frac_anvil + CRE_SW_mean_frac_anvil;

CRE_LW_mean_thick11  = squeeze(nanmean(CRE_LW_mean_thick1,1));
CRE_LW_mean_thin11   = squeeze(nanmean(CRE_LW_mean_thin1,1));
CRE_LW_mean_anvil11  = squeeze(nanmean(CRE_LW_mean_anvil1,1));
CRE_LW_mean_domain11 = squeeze(nanmean(CRE_LW_mean_domain1,1));
CRE_SW_mean_thick11  = squeeze(nanmean(CRE_SW_mean_thick1,1));
CRE_SW_mean_thin11   = squeeze(nanmean(CRE_SW_mean_thin1,1));
CRE_SW_mean_anvil11  = squeeze(nanmean(CRE_SW_mean_anvil1,1));
CRE_SW_mean_domain11 = squeeze(nanmean(CRE_SW_mean_domain1,1));
CRE_NET_mean_thick11 = squeeze(nanmean(CRE_NET_mean_thick1,1));
CRE_NET_mean_thin11  = squeeze(nanmean(CRE_NET_mean_thin1,1));
CRE_NET_mean_anvil11 = squeeze(nanmean(CRE_NET_mean_anvil1,1));
CRE_NET_mean_domain11 = squeeze(nanmean(CRE_NET_mean_domain1,1));

%%

textlim1 = 0.02; textlim2 = 0.93;
f=figure('Position', [10 10 1200 400]);
tiledlayout(1,3,'TileSpacing','Compact');

ax = nexttile(1);
hold on
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_thick(1,:)),"movmean",10),'Color',darkgreen)
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_thick(2,:)),"movmean",10),'Color',green)
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_thick(3,:)),"movmean",10),'Color',lightgreen)
hold off
box on; grid on;
legend('LOW','MID','HIGH','Position',[0.14 .78 0.08 0.12])
xlim([t0(25),t0(109)])
xtickformat('HH:mm')
ylim([-150,150])
ax = gca;
ax.XTickLabel = ax.XTickLabel;
xsecondarylabel(Visible='off')
xlabel('Local Time')
ylabel('Fractional TOA CRE [W/m^2]')
text(ax,textlim1,textlim2,'d)','units','normalized','FontSize',12,'FontWeight','normal')

ax = nexttile(2);
hold on
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_thin(1,:)),"movmean",10),'Color',darkblue)
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_thin(2,:)),"movmean",10),'Color',blue)
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_thin(3,:)),"movmean",10),'Color',lightblue)
hold off
box on; grid on;
legend('LOW','MID','HIGH','Position',[0.417 .78 0.08 0.12])
xlim([t0(25),t0(109)])
xtickformat('HH:mm')
ax = gca;
ylim([-150,150])
ax.XTickLabel = ax.XTickLabel;
xsecondarylabel(Visible='off')
xlabel('Local Time')
%ylabel('Fractional TOA CRE [W/m^2]')
text(ax,textlim1,textlim2,'e)','units','normalized','FontSize',12,'FontWeight','normal')

ax = nexttile(3);
hold on
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_anvil(1,:)),"movmean",10),'Color','k')
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_anvil(2,:)),"movmean",10),'Color',gray)
plot(t0,smoothdata(squeeze(CRE_NET_mean_frac_anvil(3,:)),"movmean",10),'Color',lightgray)
hold off
box on; grid on;
legend('LOW','MID','HIGH','Position',[0.693 .78 0.08 0.12])
xlim([t0(25),t0(109)])
xtickformat('HH:mm')
ax = gca;
ylim([-150,150])
ax.XTickLabel = ax.XTickLabel;
xsecondarylabel(Visible='off')
xlabel('Local Time')
%ylabel('Fractional TOA CRE [W/m^2]')
text(ax,textlim1,textlim2,'f)','units','normalized','FontSize',12,'FontWeight','normal')
