% Moorea LTER data analysis 
% Exploring physical data from Moorea Coral Reef LTER from 2005-2020
% For collaboration with Pete Edmunds, Nyssa Sibinger, and Griffin 

clear
load MCRLTERBottomMountTherms.mat

%____________________________________________________________________
% Where are the sensors in each LTER site (reef type and depth), but most
% of the time series are not sequential order so I will reorder them in the
% LTER00 structures

% 33-hr Low-pass filter the temperatures to remove high-freq signal
freq_cut = 1/(33*60*60); % 33hrs in Hz
samp_freq = 1/(20*60); % 20 min in Hz

[B,A] = butter(3,freq_cut/(0.5*samp_freq));


% LTER00 has only 'FOR' - forereef type sensors at 10, 20, 30, and 40m
% depth
unique(LTER00_BMT.reef_type_code);
unique(LTER00_BMT.sensor_depth_m);

LTER00.iiFOR10m = find(and(LTER00_BMT.reef_type_code=='FOR',LTER00_BMT.sensor_depth_m==10));
[LTER00.FOR10m_time_utc,I] = sort(LTER00_BMT.time_utc(LTER00.iiFOR10m));
LTER00.FOR10m_temp = LTER00_BMT.temperature_c(LTER00.iiFOR10m(I));
LTER00.FOR10m_temp_lp = filtfilt(B,A,LTER00.FOR10m_temp);
clear I

LTER00.iiFOR20m = find(and(LTER00_BMT.reef_type_code=='FOR',LTER00_BMT.sensor_depth_m==20));
[LTER00.FOR20m_time_utc,I] = sort(LTER00_BMT.time_utc(LTER00.iiFOR20m));
LTER00.FOR20m_temp = LTER00_BMT.temperature_c(LTER00.iiFOR20m(I));
LTER00.FOR20m_temp_lp = filtfilt(B,A,LTER00.FOR20m_temp);
clear I

LTER00.iiFOR30m = find(and(LTER00_BMT.reef_type_code=='FOR',LTER00_BMT.sensor_depth_m==30));
[LTER00.FOR30m_time_utc,I] = sort(LTER00_BMT.time_utc(LTER00.iiFOR30m));
LTER00.FOR30m_temp = LTER00_BMT.temperature_c(LTER00.iiFOR30m(I));
LTER00.FOR30m_temp_lp = filtfilt(B,A,LTER00.FOR30m_temp);
clear I

LTER00.iiFOR40m = find(and(LTER00_BMT.reef_type_code=='FOR',LTER00_BMT.sensor_depth_m==40));
[LTER00.FOR40m_time_utc,I] = sort(LTER00_BMT.time_utc(LTER00.iiFOR40m));
LTER00.FOR40m_temp = LTER00_BMT.temperature_c(LTER00.iiFOR40m(I));
LTER00.FOR40m_temp_lp = filtfilt(B,A,LTER00.FOR40m_temp);

% LTER01 has a backreef 'BAK' site at 1m depth and fringing 'FRI' sites at 1 and 6m 
unique(LTER01_BMT.reef_type_code);
unique(LTER01_BMT.sensor_depth_m);

LTER01.iiBAK1m = find(and(LTER01_BMT.reef_type_code=='BAK',LTER01_BMT.sensor_depth_m==1));
[LTER01.BAK1m_time_utc,I] = sort(LTER01_BMT.time_utc(LTER01.iiBAK1m));
LTER01.BAK1m_temp = LTER01_BMT.temperature_c(LTER01.iiBAK1m(I));
LTER01.BAK1m_temp_lp = filtfilt(B,A,LTER01.BAK1m_temp);
clear I

LTER01.iiFRI1m = find(and(LTER01_BMT.reef_type_code=='FRI',LTER01_BMT.sensor_depth_m==1));
[LTER01.FRI1m_time_utc,I] = sort(LTER01_BMT.time_utc(LTER01.iiFRI1m));
LTER01.FRI1m_temp = LTER01_BMT.temperature_c(LTER01.iiFRI1m(I));
LTER01.FRI1m_temp_lp = filtfilt(B,A,LTER01.FRI1m_temp);
clear I

LTER01.iiFRI6m = find(and(LTER01_BMT.reef_type_code=='FRI',LTER01_BMT.sensor_depth_m==6));
[LTER01.FRI6m_time_utc,I] = sort(LTER01_BMT.time_utc(LTER01.iiFRI6m));
LTER01.FRI6m_temp = LTER01_BMT.temperature_c(LTER01.iiFRI6m(I));
LTER01.FRI6m_temp_lp = filtfilt(B,A,LTER01.FRI6m_temp);
clear I

% LTER02 has a backreef site 'BAK' at 2m, 4 forereef 'FOR' sites at 10, 20, 
% 30, and 40m, and 2 fringing 'FRI' sites at 1 and 6m depth
unique(LTER02_BMT.reef_type_code);
unique(LTER02_BMT.sensor_depth_m);

LTER02.iiBAK2m = find(and(LTER02_BMT.reef_type_code=='BAK',LTER02_BMT.sensor_depth_m==2));
[LTER02.BAK2m_time_utc,I] = sort(LTER02_BMT.time_utc(LTER02.iiBAK2m));
LTER02.BAK2m_temp = LTER02_BMT.temperature_c(LTER02.iiBAK2m(I));
LTER02.BAK2m_temp_lp = filtfilt(B,A,LTER02.BAK2m_temp);
clear I

LTER02.iiFOR10m = find(and(LTER02_BMT.reef_type_code=='FOR',LTER02_BMT.sensor_depth_m==10));
[LTER02.FOR10m_time_utc,I] = sort(LTER02_BMT.time_utc(LTER02.iiFOR10m));
LTER02.FOR10m_temp = LTER02_BMT.temperature_c(LTER02.iiFOR10m(I));
LTER02.FOR10m_temp_lp = filtfilt(B,A,LTER02.FOR10m_temp);
clear I

LTER02.iiFOR20m = find(and(LTER02_BMT.reef_type_code=='FOR',LTER02_BMT.sensor_depth_m==20));
[LTER02.FOR20m_time_utc,I] = sort(LTER02_BMT.time_utc(LTER02.iiFOR20m));
LTER02.FOR20m_temp = LTER02_BMT.temperature_c(LTER02.iiFOR20m(I));
LTER02.FOR20m_temp_lp = filtfilt(B,A,LTER02.FOR20m_temp);
clear I

LTER02.iiFOR30m = find(and(LTER02_BMT.reef_type_code=='FOR',LTER02_BMT.sensor_depth_m==30));
[LTER02.FOR30m_time_utc,I] = sort(LTER02_BMT.time_utc(LTER02.iiFOR30m));
LTER02.FOR30m_temp = LTER02_BMT.temperature_c(LTER02.iiFOR30m(I));
LTER02.FOR30m_temp_lp = filtfilt(B,A,LTER02.FOR30m_temp);
clear I

LTER02.iiFOR40m = find(and(LTER02_BMT.reef_type_code=='FOR',LTER02_BMT.sensor_depth_m==40));
[LTER02.FOR40m_time_utc,I] = sort(LTER02_BMT.time_utc(LTER02.iiFOR40m));
LTER02.FOR40m_temp = LTER02_BMT.temperature_c(LTER02.iiFOR40m(I));
LTER02.FOR40m_temp_lp = filtfilt(B,A,LTER02.FOR40m_temp);
clear I

LTER02.iiFRI1m = find(and(LTER02_BMT.reef_type_code=='FRI',LTER02_BMT.sensor_depth_m==1));
[LTER02.FRI1m_time_utc,I] = sort(LTER02_BMT.time_utc(LTER02.iiFRI1m));
LTER02.FRI1m_temp = LTER02_BMT.temperature_c(LTER02.iiFRI1m(I));
LTER02.FRI1m_temp_lp = filtfilt(B,A,LTER02.FRI1m_temp);
clear I


% LTER03 has a backreef site 'BAK' at 2m, 4 forereef 'FOR' sites at 10, 20, 
% 30, and 40m, and 2 fringing 'FRI' sites at 1 and 7m depth
unique(LTER03_BMT.reef_type_code);
unique(LTER03_BMT.sensor_depth_m);

LTER03.iiBAK2m = find(and(LTER03_BMT.reef_type_code=='BAK',LTER03_BMT.sensor_depth_m==2));
[LTER03.BAK2m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiBAK2m));
LTER03.BAK2m_temp = LTER03_BMT.temperature_c(LTER03.iiBAK2m(I));
LTER03.BAK2m_temp_lp = filtfilt(B,A,LTER03.BAK2m_temp);
clear I

LTER03.iiFOR10m = find(and(LTER03_BMT.reef_type_code=='FOR',LTER03_BMT.sensor_depth_m==10));
[LTER03.FOR10m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiFOR10m));
LTER03.FOR10m_temp = LTER03_BMT.temperature_c(LTER03.iiFOR10m(I));
LTER03.FOR10m_temp_lp = filtfilt(B,A,LTER03.FOR10m_temp);
clear I

LTER03.iiFOR20m = find(and(LTER03_BMT.reef_type_code=='FOR',LTER03_BMT.sensor_depth_m==20));
[LTER03.FOR20m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiFOR20m));
LTER03.FOR20m_temp = LTER03_BMT.temperature_c(LTER03.iiFOR20m(I));
LTER03.FOR20m_temp_lp = filtfilt(B,A,LTER03.FOR20m_temp);
clear I

LTER03.iiFOR30m = find(and(LTER03_BMT.reef_type_code=='FOR',LTER03_BMT.sensor_depth_m==30));
[LTER03.FOR30m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiFOR30m));
LTER03.FOR30m_temp = LTER03_BMT.temperature_c(LTER03.iiFOR30m(I));
LTER03.FOR30m_temp_lp = filtfilt(B,A,LTER03.FOR30m_temp);
clear I

LTER03.iiFOR40m = find(and(LTER03_BMT.reef_type_code=='FOR',LTER03_BMT.sensor_depth_m==40));
[LTER03.FOR40m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiFOR40m));
LTER03.FOR40m_temp = LTER03_BMT.temperature_c(LTER03.iiFOR40m(I));
LTER03.FOR40m_temp_lp = filtfilt(B,A,LTER03.FOR40m_temp);
clear I

LTER03.iiFRI1m = find(and(LTER03_BMT.reef_type_code=='FRI',LTER03_BMT.sensor_depth_m==1));
[LTER03.FRI1m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiFRI1m));
LTER03.FRI1m_temp = LTER03_BMT.temperature_c(LTER03.iiFRI1m(I));
LTER03.FRI1m_temp_lp = filtfilt(B,A,LTER03.FRI1m_temp);
clear I

LTER03.iiFRI7m = find(and(LTER03_BMT.reef_type_code=='FRI',LTER03_BMT.sensor_depth_m==7));
[LTER03.FRI7m_time_utc,I] = sort(LTER03_BMT.time_utc(LTER03.iiFRI7m));
LTER03.FRI7m_temp = LTER03_BMT.temperature_c(LTER03.iiFRI7m(I));
LTER03.FRI7m_temp_lp = filtfilt(B,A,LTER03.FRI7m_temp);
clear I

% LTER04 has a backreef site 'BAK' at 2m, 4 forereef 'FOR' sites at 10, 20, 
% 30, and 40m, and 2 fringing 'FRI' sites at 1 and 6m depth
unique(LTER04_BMT.reef_type_code);
unique(LTER04_BMT.sensor_depth_m);

LTER04.iiBAK2m = find(and(LTER04_BMT.reef_type_code=='BAK',LTER04_BMT.sensor_depth_m==2));
[LTER04.BAK2m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiBAK2m));
LTER04.BAK2m_temp = LTER04_BMT.temperature_c(LTER04.iiBAK2m(I));
LTER04.BAK2m_temp_lp = filtfilt(B,A,LTER04.BAK2m_temp);
clear I

LTER04.iiFOR10m = find(and(LTER04_BMT.reef_type_code=='FOR',LTER04_BMT.sensor_depth_m==10));
[LTER04.FOR10m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiFOR10m));
LTER04.FOR10m_temp = LTER04_BMT.temperature_c(LTER04.iiFOR10m(I));
LTER04.FOR10m_temp_lp = filtfilt(B,A,LTER04.FOR10m_temp);
clear I

LTER04.iiFOR20m = find(and(LTER04_BMT.reef_type_code=='FOR',LTER04_BMT.sensor_depth_m==20));
[LTER04.FOR20m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiFOR20m));
LTER04.FOR20m_temp = LTER04_BMT.temperature_c(LTER04.iiFOR20m(I));
LTER04.FOR20m_temp_lp = filtfilt(B,A,LTER04.FOR20m_temp);
clear I

LTER04.iiFOR30m = find(and(LTER04_BMT.reef_type_code=='FOR',LTER04_BMT.sensor_depth_m==30));
[LTER04.FOR30m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiFOR30m));
LTER04.FOR30m_temp = LTER04_BMT.temperature_c(LTER04.iiFOR30m(I));
LTER04.FOR30m_temp_lp = filtfilt(B,A,LTER04.FOR30m_temp);
clear I

LTER04.iiFOR40m = find(and(LTER04_BMT.reef_type_code=='FOR',LTER04_BMT.sensor_depth_m==40));
[LTER04.FOR40m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiFOR40m));
LTER04.FOR40m_temp = LTER04_BMT.temperature_c(LTER04.iiFOR40m(I));
LTER04.FOR40m_temp_lp = filtfilt(B,A,LTER04.FOR40m_temp);
clear I

LTER04.iiFRI1m = find(and(LTER04_BMT.reef_type_code=='FRI',LTER04_BMT.sensor_depth_m==1));
[LTER04.FRI1m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiFRI1m));
LTER04.FRI1m_temp = LTER04_BMT.temperature_c(LTER04.iiFRI1m(I));
LTER04.FRI1m_temp_lp = filtfilt(B,A,LTER04.FRI1m_temp);
clear I

LTER04.iiFRI6m = find(and(LTER04_BMT.reef_type_code=='FRI',LTER04_BMT.sensor_depth_m==6));
[LTER04.FRI6m_time_utc,I] = sort(LTER04_BMT.time_utc(LTER04.iiFRI6m));
LTER04.FRI6m_temp = LTER04_BMT.temperature_c(LTER04.iiFRI6m(I));
LTER04.FRI6m_temp_lp = filtfilt(B,A,LTER04.FRI6m_temp);
clear I

% LTER05 has a backreef site 'BAK' at 2m, 4 forereef 'FOR' sites at 10, 20, 
% 30, and 40m, and 2 fringing 'FRI' sites at 1 and 3m depth
unique(LTER05_BMT.reef_type_code);
unique(LTER05_BMT.sensor_depth_m);

LTER05.iiBAK2m = find(and(LTER05_BMT.reef_type_code=='BAK',LTER05_BMT.sensor_depth_m==2));
[LTER05.BAK2m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiBAK2m));
LTER05.BAK2m_temp = LTER05_BMT.temperature_c(LTER05.iiBAK2m(I));
LTER05.BAK2m_temp_lp = filtfilt(B,A,LTER05.BAK2m_temp);
clear I

LTER05.iiFOR10m = find(and(LTER05_BMT.reef_type_code=='FOR',LTER05_BMT.sensor_depth_m==10));
[LTER05.FOR10m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiFOR10m));
LTER05.FOR10m_temp = LTER05_BMT.temperature_c(LTER05.iiFOR10m(I));
LTER05.FOR10m_temp_lp = filtfilt(B,A,LTER05.FOR10m_temp);
clear I

LTER05.iiFOR20m = find(and(LTER05_BMT.reef_type_code=='FOR',LTER05_BMT.sensor_depth_m==20));
[LTER05.FOR20m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiFOR20m));
LTER05.FOR20m_temp = LTER05_BMT.temperature_c(LTER05.iiFOR20m(I));
LTER05.FOR20m_temp_lp = filtfilt(B,A,LTER05.FOR20m_temp);
clear I

LTER05.iiFOR30m = find(and(LTER05_BMT.reef_type_code=='FOR',LTER05_BMT.sensor_depth_m==30));
[LTER05.FOR30m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiFOR30m));
LTER05.FOR30m_temp = LTER05_BMT.temperature_c(LTER05.iiFOR30m(I));
LTER05.FOR30m_temp_lp = filtfilt(B,A,LTER05.FOR30m_temp);
clear I

LTER05.iiFOR40m = find(and(LTER05_BMT.reef_type_code=='FOR',LTER05_BMT.sensor_depth_m==40));
[LTER05.FOR40m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiFOR40m));
LTER05.FOR40m_temp = LTER05_BMT.temperature_c(LTER05.iiFOR40m(I));
LTER05.FOR40m_temp_lp = filtfilt(B,A,LTER05.FOR40m_temp);
clear I

LTER05.iiFRI1m = find(and(LTER05_BMT.reef_type_code=='FRI',LTER05_BMT.sensor_depth_m==1));
[LTER05.FRI1m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiFRI1m));
LTER05.FRI1m_temp = LTER05_BMT.temperature_c(LTER05.iiFRI1m(I));
LTER05.FRI1m_temp_lp = filtfilt(B,A,LTER05.FRI1m_temp);
clear I

LTER05.iiFRI3m = find(and(LTER05_BMT.reef_type_code=='FRI',LTER05_BMT.sensor_depth_m==3));
[LTER05.FRI3m_time_utc,I] = sort(LTER05_BMT.time_utc(LTER05.iiFRI3m));
LTER05.FRI3m_temp = LTER05_BMT.temperature_c(LTER05.iiFRI3m(I));
LTER05.FRI3m_temp_lp = filtfilt(B,A,LTER05.FRI3m_temp);
clear I

% LTER06 has a backreef site 'BAK' at 2m, 4 forereef 'FOR' sites at 10, 20, 
% 30, and 40m, and 2 fringing 'FRI' sites at 1 and 4m depth
unique(LTER06_BMT.reef_type_code);
unique(LTER06_BMT.sensor_depth_m);

LTER06.iiBAK2m = find(and(LTER06_BMT.reef_type_code=='BAK',LTER06_BMT.sensor_depth_m==2));
[LTER06.BAK2m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiBAK2m));
LTER06.BAK2m_temp = LTER06_BMT.temperature_c(LTER06.iiBAK2m(I));
LTER06.BAK2m_temp_lp = filtfilt(B,A,LTER06.BAK2m_temp);
clear I

LTER06.iiFOR10m = find(and(LTER06_BMT.reef_type_code=='FOR',LTER06_BMT.sensor_depth_m==10));
[LTER06.FOR10m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiFOR10m));
LTER06.FOR10m_temp = LTER06_BMT.temperature_c(LTER06.iiFOR10m(I));
LTER06.FOR10m_temp_lp = filtfilt(B,A,LTER06.FOR10m_temp);
clear I

LTER06.iiFOR20m = find(and(LTER06_BMT.reef_type_code=='FOR',LTER06_BMT.sensor_depth_m==20));
[LTER06.FOR20m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiFOR20m));
LTER06.FOR20m_temp = LTER06_BMT.temperature_c(LTER06.iiFOR20m(I));
LTER06.FOR20m_temp_lp = filtfilt(B,A,LTER06.FOR20m_temp);
clear I

LTER06.iiFOR30m = find(and(LTER06_BMT.reef_type_code=='FOR',LTER06_BMT.sensor_depth_m==30));
[LTER06.FOR30m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiFOR30m));
LTER06.FOR30m_temp = LTER06_BMT.temperature_c(LTER06.iiFOR30m(I));
LTER06.FOR30m_temp_lp = filtfilt(B,A,LTER06.FOR30m_temp);
clear I

LTER06.iiFOR40m = find(and(LTER06_BMT.reef_type_code=='FOR',LTER06_BMT.sensor_depth_m==40));
[LTER06.FOR40m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiFOR40m));
LTER06.FOR40m_temp = LTER06_BMT.temperature_c(LTER06.iiFOR40m(I));
LTER06.FOR40m_temp_lp = filtfilt(B,A,LTER06.FOR40m_temp);
clear I

LTER06.iiFRI1m = find(and(LTER06_BMT.reef_type_code=='FRI',LTER06_BMT.sensor_depth_m==1));
[LTER06.FRI1m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiFRI1m));
LTER06.FRI1m_temp = LTER06_BMT.temperature_c(LTER06.iiFRI1m(I));
LTER06.FRI1m_temp_lp = filtfilt(B,A,LTER06.FRI1m_temp);
clear I

LTER06.iiFRI4m = find(and(LTER06_BMT.reef_type_code=='FRI',LTER06_BMT.sensor_depth_m==4));
[LTER06.FRI4m_time_utc,I] = sort(LTER06_BMT.time_utc(LTER06.iiFRI4m));
LTER06.FRI4m_temp = LTER06_BMT.temperature_c(LTER06.iiFRI4m(I));
LTER06.FRI4m_temp_lp = filtfilt(B,A,LTER06.FRI4m_temp);
clear I



%_____________________________________________________________________

% First plot up time series of temperature at all sites separated by
% reef_type_code

% Raw 20-minute temperatures

figure
ax(1) = subplot(3,1,1)
plot(LTER01.FRI1m_time_utc,LTER01.FRI1m_temp,'r')
hold on
plot(LTER02.FRI1m_time_utc,LTER02.FRI1m_temp,'y')
plot(LTER03.FRI1m_time_utc,LTER03.FRI1m_temp,'g')
plot(LTER04.FRI1m_time_utc,LTER04.FRI1m_temp,'c')
plot(LTER05.FRI1m_time_utc,LTER05.FRI1m_temp,'b')
plot(LTER06.FRI1m_time_utc,LTER06.FRI1m_temp,'m')
grid on
legend('LTER 1','LTER 2','LTER 3','LTER 4','LTER 5','LTER 6')
title('Fringing (1m)')
ylabel('20-min Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))])
ylim([23 32])
datetickzoom('x','keeplimits')

ax(2) = subplot(3,1,2)
plot(LTER01.BAK1m_time_utc,LTER01.BAK1m_temp,'r')
hold on
plot(LTER02.BAK2m_time_utc,LTER02.BAK2m_temp,'y')
plot(LTER03.BAK2m_time_utc,LTER03.BAK2m_temp,'g')
plot(LTER04.BAK2m_time_utc,LTER04.BAK2m_temp,'c')
plot(LTER05.BAK2m_time_utc,LTER05.BAK2m_temp,'b')
plot(LTER06.BAK2m_time_utc,LTER06.BAK2m_temp,'m')
grid on
title('Backreef (1-2m)')
ylabel('20-min Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))])
ylim([23 32])
datetickzoom('x','keeplimits')


ax(3) = subplot(3,1,3)
plot(LTER02.FOR40m_time_utc,LTER02.FOR40m_temp,'r')
hold on
plot(LTER02.FOR10m_time_utc,LTER02.FOR10m_temp,'y')
plot(LTER03.FOR10m_time_utc,LTER03.FOR10m_temp,'g')
plot(LTER04.FOR10m_time_utc,LTER04.FOR10m_temp,'c')
plot(LTER05.FOR10m_time_utc,LTER05.FOR10m_temp,'b')
plot(LTER06.FOR10m_time_utc,LTER06.FOR10m_temp,'m')
grid on
title('Forereef (10m): Note: LTER00 = LTER01 offshore?')
ylabel('20-min Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([23 32])
datetickzoom('x','keeplimits')
linkaxes(ax)

%____________________________-
% 33hr lpf temperature plot
figure
subplot 311
plot(LTER01.FRI1m_time_utc,LTER01.FRI1m_temp_lp,'r')
hold on
plot(LTER02.FRI1m_time_utc,LTER02.FRI1m_temp_lp,'y')
plot(LTER03.FRI1m_time_utc,LTER03.FRI1m_temp_lp,'g')
plot(LTER04.FRI1m_time_utc,LTER04.FRI1m_temp_lp,'c')
plot(LTER05.FRI1m_time_utc,LTER05.FRI1m_temp_lp,'b')
plot(LTER06.FRI1m_time_utc,LTER06.FRI1m_temp_lp,'m')
grid on
legend('LTER 1','LTER 2','LTER 3','LTER 4','LTER 5','LTER 6')
title('Fringing (1m)')
ylabel('33hr-lpf Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([23 32])
datetickzoom('x','keeplimits')


subplot 312
plot(LTER01.BAK1m_time_utc,LTER01.BAK1m_temp_lp,'r')
hold on
plot(LTER02.BAK2m_time_utc,LTER02.BAK2m_temp_lp,'y')
plot(LTER03.BAK2m_time_utc,LTER03.BAK2m_temp_lp,'g')
plot(LTER04.BAK2m_time_utc,LTER04.BAK2m_temp_lp,'c')
plot(LTER05.BAK2m_time_utc,LTER05.BAK2m_temp_lp,'b')
plot(LTER06.BAK2m_time_utc,LTER06.BAK2m_temp_lp,'m')
grid on
title('Backreef (1-2m)')
ylabel('33hr-lpf Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))])
ylim([23 32])
datetickzoom('x','keeplimits')


subplot 313
plot(LTER02.FOR40m_time_utc,LTER02.FOR40m_temp_lp,'r')
hold on
plot(LTER02.FOR10m_time_utc,LTER02.FOR10m_temp_lp,'y')
plot(LTER03.FOR10m_time_utc,LTER03.FOR10m_temp_lp,'g')
plot(LTER04.FOR10m_time_utc,LTER04.FOR10m_temp_lp,'c')
plot(LTER05.FOR10m_time_utc,LTER05.FOR10m_temp_lp,'b')
plot(LTER06.FOR10m_time_utc,LTER06.FOR10m_temp_lp,'m')
grid on
title('Forereef (10m): Note: LTER00 = LTER01 offshore?')
ylabel('33hr-lpf Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([23 32])
datetickzoom('x','keeplimits')


%% _____________________________
% Quantify avg, max, min, and DTR for each day
npday = (24*60/20); % number of samples per day

%LTER00.FOR10m
ii_midnight = find(timeofday(LTER00.FOR10m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER00.FOR10m_time_daily = LTER00.FOR10m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER00.FOR10m_temp_daily(ii,:) = LTER00.FOR10m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER00.FOR10m_temp_avg = mean(LTER00.FOR10m_temp_daily,2);
LTER00.FOR10m_temp_dmax = max(LTER00.FOR10m_temp_daily,[],2);
LTER00.FOR10m_temp_dmin = min(LTER00.FOR10m_temp_daily,[],2);
LTER00.FOR10m_DTR = LTER00.FOR10m_temp_dmax-LTER00.FOR10m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER00.FOR20m
ii_midnight = find(timeofday(LTER00.FOR20m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER00.FOR20m_time_daily = LTER00.FOR20m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER00.FOR20m_temp_daily(ii,:) = LTER00.FOR20m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER00.FOR20m_temp_avg = mean(LTER00.FOR20m_temp_daily,2);
LTER00.FOR20m_temp_dmax = max(LTER00.FOR20m_temp_daily,[],2);
LTER00.FOR20m_temp_dmin = min(LTER00.FOR20m_temp_daily,[],2);
LTER00.FOR20m_DTR = LTER00.FOR20m_temp_dmax-LTER00.FOR20m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER00.FOR30m
ii_midnight = find(timeofday(LTER00.FOR30m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER00.FOR30m_time_daily = LTER00.FOR30m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER00.FOR30m_temp_daily(ii,:) = LTER00.FOR30m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER00.FOR30m_temp_avg = mean(LTER00.FOR30m_temp_daily,2);
LTER00.FOR30m_temp_dmax = max(LTER00.FOR30m_temp_daily,[],2);
LTER00.FOR30m_temp_dmin = min(LTER00.FOR30m_temp_daily,[],2);
LTER00.FOR30m_DTR = LTER00.FOR30m_temp_dmax-LTER00.FOR30m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER00.FOR40m
ii_midnight = find(timeofday(LTER00.FOR40m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER00.FOR40m_time_daily = LTER00.FOR40m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER00.FOR40m_temp_daily(ii,:) = LTER00.FOR40m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER00.FOR40m_temp_avg = max(LTER00.FOR40m_temp_daily,2);
LTER00.FOR40m_temp_dmax = max(LTER00.FOR40m_temp_daily,[],2);
LTER00.FOR40m_temp_dmin = min(LTER00.FOR40m_temp_daily,[],2);
LTER00.FOR40m_DTR = LTER00.FOR40m_temp_dmax-LTER00.FOR40m_temp_dmin;
clear ii_midnight ii_midfull ii


%LTER01.BAK1m
ii_midnight = find(timeofday(LTER01.BAK1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER01.BAK1m_time_daily = LTER01.BAK1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER01.BAK1m_temp_daily(ii,:) = LTER01.BAK1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER01.BAK1m_temp_avg = mean(LTER01.BAK1m_temp_daily,2);
LTER01.BAK1m_temp_dmax = max(LTER01.BAK1m_temp_daily,[],2);
LTER01.BAK1m_temp_dmin = min(LTER01.BAK1m_temp_daily,[],2);
LTER01.BAK1m_DTR = LTER01.BAK1m_temp_dmax-LTER01.BAK1m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER01.FRI1m
ii_midnight = find(timeofday(LTER01.FRI1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER01.FRI1m_time_daily = LTER01.FRI1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER01.FRI1m_temp_daily(ii,:) = LTER01.FRI1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER01.FRI1m_temp_avg = mean(LTER01.FRI1m_temp_daily,2);
LTER01.FRI1m_temp_dmax = max(LTER01.FRI1m_temp_daily,[],2);
LTER01.FRI1m_temp_dmin = min(LTER01.FRI1m_temp_daily,[],2);
LTER01.FRI1m_DTR = LTER01.FRI1m_temp_dmax-LTER01.FRI1m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER01.FRI6m
ii_midnight = find(timeofday(LTER01.FRI6m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER01.FRI6m_time_daily = LTER01.FRI6m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER01.FRI6m_temp_daily(ii,:) = LTER01.FRI6m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER01.FRI6m_temp_avg = mean(LTER01.FRI6m_temp_daily,2);
LTER01.FRI6m_temp_dmax = max(LTER01.FRI6m_temp_daily,[],2);
LTER01.FRI6m_temp_dmin = min(LTER01.FRI6m_temp_daily,[],2);
LTER01.FRI6m_DTR = LTER01.FRI6m_temp_dmax-LTER01.FRI6m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER02.BAK2m
ii_midnight = find(timeofday(LTER02.BAK2m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER02.BAK2m_time_daily = LTER02.BAK2m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER02.BAK2m_temp_daily(ii,:) = LTER02.BAK2m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER02.BAK2m_temp_avg = mean(LTER02.BAK2m_temp_daily,2);
LTER02.BAK2m_temp_dmax = max(LTER02.BAK2m_temp_daily,[],2);
LTER02.BAK2m_temp_dmin = min(LTER02.BAK2m_temp_daily,[],2);
LTER02.BAK2m_DTR = LTER02.BAK2m_temp_dmax-LTER02.BAK2m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER02.FOR10m
ii_midnight = find(timeofday(LTER02.FOR10m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER02.FOR10m_time_daily = LTER02.FOR10m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER02.FOR10m_temp_daily(ii,:) = LTER02.FOR10m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER02.FOR10m_temp_avg = mean(LTER02.FOR10m_temp_daily,2);
LTER02.FOR10m_temp_dmax = max(LTER02.FOR10m_temp_daily,[],2);
LTER02.FOR10m_temp_dmin = min(LTER02.FOR10m_temp_daily,[],2);
LTER02.FOR10m_DTR = LTER02.FOR10m_temp_dmax-LTER02.FOR10m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER02.FOR20m
ii_midnight = find(timeofday(LTER02.FOR20m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER02.FOR20m_time_daily = LTER02.FOR20m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER02.FOR20m_temp_daily(ii,:) = LTER02.FOR20m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER02.FOR20m_temp_avg = mean(LTER02.FOR20m_temp_daily,2);
LTER02.FOR20m_temp_dmax = max(LTER02.FOR20m_temp_daily,[],2);
LTER02.FOR20m_temp_dmin = min(LTER02.FOR20m_temp_daily,[],2);
LTER02.FOR20m_DTR = LTER02.FOR20m_temp_dmax-LTER02.FOR20m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER02.FOR30m
ii_midnight = find(timeofday(LTER02.FOR30m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER02.FOR30m_time_daily = LTER02.FOR30m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER02.FOR30m_temp_daily(ii,:) = LTER02.FOR30m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER02.FOR30m_temp_avg = mean(LTER02.FOR30m_temp_daily,2);
LTER02.FOR30m_temp_dmax = max(LTER02.FOR30m_temp_daily,[],2);
LTER02.FOR30m_temp_dmin = min(LTER02.FOR30m_temp_daily,[],2);
LTER02.FOR30m_DTR = LTER02.FOR30m_temp_dmax-LTER02.FOR30m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER02.FOR40m
ii_midnight = find(timeofday(LTER02.FOR40m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER02.FOR40m_time_daily = LTER02.FOR40m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER02.FOR40m_temp_daily(ii,:) = LTER02.FOR40m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER02.FOR40m_temp_avg = mean(LTER02.FOR40m_temp_daily,2);
LTER02.FOR40m_temp_dmax = max(LTER02.FOR40m_temp_daily,[],2);
LTER02.FOR40m_temp_dmin = min(LTER02.FOR40m_temp_daily,[],2);
LTER02.FOR40m_DTR = LTER02.FOR40m_temp_dmax-LTER02.FOR40m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER02.FRI1m
ii_midnight = find(timeofday(LTER02.FRI1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER02.FRI1m_time_daily = LTER02.FRI1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER02.FRI1m_temp_daily(ii,:) = LTER02.FRI1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER02.FRI1m_temp_avg = mean(LTER02.FRI1m_temp_daily,2);
LTER02.FRI1m_temp_dmax = max(LTER02.FRI1m_temp_daily,[],2);
LTER02.FRI1m_temp_dmin = min(LTER02.FRI1m_temp_daily,[],2);
LTER02.FRI1m_DTR = LTER02.FRI1m_temp_dmax-LTER02.FRI1m_temp_dmin;
clear ii_midnight ii_midfull ii


%LTER03.BAK2m
ii_midnight = find(timeofday(LTER03.BAK2m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.BAK2m_time_daily = LTER03.BAK2m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.BAK2m_temp_daily(ii,:) = LTER03.BAK2m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.BAK2m_temp_avg = mean(LTER03.BAK2m_temp_daily,2);
LTER03.BAK2m_temp_dmax = max(LTER03.BAK2m_temp_daily,[],2);
LTER03.BAK2m_temp_dmin = min(LTER03.BAK2m_temp_daily,[],2);
LTER03.BAK2m_DTR = LTER03.BAK2m_temp_dmax-LTER03.BAK2m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER03.FOR10m
ii_midnight = find(timeofday(LTER03.FOR10m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.FOR10m_time_daily = LTER03.FOR10m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.FOR10m_temp_daily(ii,:) = LTER03.FOR10m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.FOR10m_temp_avg = mean(LTER03.FOR10m_temp_daily,2);
LTER03.FOR10m_temp_dmax = max(LTER03.FOR10m_temp_daily,[],2);
LTER03.FOR10m_temp_dmin = min(LTER03.FOR10m_temp_daily,[],2);
LTER03.FOR10m_DTR = LTER03.FOR10m_temp_dmax-LTER03.FOR10m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER03.FOR20m
ii_midnight = find(timeofday(LTER03.FOR20m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.FOR20m_time_daily = LTER03.FOR20m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.FOR20m_temp_daily(ii,:) = LTER03.FOR20m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.FOR20m_temp_avg = mean(LTER03.FOR20m_temp_daily,2);
LTER03.FOR20m_temp_dmax = max(LTER03.FOR20m_temp_daily,[],2);
LTER03.FOR20m_temp_dmin = min(LTER03.FOR20m_temp_daily,[],2);
LTER03.FOR20m_DTR = LTER03.FOR20m_temp_dmax-LTER03.FOR20m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER03.FOR30m
ii_midnight = find(timeofday(LTER03.FOR30m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.FOR30m_time_daily = LTER03.FOR30m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.FOR30m_temp_daily(ii,:) = LTER03.FOR30m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.FOR30m_temp_avg = mean(LTER03.FOR30m_temp_daily,2);
LTER03.FOR30m_temp_dmax = max(LTER03.FOR30m_temp_daily,[],2);
LTER03.FOR30m_temp_dmin = min(LTER03.FOR30m_temp_daily,[],2);
LTER03.FOR30m_DTR = LTER03.FOR30m_temp_dmax-LTER03.FOR30m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER03.FOR40m
ii_midnight = find(timeofday(LTER03.FOR40m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.FOR40m_time_daily = LTER03.FOR40m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.FOR40m_temp_daily(ii,:) = LTER03.FOR40m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.FOR40m_temp_avg = mean(LTER03.FOR40m_temp_daily,2);
LTER03.FOR40m_temp_dmax = max(LTER03.FOR40m_temp_daily,[],2);
LTER03.FOR40m_temp_dmin = min(LTER03.FOR40m_temp_daily,[],2);
LTER03.FOR40m_DTR = LTER03.FOR40m_temp_dmax-LTER03.FOR40m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER03.FRI1m
ii_midnight = find(timeofday(LTER03.FRI1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.FRI1m_time_daily = LTER03.FRI1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.FRI1m_temp_daily(ii,:) = LTER03.FRI1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.FRI1m_temp_avg = mean(LTER03.FRI1m_temp_daily,2);
LTER03.FRI1m_temp_dmax = max(LTER03.FRI1m_temp_daily,[],2);
LTER03.FRI1m_temp_dmin = min(LTER03.FRI1m_temp_daily,[],2);
LTER03.FRI1m_DTR = LTER03.FRI1m_temp_dmax-LTER03.FRI1m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER03.FRI7m
ii_midnight = find(timeofday(LTER03.FRI7m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER03.FRI7m_time_daily = LTER03.FRI7m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER03.FRI7m_temp_daily(ii,:) = LTER03.FRI7m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER03.FRI7m_temp_avg = mean(LTER03.FRI7m_temp_daily,2);
LTER03.FRI7m_temp_dmax = max(LTER03.FRI7m_temp_daily,[],2);
LTER03.FRI7m_temp_dmin = min(LTER03.FRI7m_temp_daily,[],2);
LTER03.FRI7m_DTR = LTER03.FRI7m_temp_dmax-LTER03.FRI7m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.BAK2m
ii_midnight = find(timeofday(LTER04.BAK2m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.BAK2m_time_daily = LTER04.BAK2m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.BAK2m_temp_daily(ii,:) = LTER04.BAK2m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.BAK2m_temp_avg = mean(LTER04.BAK2m_temp_daily,2);
LTER04.BAK2m_temp_dmax = max(LTER04.BAK2m_temp_daily,[],2);
LTER04.BAK2m_temp_dmin = min(LTER04.BAK2m_temp_daily,[],2);
LTER04.BAK2m_DTR = LTER04.BAK2m_temp_dmax-LTER04.BAK2m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.FOR10m
ii_midnight = find(timeofday(LTER04.FOR10m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.FOR10m_time_daily = LTER04.FOR10m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.FOR10m_temp_daily(ii,:) = LTER04.FOR10m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.FOR10m_temp_avg = mean(LTER04.FOR10m_temp_daily,2);
LTER04.FOR10m_temp_dmax = max(LTER04.FOR10m_temp_daily,[],2);
LTER04.FOR10m_temp_dmin = min(LTER04.FOR10m_temp_daily,[],2);
LTER04.FOR10m_DTR = LTER04.FOR10m_temp_dmax-LTER04.FOR10m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.FOR20m
ii_midnight = find(timeofday(LTER04.FOR20m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.FOR20m_time_daily = LTER04.FOR20m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.FOR20m_temp_daily(ii,:) = LTER04.FOR20m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.FOR20m_temp_avg = mean(LTER04.FOR20m_temp_daily,2);
LTER04.FOR20m_temp_dmax = max(LTER04.FOR20m_temp_daily,[],2);
LTER04.FOR20m_temp_dmin = min(LTER04.FOR20m_temp_daily,[],2);
LTER04.FOR20m_DTR = LTER04.FOR20m_temp_dmax-LTER04.FOR20m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.FOR30m
ii_midnight = find(timeofday(LTER04.FOR30m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.FOR30m_time_daily = LTER04.FOR30m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.FOR30m_temp_daily(ii,:) = LTER04.FOR30m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.FOR30m_temp_avg = mean(LTER04.FOR30m_temp_daily,2);
LTER04.FOR30m_temp_dmax = max(LTER04.FOR30m_temp_daily,[],2);
LTER04.FOR30m_temp_dmin = min(LTER04.FOR30m_temp_daily,[],2);
LTER04.FOR30m_DTR = LTER04.FOR30m_temp_dmax-LTER04.FOR30m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.FOR40m
ii_midnight = find(timeofday(LTER04.FOR40m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.FOR40m_time_daily = LTER04.FOR40m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.FOR40m_temp_daily(ii,:) = LTER04.FOR40m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.FOR40m_temp_avg = mean(LTER04.FOR40m_temp_daily,2);
LTER04.FOR40m_temp_dmax = max(LTER04.FOR40m_temp_daily,[],2);
LTER04.FOR40m_temp_dmin = min(LTER04.FOR40m_temp_daily,[],2);
LTER04.FOR40m_DTR = LTER04.FOR40m_temp_dmax-LTER04.FOR40m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.FRI1m
ii_midnight = find(timeofday(LTER04.FRI1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.FRI1m_time_daily = LTER04.FRI1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.FRI1m_temp_daily(ii,:) = LTER04.FRI1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.FRI1m_temp_avg = mean(LTER04.FRI1m_temp_daily,2);
LTER04.FRI1m_temp_dmax = max(LTER04.FRI1m_temp_daily,[],2);
LTER04.FRI1m_temp_dmin = min(LTER04.FRI1m_temp_daily,[],2);
LTER04.FRI1m_DTR = LTER04.FRI1m_temp_dmax-LTER04.FRI1m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER04.FRI6m
ii_midnight = find(timeofday(LTER04.FRI6m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER04.FRI6m_time_daily = LTER04.FRI6m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER04.FRI6m_temp_daily(ii,:) = LTER04.FRI6m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER04.FRI6m_temp_avg = mean(LTER04.FRI6m_temp_daily,2);
LTER04.FRI6m_temp_dmax = max(LTER04.FRI6m_temp_daily,[],2);
LTER04.FRI6m_temp_dmin = min(LTER04.FRI6m_temp_daily,[],2);
LTER04.FRI6m_DTR = LTER04.FRI6m_temp_dmax-LTER04.FRI6m_temp_dmin;
clear ii_midnight ii_midfull ii

%_________________
%LTER05.BAK2m
ii_midnight = find(timeofday(LTER05.BAK2m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.BAK2m_time_daily = LTER05.BAK2m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.BAK2m_temp_daily(ii,:) = LTER05.BAK2m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.BAK2m_temp_avg = mean(LTER05.BAK2m_temp_daily,2);
LTER05.BAK2m_temp_dmax = max(LTER05.BAK2m_temp_daily,[],2);
LTER05.BAK2m_temp_dmin = min(LTER05.BAK2m_temp_daily,[],2);
LTER05.BAK2m_DTR = LTER05.BAK2m_temp_dmax-LTER05.BAK2m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER05.FOR10m
ii_midnight = find(timeofday(LTER05.FOR10m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.FOR10m_time_daily = LTER05.FOR10m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.FOR10m_temp_daily(ii,:) = LTER05.FOR10m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.FOR10m_temp_avg = mean(LTER05.FOR10m_temp_daily,2);
LTER05.FOR10m_temp_dmax = max(LTER05.FOR10m_temp_daily,[],2);
LTER05.FOR10m_temp_dmin = min(LTER05.FOR10m_temp_daily,[],2);
LTER05.FOR10m_DTR = LTER05.FOR10m_temp_dmax-LTER05.FOR10m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER05.FOR20m
ii_midnight = find(timeofday(LTER05.FOR20m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.FOR20m_time_daily = LTER05.FOR20m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.FOR20m_temp_daily(ii,:) = LTER05.FOR20m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.FOR20m_temp_avg = mean(LTER05.FOR20m_temp_daily,2);
LTER05.FOR20m_temp_dmax = max(LTER05.FOR20m_temp_daily,[],2);
LTER05.FOR20m_temp_dmin = min(LTER05.FOR20m_temp_daily,[],2);
LTER05.FOR20m_DTR = LTER05.FOR20m_temp_dmax-LTER05.FOR20m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER05.FOR30m
ii_midnight = find(timeofday(LTER05.FOR30m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.FOR30m_time_daily = LTER05.FOR30m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.FOR30m_temp_daily(ii,:) = LTER05.FOR30m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.FOR30m_temp_avg = mean(LTER05.FOR30m_temp_daily,2);
LTER05.FOR30m_temp_dmax = max(LTER05.FOR30m_temp_daily,[],2);
LTER05.FOR30m_temp_dmin = min(LTER05.FOR30m_temp_daily,[],2);
LTER05.FOR30m_DTR = LTER05.FOR30m_temp_dmax-LTER05.FOR30m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER05.FOR40m
ii_midnight = find(timeofday(LTER05.FOR40m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.FOR40m_time_daily = LTER05.FOR40m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.FOR40m_temp_daily(ii,:) = LTER05.FOR40m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.FOR40m_temp_avg = mean(LTER05.FOR40m_temp_daily,2);
LTER05.FOR40m_temp_dmax = max(LTER05.FOR40m_temp_daily,[],2);
LTER05.FOR40m_temp_dmin = min(LTER05.FOR40m_temp_daily,[],2);
LTER05.FOR40m_DTR = LTER05.FOR40m_temp_dmax-LTER05.FOR40m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER05.FRI1m
ii_midnight = find(timeofday(LTER05.FRI1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.FRI1m_time_daily = LTER05.FRI1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.FRI1m_temp_daily(ii,:) = LTER05.FRI1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.FRI1m_temp_avg = mean(LTER05.FRI1m_temp_daily,2);
LTER05.FRI1m_temp_dmax = max(LTER05.FRI1m_temp_daily,[],2);
LTER05.FRI1m_temp_dmin = min(LTER05.FRI1m_temp_daily,[],2);
LTER05.FRI1m_DTR = LTER05.FRI1m_temp_dmax-LTER05.FRI1m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER05.FRI3m
ii_midnight = find(timeofday(LTER05.FRI3m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER05.FRI3m_time_daily = LTER05.FRI3m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER05.FRI3m_temp_daily(ii,:) = LTER05.FRI3m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER05.FRI3m_temp_avg = mean(LTER05.FRI3m_temp_daily,2);
LTER05.FRI3m_temp_dmax = max(LTER05.FRI3m_temp_daily,[],2);
LTER05.FRI3m_temp_dmin = min(LTER05.FRI3m_temp_daily,[],2);
LTER05.FRI3m_DTR = LTER05.FRI3m_temp_dmax-LTER05.FRI3m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.BAK2m
ii_midnight = find(timeofday(LTER06.BAK2m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.BAK2m_time_daily = LTER06.BAK2m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.BAK2m_temp_daily(ii,:) = LTER06.BAK2m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.BAK2m_temp_avg = mean(LTER06.BAK2m_temp_daily,2);
LTER06.BAK2m_temp_dmax = max(LTER06.BAK2m_temp_daily,[],2);
LTER06.BAK2m_temp_dmin = min(LTER06.BAK2m_temp_daily,[],2);
LTER06.BAK2m_DTR = LTER06.BAK2m_temp_dmax-LTER06.BAK2m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.FOR10m
ii_midnight = find(timeofday(LTER06.FOR10m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.FOR10m_time_daily = LTER06.FOR10m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.FOR10m_temp_daily(ii,:) = LTER06.FOR10m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.FOR10m_temp_avg = mean(LTER06.FOR10m_temp_daily,2);
LTER06.FOR10m_temp_dmax = max(LTER06.FOR10m_temp_daily,[],2);
LTER06.FOR10m_temp_dmin = min(LTER06.FOR10m_temp_daily,[],2);
LTER06.FOR10m_DTR = LTER06.FOR10m_temp_dmax-LTER06.FOR10m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.FOR20m
ii_midnight = find(timeofday(LTER06.FOR20m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.FOR20m_time_daily = LTER06.FOR20m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.FOR20m_temp_daily(ii,:) = LTER06.FOR20m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.FOR20m_temp_avg = mean(LTER06.FOR20m_temp_daily,2);
LTER06.FOR20m_temp_dmax = max(LTER06.FOR20m_temp_daily,[],2);
LTER06.FOR20m_temp_dmin = min(LTER06.FOR20m_temp_daily,[],2);
LTER06.FOR20m_DTR = LTER06.FOR20m_temp_dmax-LTER06.FOR20m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.FOR30m
ii_midnight = find(timeofday(LTER06.FOR30m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.FOR30m_time_daily = LTER06.FOR30m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.FOR30m_temp_daily(ii,:) = LTER06.FOR30m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.FOR30m_temp_avg = mean(LTER06.FOR30m_temp_daily,2);
LTER06.FOR30m_temp_dmax = max(LTER06.FOR30m_temp_daily,[],2);
LTER06.FOR30m_temp_dmin = min(LTER06.FOR30m_temp_daily,[],2);
LTER06.FOR30m_DTR = LTER06.FOR30m_temp_dmax-LTER06.FOR30m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.FOR40m
ii_midnight = find(timeofday(LTER06.FOR40m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.FOR40m_time_daily = LTER06.FOR40m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.FOR40m_temp_daily(ii,:) = LTER06.FOR40m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.FOR40m_temp_avg = mean(LTER06.FOR40m_temp_daily,2);
LTER06.FOR40m_temp_dmax = max(LTER06.FOR40m_temp_daily,[],2);
LTER06.FOR40m_temp_dmin = min(LTER06.FOR40m_temp_daily,[],2);
LTER06.FOR40m_DTR = LTER06.FOR40m_temp_dmax-LTER06.FOR40m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.FRI1m
ii_midnight = find(timeofday(LTER06.FRI1m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.FRI1m_time_daily = LTER06.FRI1m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.FRI1m_temp_daily(ii,:) = LTER06.FRI1m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.FRI1m_temp_avg = mean(LTER06.FRI1m_temp_daily,2);
LTER06.FRI1m_temp_dmax = max(LTER06.FRI1m_temp_daily,[],2);
LTER06.FRI1m_temp_dmin = min(LTER06.FRI1m_temp_daily,[],2);
LTER06.FRI1m_DTR = LTER06.FRI1m_temp_dmax-LTER06.FRI1m_temp_dmin;
clear ii_midnight ii_midfull ii

%LTER06.FRI4m
ii_midnight = find(timeofday(LTER06.FRI4m_time_utc)==0);
ii_midfull = ii_midnight([diff(ii_midnight); 1]==72);
LTER06.FRI4m_time_daily = LTER06.FRI4m_time_utc(ii_midfull);
for ii = 1:length(ii_midfull)
    LTER06.FRI4m_temp_daily(ii,:) = LTER06.FRI4m_temp(ii_midfull(ii):ii_midfull(ii)+71);
end
LTER06.FRI4m_temp_avg = mean(LTER06.FRI4m_temp_daily,2);
LTER06.FRI4m_temp_dmax = max(LTER06.FRI4m_temp_daily,[],2);
LTER06.FRI4m_temp_dmin = min(LTER06.FRI4m_temp_daily,[],2);
LTER06.FRI4m_DTR = LTER06.FRI4m_temp_dmax-LTER06.FRI4m_temp_dmin;
clear ii_midnight ii_midfull ii

save MCRLTERBottomMountThermsPlus

%% Plots for paper
load MCRLTERBottomMountThermsPlus

% First let's just plot the max, min and DTR for LTER 1 FRI, BAK, FOR10m,
% and FOR 20m sites for comparison to Fig. 2 in draft paper

figure

subplot(2,4,1) 
plot(LTER01.FRI6m_time_daily,LTER01.FRI6m_temp_dmax,'r')
hold on
plot(LTER01.FRI6m_time_daily,LTER01.FRI6m_temp_dmin,'b')
plot([datetime(datevec('01 Jan 2007')) datetime(datevec('01 Jan 2007'))],[24 31],'c--')
plot([datetime(datevec('01 Jan 2012')) datetime(datevec('01 Jan 2012'))],[24 31],'c--')
grid on
title('LTER01 FRI6m; Lines = COTS')
ylabel('Daily Min & Max Temp (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([24 31])
datetickzoom('x','keeplimits')

subplot(2,4,2) 
plot(LTER01.BAK1m_time_daily,LTER01.BAK1m_temp_dmax,'r')
hold on
plot(LTER01.BAK1m_time_daily,LTER01.BAK1m_temp_dmin,'b')
plot([datetime(datevec('01 Jan 2007')) datetime(datevec('01 Jan 2007'))],[24 31],'c--')
plot([datetime(datevec('01 Jan 2012')) datetime(datevec('01 Jan 2012'))],[24 31],'c--')
grid on
title('LTER01 BAK1m; Lines = COTS')
ylabel('Daily Min & Max Temp (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([24 31])
datetickzoom('x','keeplimits')

subplot(2,4,3) 
plot(LTER00.FOR10m_time_daily,LTER00.FOR10m_temp_dmax,'r')
hold on
plot(LTER00.FOR10m_time_daily,LTER00.FOR10m_temp_dmin,'b')
plot([datetime(datevec('01 Feb 2010')) datetime(datevec('01 Feb 2010'))],[24 31],'m--')
grid on
title('LTER00 FOR10m; Line = Hurr. Oli')
ylabel('Daily Min & Max Temp (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([24 31])
datetickzoom('x','keeplimits')

subplot(2,4,4) 
plot(LTER00.FOR20m_time_daily,LTER00.FOR20m_temp_dmax,'r')
hold on
plot(LTER00.FOR20m_time_daily,LTER00.FOR20m_temp_dmin,'b')
plot([datetime(datevec('01 Feb 2010')) datetime(datevec('01 Feb 2010'))],[24 31],'m--')
grid on
title('LTER00 FOR20m; Line = Hurr. Oli')
ylabel('Daily Min & Max Temp (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([24 31])
datetickzoom('x','keeplimits')

subplot(2,4,5) 
plot(LTER01.FRI6m_time_daily,LTER01.FRI6m_DTR,'k')
hold on
plot([datetime(datevec('01 Jan 2007')) datetime(datevec('01 Jan 2007'))],[0 3.3],'c--')
plot([datetime(datevec('01 Jan 2012')) datetime(datevec('01 Jan 2012'))],[0 3.3],'c--')
grid on
title('LTER01 FRI6m; Lines = COTS')
ylabel('DTR (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([0 3.3])
datetickzoom('x','keeplimits')

subplot(2,4,6) 
plot(LTER01.BAK1m_time_daily,LTER01.BAK1m_DTR,'k')
hold on
plot([datetime(datevec('01 Jan 2007')) datetime(datevec('01 Jan 2007'))],[0 3.3],'c--')
plot([datetime(datevec('01 Jan 2012')) datetime(datevec('01 Jan 2012'))],[0 3.3],'c--')
grid on
title('LTER01 BAK1m; Lines = COTS')
ylabel('DTR (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([0 3.3])
datetickzoom('x','keeplimits')

subplot(2,4,7) 
plot(LTER00.FOR10m_time_daily,LTER00.FOR10m_DTR,'k')
hold on
plot([datetime(datevec('01 Feb 2010')) datetime(datevec('01 Feb 2010'))],[0 3.3],'m--')
grid on
title('LTER00 FOR10m; Line = Hurr. Oli')
ylabel('DTR (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([0 3.3])
datetickzoom('x','keeplimits')

subplot(2,4,8) 
plot(LTER00.FOR20m_time_daily,LTER00.FOR20m_DTR,'k')
hold on
plot([datetime(datevec('01 Feb 2010')) datetime(datevec('01 Feb 2010'))],[0 3.3],'m--')
grid on
title('LTER00 FOR20m; Line = Hurr. Oli')
ylabel('DTR (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([0 3.3])
datetickzoom('x','keeplimits')


%% Calculate "synchrony" of LTER 1 bottom moored temperature time series
% The goal is the create a timeseries of "synchrony" between the
% temperature time series like Griffin has in Fig. 4 of ms draft for coral
% abundance. 
% For each year calculate the coef of var for all four sites within LTER1
Tyear = 2005:2019;
temp_mat = NaN(length(Tyear),366,4); % initializing size
DTR_mat = NaN(length(Tyear),366,4); % initializing size

for ii = 1:length(Tyear) % looping through years
    Tyeari = datenum(Tyear(ii),1,1):datenum(Tyear(ii),12,31);
    Tyearisp = datenum(Tyear(ii),9,1):datenum(Tyear(ii)+1,1,31);% spawning period (Sept - Jan)
    T_FRI = NaN(length(Tyeari),1);
    T_BAK = NaN(length(Tyeari),1);
    T_FOR10 = NaN(length(Tyeari),1);
    T_FOR20 = NaN(length(Tyeari),1);
    DTR_FRI = NaN(length(Tyeari),1);
    DTR_BAK = NaN(length(Tyeari),1);
    DTR_FOR10 = NaN(length(Tyeari),1);
    DTR_FOR20 = NaN(length(Tyeari),1);
    isgood_FRI = NaN(length(Tyeari),1);
    isgood_BAK = NaN(length(Tyeari),1);
    isgood_FOR10 = NaN(length(Tyeari),1);
    isgood_FOR20 = NaN(length(Tyeari),1);
    for jj = 1:length(Tyeari) % looping through days of year
        ind = find(datenum(LTER01.FRI6m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            isgood_FRI(jj)=ind;
            T_FRI(jj)=LTER01.FRI6m_temp_avg(ind);
            DTR_FRI(jj)=LTER01.FRI6m_DTR(ind);
        end
        clear ind
        ind = find(datenum(LTER01.BAK1m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            isgood_BAK(jj)=ind;
            T_BAK(jj)=LTER01.BAK1m_temp_avg(ind);
            DTR_BAK(jj)=LTER01.BAK1m_DTR(ind);
        end
        clear ind
        ind = find(datenum(LTER02.FOR10m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            isgood_FOR10(jj)=ind;
            T_FOR10(jj)=LTER02.FOR10m_temp_avg(ind);
            DTR_FOR10(jj)=LTER02.FOR10m_DTR(ind);
        end
        clear ind
        ind = find(datenum(LTER02.FOR20m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            isgood_FOR20(jj)=ind;
            T_FOR20(jj)=LTER02.FOR20m_temp_avg(ind);
            DTR_FOR20(jj)=LTER02.FOR20m_DTR(ind);
        end
        clear ind
    end
    isgood_mat(ii,1:length(Tyeari),:) = [isgood_FRI isgood_BAK isgood_FOR10 isgood_FOR20];
    temp_mat(ii,1:length(Tyeari),:) = [T_FRI T_BAK T_FOR10 T_FOR20];
    isnan_mat(ii,:,:) = isnan(temp_mat(ii,:,:));
    DTR_mat(ii,1:length(Tyeari),:) = [DTR_FRI DTR_BAK DTR_FOR10 DTR_FOR20];
    temp_AnnAvg(ii,:) = squeeze(nanmean(temp_mat(ii,:,:),2));
    temp_SpwnAvg(ii,:) = squeeze(nanmean(temp_mat(ii,end-122:end,:)));
    DTR_AnnAvg(ii,:) = squeeze(nanmean(DTR_mat(ii,:,:),2));
    DTR_SpwnAvg(ii,:) = squeeze(nanmean(DTR_mat(ii,end-122:end,:)));
    varmat(ii,:,:) = cov(squeeze(temp_mat(ii,:,:)),'omitrows');
    varmat_DTR(ii,:,:) = cov(squeeze(DTR_mat(ii,:,:)),'omitrows');
    clear Tyeari T_FRI T_BAK T_FOR10 T_FOR20 ind DTR_FRI DTR_BAK DTR_FOR10 DTR_FOR20
end

% Calculate the "Synchrony" of the avg temps for each year
for ii = 1:length(Tyear) % looping through years
    phi(ii) = nansum(nansum(squeeze(varmat(ii,:,:))))/(nansum(sqrt(diag(squeeze(varmat(ii,:,:)))))^2);
end

% Calc Synchrony for DTR
for ii = 1:length(Tyear) % looping through years
    phi_DTR(ii) = nansum(nansum(squeeze(varmat_DTR(ii,:,:))))/(nansum(sqrt(diag(squeeze(varmat_DTR(ii,:,:)))))^2);
end

%recalculating Synchrony without the FRI moorings
for ii = 1:length(Tyear) % looping through years
    Tyeari = datenum(Tyear(ii),1,1):datenum(Tyear(ii),12,31);
    T_BAK = NaN(length(Tyeari),1);
    T_FOR10 = NaN(length(Tyeari),1);
    T_FOR20 = NaN(length(Tyeari),1);
    for jj = 1:length(Tyeari) % looping through days of year
        ind = find(datenum(LTER01.BAK1m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            T_BAK(jj)=LTER01.BAK1m_temp_avg(ind);
        end
        ind = find(datenum(LTER02.FOR10m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            T_FOR10(jj)=LTER02.FOR10m_temp_avg(ind);
        end
        ind = find(datenum(LTER02.FOR20m_time_daily)==Tyeari(jj));
        if isempty(ind)==0
            T_FOR20(jj)=LTER02.FOR20m_temp_avg(ind);
        end
    end
    temp_mat_NF(ii,1:length(Tyeari),:) = [T_BAK T_FOR10 T_FOR20];
    varmat_NF(ii,:,:) = cov(squeeze(temp_mat_NF(ii,:,:)),'omitrows');
    varmat_NF_spwn(ii,:,:) = cov(squeeze(temp_mat_NF(ii,end-122:end,:)),'omitrows');
    clear Tyeari T_BAK T_FOR10 T_FOR20 ind
end

% Calculate the "Synchrony" without FRI moorings of the avg temps for each year
for ii = 1:length(Tyear) % looping through years
    phi_NF(ii) = nansum(nansum(squeeze(varmat_NF(ii,:,:))))/(nansum(sqrt(diag(squeeze(varmat_NF(ii,:,:)))))^2);
    phi_NF_spwn(ii) = nansum(nansum(squeeze(varmat_NF_spwn(ii,:,:))))/(nansum(sqrt(diag(squeeze(varmat_NF_spwn(ii,:,:)))))^2);
end


figure
plot(Tyear,phi,'--bs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])
hold on
plot(Tyear,phi_NF,'--gs',...datetick
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.5])
plot(Tyear,phi_NF_spwn,'--rs',...datetick
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor',[0.5,0.5,0.5])
axis([2005 2019 0.9 1])
legend('All Sites','Not including FRI Site','NO FRI and Spawning (Sept-Dec)')
ylabel('Phi for bottom temp measurements')
xlabel('Year')
grid on


% Try replacing missing data with other LTER sites
% First compare LTER00 forereef moorings with LTER02
figure
subplot(2,1,1)
plot(LTER02.FOR10m_time_utc,LTER02.FOR10m_temp,'r')
hold on
plot(LTER00.FOR10m_time_utc,LTER00.FOR10m_temp,'y')
grid on
title('Forereef (10m): Compare LTER00 and LTER02')
ylabel('20-min Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([23 32])
datetickzoom('x','keeplimits')
legend('LTER02','LTER00')

subplot(2,1,2)
plot(LTER02.FOR20m_time_utc,LTER02.FOR20m_temp,'r')
hold on
plot(LTER00.FOR20m_time_utc,LTER00.FOR20m_temp,'y')
grid on
title('Forereef (20m): Compare LTER00 and LTER02')
ylabel('20-min Temperature (^oC)')
xlim([datetime(datevec('01 Jan 2005')) datetime(datevec('01 Jan 2020'))]) 
ylim([23 32])
datetickzoom('x','keeplimits')

% compare means and standard deviations of the overlapping 4 yr period from
% 10Apr2010 - 10April2014
ii_LTER00_10m = find(and(datenum(2010,04,10)<=datenum(LTER00.FOR10m_time_utc),datenum(2014,04,10)>=datenum(LTER00.FOR10m_time_utc)));
ii_LTER02_10m = find(and(datenum(2010,04,10)<=datenum(LTER02.FOR10m_time_utc),datenum(2014,04,10)>=datenum(LTER02.FOR10m_time_utc)));
ii_LTER00_20m = find(and(datenum(2010,04,10)<=datenum(LTER00.FOR20m_time_utc),datenum(2014,04,10)>=datenum(LTER00.FOR20m_time_utc)));
ii_LTER02_20m = find(and(datenum(2010,04,10)<=datenum(LTER02.FOR20m_time_utc),datenum(2014,04,10)>=datenum(LTER02.FOR20m_time_utc)));
mean_LTER00FOR20 = mean(LTER00.FOR20m_temp(ii_LTER00_20m),'omitnan')
mean_LTER02FOR20 = mean(LTER02.FOR20m_temp(ii_LTER02_20m),'omitnan')
mean_LTER00FOR10 = mean(LTER00.FOR10m_temp(ii_LTER00_10m),'omitnan')
mean_LTER02FOR10 = mean(LTER02.FOR10m_temp(ii_LTER02_10m),'omitnan')
xx = LTER00.FOR20m_temp(ii_LTER00_20m);
stdv_LTER00FOR20 = std(xx(~isnan(xx)))
clear xx
xx = LTER02.FOR20m_temp(ii_LTER02_20m);
stdv_LTER02FOR20 = std(xx(~isnan(xx)))
clear xx
xx = LTER00.FOR10m_temp(ii_LTER00_10m);
stdv_LTER00FOR10 = std(xx(~isnan(xx)))
clear xx
xx = LTER02.FOR10m_temp(ii_LTER02_10m);
stdv_LTER02FOR10 = std(xx(~isnan(xx)))
clear xx
% Plot up sychrony for DTR:
figure
plot(Tyear,phi_DTR,'--bs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])

axis([2005 2019 0.3 1])
ylabel('Phi for DTR')
xlabel('Year')
grid on


% Determine how many good measurements are in each temperature record at
% each site in annual averages and spawning season averages
for ii = 1:15
    for jj = 1:4
        isgood_summary(ii,jj) = length(find(isnan(squeeze(squeeze(isgood_mat(ii,:,jj))))==0));
        isgood_spwn_sum(ii,jj) = length(find(isnan(squeeze(squeeze(isgood_mat(ii,end-122:end,jj))))==0));
    end
end
isgood_percent = isgood_summary./366; % percentage of good temp measurements in annual average temp and DTS measurement
isgood_spwn_percent = isgood_spwn_sum./123; % same but for spawning period (Sept - Dec)

% Remove Avg T and DTR measurements with less than 75% of data
temp_AnnAvg(isgood_percent<0.75)=NaN;
temp_SpwnAvg(isgood_spwn_percent<0.75)=NaN;
DTR_AnnAvg(isgood_percent<0.75)=NaN;
DTR_SpwnAvg(isgood_spwn_percent<0.75)=NaN;

figure
subplot 211
plot(Tyear, temp_AnnAvg(:,1),'ko','MarkerSize',10,'MarkerFaceColor','b')
hold on
plot(Tyear, temp_AnnAvg(:,2),'ko','MarkerSize',10,'MarkerFaceColor','r')
plot(Tyear, temp_AnnAvg(:,3),'ko','MarkerSize',10,'MarkerFaceColor','g')
plot(Tyear, temp_AnnAvg(:,4),'ko','MarkerSize',10,'MarkerFaceColor','c')
legend('FRI','BAK','FOR 10m','FOR 20m')
grid on
title('Annual Average Bottom Temperature (Jan - Dec)')
ylabel('T (deg C)')
axis([2005 2019 -Inf Inf])

subplot 212
plot(Tyear, temp_SpwnAvg(:,1),'ko','MarkerSize',10,'MarkerFaceColor','b')
hold on
plot(Tyear, temp_SpwnAvg(:,2),'ko','MarkerSize',10,'MarkerFaceColor','r')
plot(Tyear, temp_SpwnAvg(:,3),'ko','MarkerSize',10,'MarkerFaceColor','g')
plot(Tyear, temp_SpwnAvg(:,4),'ko','MarkerSize',10,'MarkerFaceColor','c')
legend('FRI','BAK','FOR 10m','FOR 20m')
grid on
title('Spawning Period Bottom Temperature (Sept - Dec)')
ylabel('T (deg C)')
axis([2005 2019 -Inf Inf])

figure
subplot 211
plot(Tyear, DTR_AnnAvg(:,1),'ko','MarkerSize',10,'MarkerFaceColor','b')
hold on
plot(Tyear, DTR_AnnAvg(:,2),'ko','MarkerSize',10,'MarkerFaceColor','r')
plot(Tyear, DTR_AnnAvg(:,3),'ko','MarkerSize',10,'MarkerFaceColor','g')
plot(Tyear, DTR_AnnAvg(:,4),'ko','MarkerSize',10,'MarkerFaceColor','c')
legend('FRI','BAK','FOR 10m','FOR 20m')
grid on
title('Annual Average DTR (Jan - Dec)')
ylabel('T (deg C)')
axis([2005 2019 -Inf Inf])

subplot 212
plot(Tyear, DTR_SpwnAvg(:,1),'ko','MarkerSize',10,'MarkerFaceColor','b')
hold on
plot(Tyear, DTR_SpwnAvg(:,2),'ko','MarkerSize',10,'MarkerFaceColor','r')
plot(Tyear, DTR_SpwnAvg(:,3),'ko','MarkerSize',10,'MarkerFaceColor','g')
plot(Tyear, DTR_SpwnAvg(:,4),'ko','MarkerSize',10,'MarkerFaceColor','c')
legend('FRI','BAK','FOR 10m','FOR 20m')
grid on
title('Spawning Period DTR (Sept - Dec)')
ylabel('T (deg C)')
axis([2005 2019 -Inf Inf])
