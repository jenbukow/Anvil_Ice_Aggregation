function [IWP] = calc_iwp(ramsfile,headfile)

Cp=1004;
Rd=287.0;
p00 = 100000.0;
nz = 232;

RPP = h5read(ramsfile,'/RPP');
RSP = h5read(ramsfile,'/RSP');
RAP = h5read(ramsfile,'/RAP');
RGP = h5read(ramsfile,'/RGP');
RHP = h5read(ramsfile,'/RHP');
RV  = h5read(ramsfile,'/RV');
TFC = RPP + RSP + RAP + RGP + RHP;

terr = h5read(ramsfile,'/TOPT');
PI = h5read(ramsfile,'/PI');
TH = h5read(ramsfile,'/THETA');

contents = readlines(headfile);
idx = find(strcmp(contents ,'__ztn01'));
z_rams = contents((idx+2):(idx+nz+1));
z_rams = str2double(z_rams);
z_rams = [z_rams;z_rams(end)];

%Code to calculate RAMS heights above Mean Sea Level # Create topography adjusted heights
Zmids = repmat(z_rams,1,size(terr,1),size(terr,2));
ztop  = max(Zmids,[],"all");
z_rams_agl = zeros(size(Zmids));
for i =1:size(terr,1)
    for j =1:size(terr,2)
        rtgt = 1. - (terr(i,j)./ztop); % terrain following coordinate adjustment and flat model top
        z_rams_agl(:,i,j) = Zmids(:,i,j).*rtgt;
    end
end

P = ((PI./Cp).^(Cp./Rd)).*p00;
T = TH.*(PI./Cp);
clear TH PI
RHO = P./(Rd.*T.*(1+0.61.*RV));
clear P T RV
diff_zt_3D = diff(z_rams_agl,1);
diff_zt_3D = permute(diff_zt_3D,[2,3,1]);

IWP = sum(TFC.*RHO.*diff_zt_3D,3); % integrated total condensate in kg
IWP = IWP./997.0*1000.0 ;% integrated total condensate in mm
IWP(IWP<=0) = 0;

end