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
savepath ='/tempest/jbukowski/MATLAB/AGG_Paper/Vertical_Profiles/anvil_only/';
sims = ["ARG1.1-AGG-LOW","AUS1.1-AGG-LOW","DRC1.1-AGG-LOW","PHI1.1-AGG-LOW","WPO1.1-AGG-LOW",...
        "ARG1.1-AGG-MID","AUS1.1-AGG-MID","DRC1.1-AGG-MID","PHI1.1-AGG-MID","WPO1.1-AGG-MID",...
        "ARG1.1-AGG-HIGH","AUS1.1-AGG-HIGH","DRC1.1-AGG-HIGH","PHI1.1-AGG-HIGH","WPO1.1-AGG-HIGH"];

dt_offset = (6*4)+1;
nz = 232;

parfor i = 1:15
    simname = sims(i);
    simnameshort = split(simname,'-'); simnameshort = cell2mat(simnameshort(1));
    simnameagg   = split(simname,'-'); simnameagg   = cell2mat(simnameagg(3));
    tmod = get_sim_time(simnameshort); % there is no time info in the GEO_IR model output - manually set relative to RAMS
    RAMSPATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simname + '/G1/out/';
    GEOIRPATH   = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simname + '/GEO_IR/';
    % RAMSPATH    = "/monsoon/MODEL/LES_MODEL_DATA/V1/" + simname + '/G1/out/';
    % GEOIRPATH   = "/tempest/jbukowski/GEO_IR/FORWARD_MODEL_DATA/" + simname ;
    GEOIRFILES  = dir(fullfile(GEOIRPATH,'*.nc'));
    RAMSFILES   = dir(fullfile(RAMSPATH,'a-L*.h5'));
    RAMSFILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));
    RAMSHEAD    = dir(fullfile(RAMSPATH,'a-L*.txt'));
    numfiles_geoir = [length(GEOIRFILES)];
    numfiles_model = [length(RAMSFILES_A)];
    GEOIRPATH_AGGHIGH = "/monsoon/MODEL/FORWARD_MODEL_DATA/V1/RAMS_AGG_TESTS/" + simnameshort + '-AGG-HIGH/GEO_IR/';
    GEOIRFILES_AGGHIGH  = dir(fullfile(GEOIRPATH_AGGHIGH,'*.nc'));
    nt  = length(RAMSFILES_A)-dt_offset+1; 
    ind = 1:3:length(GEOIRFILES);
    AGGHIGH_PATH    = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simnameshort + '-AGG-HIGH/G1/out/';
    AGGHIGH_FILES_A = dir(fullfile(RAMSPATH,'a-A*.h5'));

    CLEARSKY_PATH  = "/tempest2/MODEL/LES_MODEL_DATA/ICE_AGG_V1/" + simnameshort + '-AGG-CLEARSKY/G1/out/';
    CLEARFILES_A = dir(fullfile(CLEARSKY_PATH,'a-A*.h5'));

    CRE_LW_mean_thick   = NaN(nt,nz);
    CRE_LW_mean_thin    = NaN(nt,nz);
    CRE_LW_mean_anvil   = NaN(nt,nz);
    CRE_LW_mean_domain  = NaN(nt,nz);
    CRE_SW_mean_thick   = NaN(nt,nz);
    CRE_SW_mean_thin    = NaN(nt,nz);
    CRE_SW_mean_anvil   = NaN(nt,nz);
    CRE_SW_mean_domain  = NaN(nt,nz);
    CRE_NET_mean_thick  = NaN(nt,nz);
    CRE_NET_mean_thin   = NaN(nt,nz);
    CRE_NET_mean_anvil  = NaN(nt,nz);
    CRE_NET_mean_domain = NaN(nt,nz);
    ncloud_thick = NaN(nt,1);
    ncloud_thin  = NaN(nt,1);
    ncloud_anvil = NaN(nt,1);
    nclear = NaN(nt,1);
    nall   = NaN(nt,1);
    cloud_frac_thick = NaN(nt,1);
    cloud_frac_thin  = NaN(nt,1);
    cloud_frac_anvil = NaN(nt,1);
    clear_frac = NaN(nt,1);
    CRE_LW_mean_frac_thick  = NaN(nt,nz);
    CRE_LW_mean_frac_thin   = NaN(nt,nz);
    CRE_LW_mean_frac_anvil  = NaN(nt,nz);
    CRE_SW_mean_frac_thick  = NaN(nt,nz);
    CRE_SW_mean_frac_thin   = NaN(nt,nz);
    CRE_SW_mean_frac_anvil  = NaN(nt,nz);
    CRE_NET_mean_frac_thick = NaN(nt,nz);
    CRE_NET_mean_frac_thin  = NaN(nt,nz);
    CRE_NET_mean_frac_anvil = NaN(nt,nz);

   for k = dt_offset:length(RAMSFILES_A)
        trams=tmod(k);
        baseFileName = RAMSFILES_A(k).name;
        fullFileName = fullfile(RAMSPATH,baseFileName)
        baseFileNameClear = CLEARFILES_A(k).name;
        fullFileNameClear = fullfile(CLEARSKY_PATH,baseFileNameClear);
        baseFileNameHigh = AGGHIGH_FILES_A(k).name;
        fullFileNameHigh = fullfile(AGGHIGH_PATH,baseFileNameHigh);
        prog = round(100*k/length(RAMSFILES_A));
        fprintf('CRE is %i percent complete.\n',prog);
        kk = k-dt_offset+1;
        kkk = ind(kk);

       [BW_thick,BW_anvil,BW_thin,BW_clear]  = track_anvil_cre(kkk,GEOIRFILES_AGGHIGH,GEOIRPATH_AGGHIGH,simnameshort);
       [BW_thick,BW_anvil,BW_thin,BW_clear2] = track_anvil_cre(kkk,GEOIRFILES,GEOIRPATH,simnameshort);
        BW_thick = repmat(BW_thick,1,1,nz);
        BW_thin  = repmat(BW_thin,1,1,nz);
        BW_anvil = repmat(BW_anvil,1,1,nz);
        BW_clear = repmat(BW_clear,1,1,nz);

        lwdn = h5read(fullFileName,'/LWDN'); % 3d longwave downwelling
        lwup = h5read(fullFileName,'/LWUP');  % 3d longwave upwelling
        swdn = h5read(fullFileName,'/SWDN'); % 3d shortwave downwelling
        swup = h5read(fullFileName,'/SWUP'); % 3d shortwave upwelling
        lwdn_clear = h5read(fullFileNameClear,'/LWDN'); % 3d longwave downwelling
        lwup_clear = h5read(fullFileNameClear,'/LWUP'); % 3d longwave upwelling
        swdn_clear = h5read(fullFileNameClear,'/SWDN'); % 3d shortwave downwelling
        swup_clear = h5read(fullFileNameClear,'/SWUP'); % 3d shortwave upwelling
        % lwdn_clear = h5read(fullFileNameHigh,'/LWDN'); % 3d longwave downwelling
        % lwup_clear = h5read(fullFileNameHigh,'/LWUP'); % 3d longwave upwelling
        % swdn_clear = h5read(fullFileNameHigh,'/SWDN'); % 3d shortwave downwelling
        % swup_clear = h5read(fullFileNameHigh,'/SWUP'); % 3d shortwave upwelling

        nx = size(lwdn,1);
        ny = size(lwdn,2);

        lwdn_cloudy_thick = lwdn; lwdn_cloudy_thick(BW_thick==0) = NaN;
        lwdn_cloudy_thin  = lwdn; lwdn_cloudy_thin(BW_thin==0)   = NaN;
        lwdn_cloudy_anvil = lwdn; lwdn_cloudy_anvil(BW_anvil==0) = NaN;
        %lwdn_clear = lwdn; 
        %lwdn_clear(BW_clear==0) = NaN;
        lwup_cloudy_thick = lwup; lwup_cloudy_thick(BW_thick==0) = NaN;
        lwup_cloudy_thin  = lwup; lwup_cloudy_thin(BW_thin==0)   = NaN;
        lwup_cloudy_anvil = lwup; lwup_cloudy_anvil(BW_anvil==0) = NaN;
        %lwup_clear = lwup; 
        %lwup_clear(BW_clear==0) = NaN; 
        swdn_cloudy_thick = swdn; swdn_cloudy_thick(BW_thick==0) = NaN;
        swdn_cloudy_thin  = swdn; swdn_cloudy_thin(BW_thin==0)   = NaN;
        swdn_cloudy_anvil = swdn; swdn_cloudy_anvil(BW_anvil==0) = NaN;
        %swdn_clear = swdn; 
        %swdn_clear(BW_clear==0) = NaN;
        swup_cloudy_thick = swup; swup_cloudy_thick(BW_thick==0) = NaN;
        swup_cloudy_thin  = swup; swup_cloudy_thin(BW_thin==0)   = NaN;
        swup_cloudy_anvil = swup; swup_cloudy_anvil(BW_anvil==0) = NaN;        
        %swup_clear = swup; 
        %swup_clear(BW_clear==0) = NaN; 

        lwnet_cloudy_thick = lwdn_cloudy_thick - lwup_cloudy_thick;
        lwnet_cloudy_thin  = lwdn_cloudy_thin  - lwup_cloudy_thin;
        lwnet_cloudy_anvil = lwdn_cloudy_anvil - lwup_cloudy_anvil;
        lwnet_cloudy_domain = lwdn - lwup;
        lwnet_clear = lwdn_clear  - lwup_clear;
        swnet_cloudy_thick = swdn_cloudy_thick - swup_cloudy_thick;
        swnet_cloudy_thin  = swdn_cloudy_thin  - swup_cloudy_thin;
        swnet_cloudy_anvil = swdn_cloudy_anvil - swup_cloudy_anvil;
        swnet_cloudy_domain = swdn - swup;
        swnet_clear = swdn_clear  - swup_clear;

        CRE_LW_thick  = lwnet_cloudy_thick - lwnet_clear;
        CRE_LW_thin   = lwnet_cloudy_thin  - lwnet_clear;  
        CRE_LW_anvil  = lwnet_cloudy_anvil - lwnet_clear;
        CRE_LW_domain = lwnet_cloudy_domain - lwnet_clear;
        CRE_SW_thick  = swnet_cloudy_thick - swnet_clear;
        CRE_SW_thin   = swnet_cloudy_thin  - swnet_clear;
        CRE_SW_anvil  = swnet_cloudy_anvil - swnet_clear;
        CRE_SW_domain = swnet_cloudy_domain - swnet_clear;       
        % CRE_LW_thick  = lwnet_cloudy_thick - nanmean(lwnet_clear,[1,2]);
        % CRE_LW_thin   = lwnet_cloudy_thin  - nanmean(lwnet_clear,[1,2]); 
        % CRE_LW_anvil  = lwnet_cloudy_anvil - nanmean(lwnet_clear,[1,2]);
        % CRE_SW_thick  = swnet_cloudy_thick - nanmean(swnet_clear,[1,2]);
        % CRE_SW_thin   = swnet_cloudy_thin  - nanmean(swnet_clear,[1,2]);
        % CRE_SW_anvil  = swnet_cloudy_anvil - nanmean(swnet_clear,[1,2]);
        CRE_NET_thick = CRE_LW_thick + CRE_SW_thick;
        CRE_NET_thin  = CRE_LW_thin  + CRE_SW_thin;
        CRE_NET_anvil = CRE_LW_anvil + CRE_SW_anvil;
        CRE_NET_domain = CRE_LW_domain + CRE_SW_domain;

        CRE_LW_mean_thick(kk,:)  = squeeze(nanmean(CRE_LW_thick,[1,2]));
        CRE_LW_mean_thin(kk,:)   = squeeze(nanmean(CRE_LW_thin,[1,2]));
        CRE_LW_mean_anvil(kk,:)  = squeeze(nanmean(CRE_LW_anvil,[1,2]));
        CRE_LW_mean_domain(kk,:) = squeeze(nanmean(CRE_LW_domain,[1,2]));
        CRE_SW_mean_thick(kk,:)  = squeeze(nanmean(CRE_SW_thick,[1,2]));
        CRE_SW_mean_thin(kk,:)   = squeeze(nanmean(CRE_SW_thin,[1,2]));
        CRE_SW_mean_anvil(kk,:)  = squeeze(nanmean(CRE_SW_anvil,[1,2]));
        CRE_SW_mean_domain(kk,:) = squeeze(nanmean(CRE_SW_domain,[1,2]));
        CRE_NET_mean_thick(kk,:) = squeeze(nanmean(CRE_NET_thick,[1,2]));
        CRE_NET_mean_thin(kk,:)  = squeeze(nanmean(CRE_NET_thin,[1,2]));
        CRE_NET_mean_anvil(kk,:) = squeeze(nanmean(CRE_NET_anvil,[1,2]));   
        CRE_NET_mean_domain(kk,:) = squeeze(nanmean(CRE_NET_domain,[1,2]));       
        ncloud_thick(kk) = nansum(BW_thick(:,:,1),'all');
        ncloud_thin(kk)  = nansum(BW_thin(:,:,1),'all');
        ncloud_anvil(kk) = nansum(BW_anvil(:,:,1),'all');
        nclear(kk) = nansum(BW_clear2(:,:,1),'all');
        nall(kk)   = nx*ny;
        cloud_frac_thick(kk) = ncloud_thick(kk)./nall(kk);
        cloud_frac_thin(kk)  = ncloud_thin(kk)./nall(kk);
        cloud_frac_anvil(kk) = ncloud_anvil(kk)./nall(kk);
        clear_frac(kk) = nclear(kk)/nall(kk);
        CRE_LW_mean_frac_thick(kk,:)  = CRE_LW_mean_thick(kk,:).*cloud_frac_thick(kk);
        CRE_LW_mean_frac_thin(kk,:)   = CRE_LW_mean_thin(kk,:).*cloud_frac_thin(kk);
        CRE_LW_mean_frac_anvil(kk,:)  = CRE_LW_mean_anvil(kk,:).*cloud_frac_anvil(kk);
        CRE_SW_mean_frac_thick(kk,:)  = CRE_SW_mean_thick(kk,:).*cloud_frac_thick(kk);
        CRE_SW_mean_frac_thin(kk,:)   = CRE_SW_mean_thin(kk,:).*cloud_frac_thin(kk);
        CRE_SW_mean_frac_anvil(kk,:)  = CRE_SW_mean_anvil(kk,:).*cloud_frac_anvil(kk);
        CRE_NET_mean_frac_thick(kk,:) = CRE_NET_mean_thick(kk,:).*cloud_frac_thick(kk);
        CRE_NET_mean_frac_thin(kk,:)  = CRE_NET_mean_thin(kk,:).*cloud_frac_thin(kk);
        CRE_NET_mean_frac_anvil(kk,:) = CRE_NET_mean_anvil(kk,:).*cloud_frac_anvil(kk);

    end

    name=savepath+"CRE_ANVIL_"+ simnameshort + '_' + simnameagg + '.mat';
    s = struct("CRE_LW_mean_thick",CRE_LW_mean_thick,"CRE_LW_mean_thin",CRE_LW_mean_thin,"CRE_LW_mean_anvil",CRE_LW_mean_anvil,...
        "CRE_SW_mean_thick",CRE_SW_mean_thick,"CRE_SW_mean_thin",CRE_SW_mean_thin,"CRE_SW_mean_anvil",CRE_SW_mean_anvil,...
        "CRE_LW_mean_domain",CRE_LW_mean_domain,"CRE_SW_mean_domain",CRE_SW_mean_domain,"CRE_NET_mean_domain",CRE_NET_mean_domain,...
        "ncloud_thick",ncloud_thick,"ncloud_thin",ncloud_thin,"nclear",nclear,"nall",nall,"ncloud_anvil",ncloud_anvil,...
        "cloud_frac_thick",cloud_frac_thick,"cloud_frac_thin",cloud_frac_thin,"clear_frac",clear_frac,"cloud_frac_anvil",cloud_frac_anvil,...
        "CRE_LW_mean_frac_thick",CRE_LW_mean_frac_thick,"CRE_LW_mean_frac_thin",CRE_LW_mean_frac_thin, "CRE_LW_mean_frac_anvil",CRE_LW_mean_frac_anvil,...
        "CRE_SW_mean_frac_thick",CRE_SW_mean_frac_thick,"CRE_SW_mean_frac_thin",CRE_SW_mean_frac_thin, "CRE_SW_mean_frac_anvil",CRE_SW_mean_frac_anvil,...
        "CRE_NET_mean_thick",CRE_NET_mean_thick,"CRE_NET_mean_thin",CRE_NET_mean_thin,"CRE_NET_mean_anvil",CRE_NET_mean_anvil,...
        "CRE_NET_mean_frac_thick",CRE_NET_mean_frac_thick,"CRE_NET_mean_frac_thin",CRE_NET_mean_frac_thin,"CRE_NET_mean_frac_anvil",CRE_NET_mean_frac_anvil);
    save(name,"-fromstruct",s);

end 
