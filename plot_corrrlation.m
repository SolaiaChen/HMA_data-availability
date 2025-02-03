clc;clear;
addpath('/work/bg1244/g260203/Matlab/m_map');
addpath('/work/bg1244/g260203/NorthSea/0Matlab/slanCM')
load('HMA_outline_Hebbeln.mat');
load('grid')
load correlation_shear_data_2013summer.mat

%% interpolate to regular grid
close all
germanbight=1;
lonlim=[7.5 8.8];
latlim=[53.85 54.4];
dxy=0.01;%for interpolation of saclar fields/color plotting
lonvec=lonlim(1):dxy:lonlim(2);
latvec=latlim(1):dxy:latlim(2);
[xmesh,ymesh]=meshgrid(lonvec,latvec);
% interpolate each data
pea_mesh=griddata(vert(:,1),vert(:,2),double(correlations_nshear_npea_plt),xmesh,ymesh);
wind_NS_mesh=griddata(vert(:,1),vert(:,2),double(correlations_nshear_wind_NS_plt),xmesh,ymesh);
wind_EW_mesh=griddata(vert(:,1),vert(:,2),double(correlations_nshear_wind_EW_plt),xmesh,ymesh);
wind_Mag_mesh=griddata(vert(:,1),vert(:,2),double(correlations_nshear_wind_Mag_plt),xmesh,ymesh);
elev_mesh=griddata(vert(:,1),vert(:,2),double(correlations_nshear_elev_plt),xmesh,ymesh);
flux_mesh=griddata(vert(:,1),vert(:,2),double(correlations_nshear_Elbefl_plt),xmesh,ymesh);

%% Figure
%plot:
m_proj('mercator','long',double(lonlim),'lat',double(latlim));
m_gshhs_h('save','gumby');
load gumby
h=figure('units','pixels', 'Position', [200, 200, 600, 350],'Visible', 'on');%,'renderer','painters');
hold on
set(gca,'color',[.8 .8 .8])
hold on
h=m_image(lonvec,latvec,pea_mesh);%
m_grid('fontsize',20,'linewidth',2,'gridcolor','none');
c = colorbar('fontsize',18);
colormap(slanCM('pride'))
% c.Label.String = 'Net sediment flux [mg/m^2/s]';
caxis([-0.8 0.8])
m_usercoast('gumby','patch',[.8 .8 .8]);
for ii=1:numel(cursor_info)
hma_lon(ii)=cursor_info(ii).Position(1);
hma_lat(ii)=cursor_info(ii).Position(2);
end
hma_lon(end+1)=hma_lon(1);
hma_lat(end+1)=hma_lat(1);
p = m_line(hma_lon,hma_lat);
p.LineStyle = "-";
p.Color = 'k';%[0.9290 0.6940 0.1250]
p.LineWidth= 1;
hold off
