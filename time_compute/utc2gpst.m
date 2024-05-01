function [gps_week, gnss_dow, gnss_sow] = utc2gpst(date)
% Convert from UTC calendar date to gps system time
% The number of day of the starting time from each system to GPS is an
% integer multiple of 7, we use the gps time week num as reference.
% Parameters: 
%           GPS: [year, month, day, hour, min, sec]
%
% Return Values:
%   week_num:   Week number
%   sow:    seconds of week
%   dow:    day of week
%
% Author: Wang Hu

% Getting starting time date number
start_datenum = 723186; % GPS start Date number: datenum([1980,1,6,0,0,0])
%number of days since the beginning of GPS time
t = datetime(date)+seconds(18);
date = [t.Year,t.Month,t.Day,t.Hour,t.Minute,t.Second];
deltat   = (datenum([date(:,1), date(:,2), date(:,3)]) - start_datenum);
gps_week = floor(deltat/7);
gnss_dow  = deltat - gps_week*7;
gnss_sow  = (deltat - gps_week*7)*86400; 
gnss_sow = gnss_sow + date(:,4)*3600 + date(:,5)*60 + date(:,6);