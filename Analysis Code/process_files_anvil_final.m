clc ; clear all ; close all
set(0,'DefaultAxesFontSize', 10);
set(0,'DefaultAxesFontWeight', 'normal');
set(0,'DefaultTextFontSize',10);
set(0,'DefaultTextFontWeight','normal');
set(0,'DefaultLineLineWidth',3.0)
addpath('../CDT-master/cdt'); 
addpath('../CDT-master/cdt/cdt_data/');
%%
poolobj=parpool(5);
fprintf('Number of workers: %g\n', poolobj.NumWorkers);
%%
nbdy = 25; %number of boundary pts to remove on each edge
savepath ='/tempest/jbukowski/MATLAB_TEST/AGG_Paper/Vertical_Profiles/anvil_only/';
simname ='ARG1.1-AGG-HIGH'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));
tmod=get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
RAMSPATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';

simname ='ARG1.1-AGG-LOW'; % use the rams sim name
GEOIRPATH  = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simname + '/GEO_IR/';

simname ='ARG1.1-AGG-HIGH'; % use the rams sim name
simnameshort = split(simname,'-'); simnameshort=cell2mat(simnameshort(1));
simnameagg = split(simname,'-'); simnameagg=cell2mat(simnameagg(3));

GEOIRFILES  = dir(fullfile(GEOIRPATH,'*.nc'));
RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
RAMSFILES_A  = dir(fullfile(RAMSPATH,'a-A*.h5'));
RAMSHEAD    = dir(fullfile(RAMSPATH,'a-L*.txt'));
numfiles_geoir = [length(GEOIRFILES)]
numfiles_model = [length(RAMSFILES)]

%%
dt_offset = (6*12)+1;
nz = 232;
nt = length(RAMSFILES)-dt_offset+1;
baseFileName = GEOIRFILES(1).name;
testfile = fullfile(GEOIRPATH, baseFileName);
lat2 = ncread(testfile,'xlat'); lon2 = ncread(testfile,'xlon');
lat_rams = double(lat2(200,:)); lon_rams = double(lon2(:,200));
lat_rams_wrap = lat_rams+90; lon_rams_wrap = lon_rams+180;
lat_rams_wrap=lat_rams_wrap(nbdy:(end-nbdy)); lon_rams_wrap=lon_rams_wrap(nbdy:(end-nbdy));
nx = size(lat2,1);
ny = size(lat2,2);
clear testfile baseFileName lat2 lon2

%% mixing ratios
savepath ='/tempest/jbukowski/MATLAB_TEST/AGG_Paper/Vertical_Profiles/anvil_only/';
sims = ["ARG1.1-AGG-LOW","AUS1.1-AGG-LOW","DRC1.1-AGG-LOW","PHI1.1-AGG-LOW","WPO1.1-AGG-LOW",...
        "ARG1.1-AGG-MID","AUS1.1-AGG-MID","DRC1.1-AGG-MID","PHI1.1-AGG-MID","WPO1.1-AGG-MID",...
        "ARG1.1-AGG-HIGH","AUS1.1-AGG-HIGH","DRC1.1-AGG-HIGH","PHI1.1-AGG-HIGH","WPO1.1-AGG-HIGH"];
dt_offset = (6*12)+1;
nz = 232;

parfor i = 1:15
    simname = sims(i);
    simnameshort = split(simname,'-'); simnameshort = cell2mat(simnameshort(1));
    simnameagg   = split(simname,'-'); simnameagg   = cell2mat(simnameagg(3));
    tmod = get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
    RAMSPATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
    GEOIRPATH   = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simname + '/GEO_IR/';
    GEOIRFILES  = dir(fullfile(GEOIRPATH,'*.nc'));
    RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
    RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
    RAMSHEAD    = dir(fullfile(RAMSPATH,'a-L*.txt'));
    numfiles_geoir = [length(GEOIRFILES)];
    numfiles_model = [length(RAMSFILES)];
    nt = length(RAMSFILES)-dt_offset+1;

    qa_ave_thick = NaN(nt,nz); qi_ave_thick = NaN(nt,nz); qs_ave_thick = NaN(nt,nz);
    qc_ave_thick = NaN(nt,nz); qh_ave_thick = NaN(nt,nz); qr_ave_thick = NaN(nt,nz);
    qg_ave_thick = NaN(nt,nz); qv_ave_thick = NaN(nt,nz); qd_ave_thick = NaN(nt,nz);
    qa_ave_thin  = NaN(nt,nz); qi_ave_thin  = NaN(nt,nz); qs_ave_thin  = NaN(nt,nz);
    qc_ave_thin  = NaN(nt,nz); qh_ave_thin  = NaN(nt,nz); qr_ave_thin  = NaN(nt,nz);
    qg_ave_thin  = NaN(nt,nz); qv_ave_thin  = NaN(nt,nz); qd_ave_thin  = NaN(nt,nz);
    qa_ave_inter = NaN(nt,nz); qi_ave_inter = NaN(nt,nz); qs_ave_inter = NaN(nt,nz);
    qc_ave_inter = NaN(nt,nz); qh_ave_inter = NaN(nt,nz); qr_ave_inter = NaN(nt,nz);
    qg_ave_inter = NaN(nt,nz); qv_ave_inter = NaN(nt,nz); qd_ave_inter = NaN(nt,nz);

    for k = dt_offset:length(RAMSFILES)
        prog = round(100*k/length(RAMSFILES));
        fprintf('MP_MASS is %i percent complete.\n',prog);
        trams=tmod(k)

        baseFileName = RAMSFILES(k).name;
        fullFileName = fullfile(RAMSPATH,baseFileName);
        kk = k-dt_offset+1;

        [BW_thick,BW_thin,BW_inter,perim_thick,perim_thin] = track_anvil(kk,GEOIRFILES,GEOIRPATH,simnameshort);

        qa = h5read(fullFileName,'/RAP');
        qi = h5read(fullFileName,'/RPP');
        qs = h5read(fullFileName,'/RSP');
        qc = h5read(fullFileName,'/RCP');
        qh = h5read(fullFileName,'/RHP');
        qg = h5read(fullFileName,'/RGP');
        qr = h5read(fullFileName,'/RRP');
        qv = h5read(fullFileName,'/RV');
        qd = h5read(fullFileName,'/RDP');

        qa_thick = qa; qi_thick = qi; qs_thick = qs;
        qc_thick = qc; qh_thick = qh; qg_thick = qg;
        qr_thick = qr; qv_thick = qv; qd_thick = qd;
        qa_thin  = qa; qi_thin  = qi; qs_thin  = qs;
        qc_thin  = qc; qh_thin  = qh; qg_thin  = qg;
        qr_thin  = qr; qv_thin  = qv; qd_thin  = qd;
        qa_inter = qa; qi_inter = qi; qs_inter = qs;
        qc_inter = qc; qh_inter = qh; qg_inter = qg;
        qr_inter = qr; qv_inter = qv; qd_inter = qd;

        BW_thick = repmat(BW_thick,1,1,nz);
        BW_thin  = repmat(BW_thin,1,1,nz);
        BW_inter = repmat(BW_inter,1,1,nz);

        qa_thick(BW_thick==0)=NaN; qi_thick(BW_thick==0)=NaN; qs_thick(BW_thick==0)=NaN;
        qc_thick(BW_thick==0)=NaN; qh_thick(BW_thick==0)=NaN; qg_thick(BW_thick==0)=NaN;
        qr_thick(BW_thick==0)=NaN; qv_thick(BW_thick==0)=NaN; qd_thick(BW_thick==0)=NaN;
        qa_thin(BW_thin==0)=NaN;   qi_thin(BW_thin==0)=NaN;   qs_thin(BW_thin==0)=NaN;
        qc_thin(BW_thin==0)=NaN;   qh_thin(BW_thin==0)=NaN;   qg_thin(BW_thin==0)=NaN;
        qr_thin(BW_thin==0)=NaN;   qv_thin(BW_thin==0)=NaN;   qd_thin(BW_thin==0)=NaN;
        qa_inter(BW_inter==0)=NaN; qi_inter(BW_inter==0)=NaN; qs_inter(BW_inter==0)=NaN;
        qc_inter(BW_inter==0)=NaN; qh_inter(BW_inter==0)=NaN; qg_inter(BW_inter==0)=NaN;
        qr_inter(BW_inter==0)=NaN; qv_inter(BW_inter==0)=NaN; qd_inter(BW_thin==0)=NaN;

        qa_ave_thick(kk,:) = squeeze(nanmean(qa_thick,[1,2]));
        qi_ave_thick(kk,:) = squeeze(nanmean(qi_thick,[1,2]));
        qs_ave_thick(kk,:) = squeeze(nanmean(qs_thick,[1,2]));
        qc_ave_thick(kk,:) = squeeze(nanmean(qc_thick,[1,2]));
        qh_ave_thick(kk,:) = squeeze(nanmean(qh_thick,[1,2]));
        qg_ave_thick(kk,:) = squeeze(nanmean(qg_thick,[1,2]));
        qr_ave_thick(kk,:) = squeeze(nanmean(qr_thick,[1,2]));
        qv_ave_thick(kk,:) = squeeze(nanmean(qv_thick,[1,2]));
        qd_ave_thick(kk,:) = squeeze(nanmean(qd_thick,[1,2]));

        qa_ave_thin(kk,:)  = squeeze(nanmean(qa_thin,[1,2]));
        qi_ave_thin(kk,:)  = squeeze(nanmean(qi_thin,[1,2]));
        qs_ave_thin(kk,:)  = squeeze(nanmean(qs_thin,[1,2]));
        qc_ave_thin(kk,:)  = squeeze(nanmean(qc_thin,[1,2]));
        qh_ave_thin(kk,:)  = squeeze(nanmean(qh_thin,[1,2]));
        qg_ave_thin(kk,:)  = squeeze(nanmean(qg_thin,[1,2]));
        qr_ave_thin(kk,:)  = squeeze(nanmean(qr_thin,[1,2]));
        qv_ave_thin(kk,:)  = squeeze(nanmean(qv_thin,[1,2]));
        qd_ave_thin(kk,:)  = squeeze(nanmean(qd_thin,[1,2]));

        qa_ave_inter(kk,:) = squeeze(nanmean(qa_inter,[1,2]));
        qi_ave_inter(kk,:) = squeeze(nanmean(qi_inter,[1,2]));
        qs_ave_inter(kk,:) = squeeze(nanmean(qs_inter,[1,2]));
        qc_ave_inter(kk,:) = squeeze(nanmean(qc_inter,[1,2]));
        qh_ave_inter(kk,:) = squeeze(nanmean(qh_inter,[1,2]));
        qg_ave_inter(kk,:) = squeeze(nanmean(qg_inter,[1,2]));
        qr_ave_inter(kk,:) = squeeze(nanmean(qr_inter,[1,2]));
        qv_ave_inter(kk,:) = squeeze(nanmean(qv_inter,[1,2]));
        qd_ave_inter(kk,:) = squeeze(nanmean(qd_inter,[1,2]));
    end

    name=savepath+"MP_MASS_ANVIL_"+ simnameshort + '_' + simnameagg + '.mat';
    s = struct("qa_ave_thick",qa_ave_thick,"qi_ave_thick",qi_ave_thick,"qs_ave_thick",qs_ave_thick,"qc_ave_thick",qc_ave_thick,"qh_ave_thick",qh_ave_thick,...
        "qg_ave_thick",qg_ave_thick,"qr_ave_thick",qr_ave_thick,"qv_ave_thick",qv_ave_thick,"qd_ave_thick",qd_ave_thick,...
        "qa_ave_thin",qa_ave_thin,"qi_ave_thin",qi_ave_thin,"qs_ave_thin",qs_ave_thin,"qc_ave_thin",qc_ave_thin,"qh_ave_thin",qh_ave_thin,...
        "qg_ave_thin",qg_ave_thin,"qr_ave_thin",qr_ave_thin,"qv_ave_thin",qv_ave_thin,"qd_ave_thin",qd_ave_thin,...
        "qa_ave_inter",qa_ave_inter,"qi_ave_inter",qi_ave_inter,"qs_ave_inter",qs_ave_inter,"qc_ave_inter",qc_ave_inter,"qh_ave_inter",qh_ave_inter,...
        "qg_ave_inter",qg_ave_inter,"qr_ave_inter",qr_ave_inter,"qv_ave_inter",qv_ave_inter,"qd_ave_inter",qd_ave_inter);
    save(name,"-fromstruct",s);

    % save(name,"qa_ave_thick","qi_ave_thick","qs_ave_thick","qc_ave_thick","qh_ave_thick","qg_ave_thick","qr_ave_thick","qv_ave_thick","qd_ave_thick",...
    %     "qa_ave_thin","qi_ave_thin","qs_ave_thin","qc_ave_thin","qh_ave_thin","qg_ave_thin","qr_ave_thin","qv_ave_thin","qd_ave_thin",...
    %     "qa_ave_inter","qi_ave_inter","qs_ave_inter","qc_ave_inter","qh_ave_inter","qg_ave_inter","qr_ave_inter","qv_ave_inter","qd_ave_inter",'-v7.3')

end

%% % radiation

savepath ='/tempest/jbukowski/MATLAB_TEST/AGG_Paper/Vertical_Profiles/anvil_only/';
sims = ["ARG1.1-AGG-LOW","AUS1.1-AGG-LOW","DRC1.1-AGG-LOW","PHI1.1-AGG-LOW","WPO1.1-AGG-LOW",...
        "ARG1.1-AGG-MID","AUS1.1-AGG-MID","DRC1.1-AGG-MID","PHI1.1-AGG-MID","WPO1.1-AGG-MID",...
        "ARG1.1-AGG-HIGH","AUS1.1-AGG-HIGH","DRC1.1-AGG-HIGH","PHI1.1-AGG-HIGH","WPO1.1-AGG-HIGH"];
dt_offset = (6*4)+1;
nz = 232;

for i = 1:15
    rshort_thick = NaN(nt,nx,ny);
    rlong_thick  = NaN(nt,nx,ny);
    albedo_thick = NaN(nt,nx,ny);
    olr_thick    = NaN(nt,nx,ny);
    rshort_thin  = NaN(nt,nx,ny);
    rlong_thin   = NaN(nt,nx,ny);
    albedo_thin  = NaN(nt,nx,ny);
    olr_thin     = NaN(nt,nx,ny);
    rshort_inter  = NaN(nt,nx,ny);
    rlong_inter   = NaN(nt,nx,ny);
    albedo_inter  = NaN(nt,nx,ny);
    olr_inter     = NaN(nt,nx,ny);

    simname = sims(i);
    simnameshort = split(simname,'-'); simnameshort = cell2mat(simnameshort(1));
    simnameagg   = split(simname,'-'); simnameagg   = cell2mat(simnameagg(3));
    tmod = get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
    RAMSPATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
    GEOIRPATH   = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simname + '/GEO_IR/';
    GEOIRFILES  = dir(fullfile(GEOIRPATH,'*.nc'));
    RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
    RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
    RAMSHEAD    = dir(fullfile(RAMSPATH,'a-L*.txt'));
    numfiles_geoir = [length(GEOIRFILES)];
    numfiles_model = [length(RAMSFILES_A)];
    nt = length(RAMSFILES_A)-dt_offset+1;
    ind = 1:3:length(GEOIRFILES);

    for k = dt_offset:length(RAMSFILES_A)
        trams = tmod(k);
        prog  = round(100*k/length(RAMSFILES_A));
        fprintf('2DRAD is %i percent complete.\n',prog);
        baseFileName = RAMSFILES_A(k).name;
        fullFileName = fullfile(RAMSPATH,baseFileName);
        kk = k-dt_offset+1;
        kkk = ind(kk);

        [BW_thick,BW_thin,BW_inter,perim_thick,perim_thin] = track_anvil(kkk,GEOIRFILES,GEOIRPATH,simnameshort);

        rshort = h5read(fullFileName,'/RSHORT'); % 2d surface shortwave downwelling
        rlong  = h5read(fullFileName,'/RLONG'); % 2d surface longwave downwelling
        albedo = h5read(fullFileName,'/ALBEDT'); % 2d surface albedo
        olr    = h5read(fullFileName,'/RLONTOP'); % 3d shortwave upwelling

        rshort_thick1 = rshort;
        rlong_thick1  = rlong;
        albedo_thick1 = albedo;
        olr_thick1    = olr;
        rshort_thin1  = rshort;
        rlong_thin1   = rlong;
        albedo_thin1  = albedo;
        olr_thin1     = olr;
        rshort_inter1 = rshort;
        rlong_inter1  = rlong;
        albedo_inter1 = albedo;
        olr_inter1    = olr;

        rshort_thick1(BW_thick==0) = NaN;
        rlong_thick1(BW_thick==0)  = NaN;
        albedo_thick1(BW_thick==0) = NaN;
        olr_thick1(BW_thick==0)    = NaN;
        rshort_thin1(BW_thin==0)   = NaN;
        rlong_thin1(BW_thin==0)    = NaN;
        albedo_thin1(BW_thin==0)   = NaN;
        olr_thin1(BW_thin==0)      = NaN;
        rshort_inter1(BW_inter==0) = NaN;
        rlong_inter1(BW_inter==0)  = NaN;
        albedo_inter1(BW_inter==0) = NaN;
        olr_inter1(BW_inter==0)    = NaN;

        rshort_thick(kk,:,:) = rshort_thick1;
        rlong_thick(kk,:,:)  = rlong_thick1;
        albedo_thick(kk,:,:) = albedo_thick1;
        olr_thick(kk,:,:)    = olr_thick1;
        rshort_thin(kk,:,:)  = rshort_thin1;
        rlong_thin(kk,:,:)   = rlong_thin1;
        albedo_thin(kk,:,:)  = albedo_thin1;
        olr_thin(kk,:,:)     = olr_thin1;
        rshort_inter(kk,:,:) = rshort_inter1;
        rlong_inter(kk,:,:)  = rlong_inter1;
        albedo_inter(kk,:,:) = albedo_inter1;
        olr_inter(kk,:,:)    = olr_inter1;
    end

    name=savepath+"RAD_2D_ANVIL_"+ simnameshort + '_' + simnameagg + '.mat';
    save(name,"rshort_thick","rlong_thick","albedo_thick","olr_thick","rshort_thin","rlong_thin","albedo_thin","olr_thin",...
        "rshort_inter","rlong_inter","albedo_inter","olr_inter",'-v7.3')
    clear rshort rlong albedo olr rshort_thick rlong_thick albedo_thick olr_thick rshort_thin rlong_thin albedo_thin olr_thin rshort_inter rlong_inter albedo_inter olr_inter

end

%%
savepath ='/tempest/jbukowski/MATLAB_TEST/AGG_Paper/Vertical_Profiles/anvil_only/';
sims = ["ARG1.1-AGG-LOW","AUS1.1-AGG-LOW","DRC1.1-AGG-LOW","PHI1.1-AGG-LOW","WPO1.1-AGG-LOW",...
        "ARG1.1-AGG-MID","AUS1.1-AGG-MID","DRC1.1-AGG-MID","PHI1.1-AGG-MID","WPO1.1-AGG-MID",...
        "ARG1.1-AGG-HIGH","AUS1.1-AGG-HIGH","DRC1.1-AGG-HIGH","PHI1.1-AGG-HIGH","WPO1.1-AGG-HIGH"];
dt_offset = (6*4)+1;
nz = 232;

for i = 1:15
    lwdn_ave_thick = NaN(nt,nz);
    lwup_ave_thick = NaN(nt,nz);
    swdn_ave_thick = NaN(nt,nz);
    swup_ave_thick = NaN(nt,nz);
    radheat_ave_thick = NaN(nt,nz);
    lwdn_ave_thin  = NaN(nt,nz);
    lwup_ave_thin  = NaN(nt,nz);
    swdn_ave_thin  = NaN(nt,nz);
    swup_ave_thin  = NaN(nt,nz);
    radheat_ave_thin = NaN(nt,nz);
    lwdn_ave_inter = NaN(nt,nz);
    lwup_ave_inter = NaN(nt,nz);
    swdn_ave_inter = NaN(nt,nz);
    swup_ave_inter = NaN(nt,nz);
    radheat_ave_inter = NaN(nt,nz);

    simname = sims(i);
    simnameshort = split(simname,'-'); simnameshort = cell2mat(simnameshort(1));
    simnameagg   = split(simname,'-'); simnameagg   = cell2mat(simnameagg(3));
    tmod = get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
    RAMSPATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
    GEOIRPATH   = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simname + '/GEO_IR/';
    GEOIRFILES  = dir(fullfile(GEOIRPATH,'*.nc'));
    RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
    RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
    RAMSHEAD    = dir(fullfile(RAMSPATH,'a-L*.txt'));
    numfiles_geoir = [length(GEOIRFILES)];
    numfiles_model = [length(RAMSFILES_A)];
    nt = length(RAMSFILES_A)-dt_offset+1;
    ind = 1:3:length(GEOIRFILES);

    for k = dt_offset:length(RAMSFILES_A)
        trams=tmod(k);
        baseFileName = RAMSFILES_A(k).name;
        fullFileName = fullfile(RAMSPATH,baseFileName);
        prog = round(100*k/length(RAMSFILES_A));
        fprintf('3DRAD is %i percent complete.\n',prog);
        kk = k-dt_offset+1;
        kkk = ind(kk);

        [BW_thick,BW_thin,BW_inter,perim_thick,perim_thin] = track_anvil(kkk,GEOIRFILES,GEOIRPATH,simnameshort);
        BW_thick = repmat(BW_thick,1,1,nz);
        BW_thin  = repmat(BW_thin,1,1,nz);
        BW_inter = repmat(BW_inter,1,1,nz);

        lwdn = h5read(fullFileName,'/LWDN'); % 3d longwave downwelling
        lwup = h5read(fullFileName,'/LWUP');  % 3d longwave upwelling
        swdn = h5read(fullFileName,'/SWDN'); % 3d shortwave downwelling
        swup = h5read(fullFileName,'/SWUP'); % 3d shortwave upwelling
        radheat = h5read(fullFileName,'/FTHRD'); % 3d radiative heating rate

        lwdn_thick = lwdn; lwup_thick = lwup;
        swdn_thick = swdn; swup_thick = swup;
        radheat_thick = radheat;
        lwdn_thin = lwdn; lwup_thin = lwup;
        swdn_thin = swdn; swup_thin = swup;
        radheat_thin = radheat;
        lwdn_inter = lwdn; lwup_inter = lwup;
        swdn_inter = swdn; swup_inter = swup;
        radheat_inter = radheat;

        lwdn_thick(BW_thick==0) = NaN;
        lwup_thick(BW_thick==0) = NaN;
        swdn_thick(BW_thick==0) = NaN;
        swup_thick(BW_thick==0) = NaN;
        radheat_thick(BW_thick==0) = NaN;
        lwdn_thin(BW_thin==0) = NaN;
        lwup_thin(BW_thin==0) = NaN;
        swdn_thin(BW_thin==0) = NaN;
        swup_thin(BW_thin==0) = NaN;
        radheat_thin(BW_thin==0) = NaN;
        lwdn_inter(BW_inter==0) = NaN;
        lwup_inter(BW_inter==0) = NaN;
        swdn_inter(BW_inter==0) = NaN;
        swup_inter(BW_inter==0) = NaN;
        radheat_inter(BW_inter==0) = NaN;

        lwdn_ave_thick(kk,:) = squeeze(nanmean(lwdn_thick,[1,2]));
        lwup_ave_thick(kk,:) = squeeze(nanmean(lwup_thick,[1,2]));
        swdn_ave_thick(kk,:) = squeeze(nanmean(swdn_thick,[1,2]));
        swup_ave_thick(kk,:) = squeeze(nanmean(swup_thick,[1,2]));
        radheat_ave_thick(kk,:) = squeeze(nanmean(radheat_thick,[1,2]));
        lwdn_ave_thin(kk,:) = squeeze(nanmean(lwdn_thin,[1,2]));
        lwup_ave_thin(kk,:) = squeeze(nanmean(lwup_thin,[1,2]));
        swdn_ave_thin(kk,:) = squeeze(nanmean(swdn_thin,[1,2]));
        swup_ave_thin(kk,:) = squeeze(nanmean(swup_thin,[1,2]));
        radheat_ave_thin(kk,:) = squeeze(nanmean(radheat_thin,[1,2]));
        lwdn_ave_inter(kk,:) = squeeze(nanmean(lwdn_inter,[1,2]));
        lwup_ave_inter(kk,:) = squeeze(nanmean(lwup_inter,[1,2]));
        swdn_ave_inter(kk,:) = squeeze(nanmean(swdn_inter,[1,2]));
        swup_ave_inter(kk,:) = squeeze(nanmean(swup_inter,[1,2]));
        radheat_ave_inter(kk,:) = squeeze(nanmean(radheat_inter,[1,2]));

    end

    name=savepath+"RAD_3D_ANVIL_"+ simnameshort + '_' + simnameagg + '.mat';
    s = struct("lwdn_ave_thick",lwdn_ave_thick,"lwup_ave_thick",lwup_ave_thick,"swdn_ave_thick",swdn_ave_thick,"swup_ave_thick",swup_ave_thick,"radheat_ave_thick",radheat_ave_thick,...
               "lwdn_ave_thin",lwdn_ave_thin,"lwup_ave_thin",lwup_ave_thin,"swdn_ave_thin",swdn_ave_thin,"swup_ave_thin",swup_ave_thin,"radheat_ave_thin",radheat_ave_thin,...
               "lwdn_ave_inter",lwdn_ave_inter,"lwup_ave_inter",lwup_ave_inter,"swdn_ave_inter",swdn_ave_inter,"swup_ave_inter",swup_ave_inter,"radheat_ave_inter",radheat_ave_inter);
    save(name,"-fromstruct",s);
end 

%% integrated condensate 

savepath ='/tempest/jbukowski/MATLAB_TEST/AGG_Paper/Vertical_Profiles/anvil_only/';
sims = ["ARG1.1-AGG-LOW","AUS1.1-AGG-LOW","DRC1.1-AGG-LOW","PHI1.1-AGG-LOW","WPO1.1-AGG-LOW",...
        "ARG1.1-AGG-MID","AUS1.1-AGG-MID","DRC1.1-AGG-MID","PHI1.1-AGG-MID","WPO1.1-AGG-MID",...
        "ARG1.1-AGG-HIGH","AUS1.1-AGG-HIGH","DRC1.1-AGG-HIGH","PHI1.1-AGG-HIGH","WPO1.1-AGG-HIGH"];
dt_offset = (6*4)+1;
nz = 232;

for i = 1:15
    INTCOND_ave_thick  = NaN(nt); % vapor diffusion / evaporation on pristine ice
    INTCOND_ave_thin   = NaN(nt);
    INTCOND_ave_inter  = NaN(nt);

    simname = sims(i);
    simnameshort = split(simname,'-'); simnameshort = cell2mat(simnameshort(1));
    simnameagg   = split(simname,'-'); simnameagg   = cell2mat(simnameagg(3));
    tmod = get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
    RAMSPATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
    GEOIRPATH   = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simname + '/GEO_IR/';
    GEOIRFILES  = dir(fullfile(GEOIRPATH,'*.nc'));
    RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
    RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
    RAMSHEAD    = dir(fullfile(RAMSPATH,'a-A*.txt'));
    numfiles_geoir = [length(GEOIRFILES)];
    numfiles_model = [length(RAMSFILES_A)];
    nt = length(RAMSFILES_A)-dt_offset+1;
    ind = 1:3:length(GEOIRFILES);

    for k = dt_offset:length(RAMSFILES_A)
        prog = round(100*k/length(RAMSFILES_A));
        fprintf('MP_RATES1 is %i percent complete.\n',prog);
        trams=tmod(k);
        baseFileName = RAMSFILES_A(k).name;
        fullFileName = fullfile(RAMSPATH,baseFileName);
        headFileName = RAMSHEAD(k).name;
        fullHeadFileName = fullfile(RAMSPATH,headFileName);
        kk = k-dt_offset+1;
        kkk = ind(kk);
       
        [BW_thick,BW_thin,BW_inter,perim_thick,perim_thin] = track_anvil(kkk,GEOIRFILES,GEOIRPATH,simnameshort);
        BW_thick = repmat(BW_thick,1,1,nz);
        BW_thin  = repmat(BW_thin,1,1,nz);
        BW_inter = repmat(BW_inter,1,1,nz);

        INTCOND = calc_itc(fullFileName,fullhHeadFileName);

        INTCOND_thick  = INTCOND; % vapor diffusion / evaporation on pristine ice
        INTCOND_thin   = INTCOND;
        INTCOND_inter  = INTCOND;
        INTCOND_thick(BW_thick==0) = NaN; % vapor diffusion / evaporation on pristine ice
        INTCOND_thin(BW_thin==0)   = NaN;
        INTCOND_inter(BW_inter==0) = NaN;
        INTCOND_ave_thick(kk,:) = squeeze(nanmean(INTCOND_thick,[1,2]));
        INTCOND_ave_thick(kk,:) = squeeze(nanmean(INTCOND_thick,[1,2]));
        INTCOND_ave_thick(kk,:) = squeeze(nanmean(INTCOND_thick,[1,2]));

        name=savepath+"INTCOND_ANVIL_"+ simnameshort + '_' + simnameagg + '.mat';
        s = struct("INTCOND_ave_thick",INTCOND_ave_thick,"INTCOND_ave_thin",INTCOND_ave_thin,"INTCOND_ave_inter",INTCOND_ave_inter);
        save(name,"-fromstruct",s); 
    end
end

%%