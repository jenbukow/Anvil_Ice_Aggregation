function [BW_thick_buffer,BW_anvil_buffer,BW_thin,BW_clear] = track_anvil(k,GEOIRFILE,GEOIRPATH,simnameshort)
    
    start=[1 1 6]; stop=[Inf Inf 1];

    switch simnameshort
        case 'DRC1.1'
            lambda6  = 1; lambda7  = 2; % 6.2 / 7.3 um
            lambda8  = 3; % 7.3 um
            lambda11 = 5; lambda12 = 6; % 10.8 / 12.0 um
        otherwise
            %lambda11 could be 6 or 7
            lambda6  = 1; lambda7  = 3; % 6.2 / 7.3 um
            lambda11 = 7; lambda12 = 8; % 11.2 / 12.3 um
            lambda8  = 4;
    end

    baseFileName = GEOIRFILE(k).name;
    fullFileName = fullfile(GEOIRPATH, baseFileName);

    Tb_6  = (ncread(fullFileName,'Tb',[1 1 lambda6],stop));
    Tb_7  = (ncread(fullFileName,'Tb',[1 1 lambda7],stop));
    Tb_11 = (ncread(fullFileName,'Tb',[1 1 lambda11],stop));
    Tb_12 = (ncread(fullFileName,'Tb',[1 1 lambda12],stop));
    Tb_8  = (ncread(fullFileName,'Tb',[1 1 lambda8],stop));
    
    WVD = Tb_6 - Tb_7;
    %SWD = Tb_11 - Tb_12;
    SWD = Tb_8 - Tb_11;

    I  = WVD - SWD;
    %BW_thick = I > -6;
    BW_thick = I > -7;
    G = bwdist(BW_thick);
    BW_thick_buffer = (G >= 1);
    BW_thick_buffer = imcomplement(BW_thick_buffer);
   % BW2 = bwperim(BW,8);
    BWedge = edge(BW_thick_buffer,'sobel');
    %BW_filled = imfill(BW,4,"holes");
    BW_filled = BW_thick_buffer;
    perim_thick = bwperim(BW_filled,8);
    %bwarea(BW_filled);
    %TB_thick=Tb_11;
    %TB_thick(BW_filled==0)=NaN;

    H  = WVD + SWD;
    %BW_thin = H > -12;
    BW_anvil = H > -18;
    G = bwdist(BW_anvil);
    BW_anvil_buffer = (G >= 1);
    BW_anvil_buffer = imcomplement(BW_anvil_buffer);
    %BW_filled = imfill(BW,"holes");
    BW_filled = BW_anvil_buffer;
    perim_anvil = bwperim(BW_filled,8);
    %TB_thin=Tb_11;
    %TB_thin(BW_filled==0)=NaN;

    BW_thin = BW_anvil_buffer;
    BW_thin(BW_thick==1)=0;

    BW_clear = imcomplement(BW_anvil);

end