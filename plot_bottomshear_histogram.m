clc;clear;
addpath('/work/bg1244/g260203/Matlab/m_map');
load('grid.mat');
load('HMA_outline_Hebbeln.mat');
%% Time series of bottom shear stress in 2013
load('bottom_shear_stress_2013.mat');


%% Find nearest point
riverel1=[8.2 54.03];        %Elbe valley
[mindist1,indmin1]=min(sqrt((vert(:,1)-riverel1(1)).^2+(vert(:,2)-riverel1(2)).^2),[],1,'omitnan');
riverel2=[8.26 54.15];       %Northern part of HMA
[mindist2,indmin2]=min(sqrt((vert(:,1)-riverel2(1)).^2+(vert(:,2)-riverel2(2)).^2),[],1,'omitnan');
riverel3=[7.9 54.1];         %Helgoland Deep
[mindist3,indmin3]=min(sqrt((vert(:,1)-riverel3(1)).^2+(vert(:,2)-riverel3(2)).^2),[],1,'omitnan');
riverel4=[8.4 54.07];        %East of HMA
[mindist4,indmin4]=min(sqrt((vert(:,1)-riverel4(1)).^2+(vert(:,2)-riverel4(2)).^2),[],1,'omitnan');
%Butterworth filter
fc=365; %cutoff frequency   
fs=8760; %sampling frequency  
order=3; %the order of the filter
[b,a]=butter(order,fc/(fs/2),'low'); 
shear_time_series_lowpass1 = filtfilt(b,a,double(squeeze(shear(indmin1,:))));
shear_time_series_lowpass2 = filtfilt(b,a,double(squeeze(shear(indmin2,:))));
shear_time_series_lowpass3 = filtfilt(b,a,double(squeeze(shear(indmin3,:))));
shear_time_series_lowpass4 = filtfilt(b,a,double(squeeze(shear(indmin4,:))));


%% Plot histogram for each points
figure(1)
z = 0:0.05:1;
edges = 0:0.005:0.4;
subplot(221)
h1 = histogram(shear_time_series_lowpass1,edges,'Normalization','probability'); %(3625:5832)
% ytickformat("percentage")
xlim([0 0.4])
ylim([0 0.2])
xlabel('Bottom Shear Stress [Pa]');ylabel('probability');
hold on 
h2 = histogram(double(shear(indmin1,:)'),edges,'Normalization','probability'); %
plot(ones(size(z)).*0.1,z,'r-','LineWidth',3)
l1=line(ones(size(z)).*0.06667,z,'LineWidth',3);
l1.Color = [0.9290 0.6940 0.1250];
set(gca,'fontsize',18);
hold off
subplot(222)
h3 = histogram(shear_time_series_lowpass2,edges,'Normalization','probability');%(3625:5832)
% ytickformat("percentage")
xlim([0 0.4])
ylim([0 0.2])
xlabel('Bottom Shear Stress [Pa]');ylabel('probability');
hold on 
h4 = histogram(double(shear(indmin2,:)'),edges,'Normalization','probability'); %3625:5832
plot(ones(size(z)).*0.1,z,'r-','LineWidth',3)
l1=line(ones(size(z)).*0.06667,z,'LineWidth',3);
l1.Color = [0.9290 0.6940 0.1250];
set(gca,'fontsize',18);
hold off
subplot(223)
h5 = histogram(shear_time_series_lowpass3,edges,'Normalization','probability'); %(3625:5832)
% ytickformat("percentage")
xlim([0 0.4])
ylim([0 0.2])
xlabel('Bottom Shear Stress [Pa]');ylabel('probability');
hold on 
h6 = histogram(double(shear(indmin3,:)'),edges,'Normalization','probability'); %3625:5832
plot(ones(size(z)).*0.1,z,'r-','LineWidth',3)
l1=line(ones(size(z)).*0.06667,z,'LineWidth',3);
l1.Color = [0.9290 0.6940 0.1250];
set(gca,'fontsize',18);
hold off
subplot(224)
h7 = histogram(shear_time_series_lowpass4,edges,'Normalization','probability');%(3625:5832)
% ytickformat("percentage")
xlim([0 0.4])
ylim([0 0.2])
xlabel('Bottom Shear Stress [Pa]');ylabel('probability');
hold on 
h8 = histogram(double(shear(indmin4,:)'),edges,'Normalization','probability'); %3625:5832
plot(ones(size(z)).*0.1,z,'r-','LineWidth',3)
l1=line(ones(size(z)).*0.06667,z,'LineWidth',3);
l1.Color = [0.9290 0.6940 0.1250];
set(gca,'fontsize',18);
hold off


%% Plot annually mean bottom shear stress in 2013
lonlim_GB=[3.8 9.4];
latlim_GB=[52.8 55.7];
%plot:
m_proj('mercator','long',double(lonlim_GB),'lat',double(latlim_GB));
m_gshhs_h('save','gumby');
load gumby
h=figure('units','pixels', 'Position', [200, 200, 500, 500],'Visible', 'on');%,'renderer','painters');
hold on
set(gca,'color',[.8 .8 .8])
hold on
h=m_image(lonvec,latvec,shear_mean);
m_grid('fontsize',20,'linewidth',2,'gridcolor','none');
cmocean('balance'); 
c = colorbar('fontsize',18);
c.Label.String = 'Bottom Shear Stress [kg/m/s^2(Pa)]';
caxis([0 0.2])
m_usercoast('gumby','patch',[.9 .9 .9]);
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
