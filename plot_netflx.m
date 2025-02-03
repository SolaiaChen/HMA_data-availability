clc;clear;
addpath('/work/bg1244/g260203/Matlab/m_map');
load('HMA_outline_Hebbeln.mat');
load('grid');
load('Net_vertical_flux');%%

%% plot as log
%plot:
load gumbyGB
h=figure('units','pixels', 'Position', [200, 200, 650, 650],'Visible', 'on');%,'renderer','painters');
hold on
set(gca,'color',[.8 .8 .8])
hold on
h=m_image(lonvec,latvec,netflx_2013winter);%
m_grid('fontsize',20,'linewidth',2,'gridcolor','none');
colormap(cmap)
c = colorbar('fontsize',18);
c.Label.String = 'Net sediment flux [g/m^2/s]';
caxis([-0.08 0.08])
m_usercoast('gumbyGB','patch',[.8 .8 .8]);
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

