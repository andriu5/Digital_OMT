clc; close all; clear all;

%% Global variables
s0 = 1;
%s0 = 12000;
%s0 = 20000;
%s0 = 1000000;
%channels = 2048;
prompt = 'Please enter the number of channels of your measurement (interger): ';
channels = input(prompt);
fsteps = 1;
probe = 1;
imchar = 'i';
%% Save Command window test to file
diary('domt_flow.txt')
diary on

%% Some matrices for efficiency
G_final = zeros(4, 2, channels);

%% alfa = 0°
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%         Begin calibration reading 0 degrees          %%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%prompt = 'Please enter the path to data set, alpha = 0 degrees in string format: ';
%data_path = input(prompt,'s');
%data_path = 'C:\Users\andre5\PycharmProjects\ML\tesis\my_csv_data_angle_0_2017-04-22_19-19';
%data_path = 'C:\Users\andre5\PycharmProjects\ML\tesis\my_csv_data_angle_0_2017-04-24_19-01';
% Select folder in GUI matlab using uigetdir():
data_path = uigetdir();
% Read csv files
z1_a = strcat(data_path,'\spectrum_z1_a*.csv');
csv_z1_a = dir(z1_a);
file_csv1 = {csv_z1_a.name};
file_z1_a = file_csv1{1,1};
csv1 = fullfile(data_path,file_z1_a);

z0_a = strcat(data_path,'\spectrum_z0_a*.csv');
csv_z0_a = dir(z0_a);
file_csv2 = {csv_z0_a.name};
file_z0_a = file_csv2{1,1};
csv2 = fullfile(data_path,file_z0_a);

z1_c = strcat(data_path,'\spectrum_z1_c*.csv');
csv_z1_c = dir(z1_c);
file_csv3 = {csv_z1_c.name};
file_z1_c = file_csv3{1,1};
csv3 = fullfile(data_path,file_z1_c);

z0_c = strcat(data_path,'\spectrum_z0_c*.csv');
csv_z0_c = dir(z0_c);
file_csv4 = {csv_z0_c.name};
file_z0_c = file_csv4{1,1};
csv4 = fullfile(data_path,file_z0_c);

%Read the data from the ROACH
[spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c] = calibrate_input(csv1, csv2, csv3, csv4);

%First measurement                       
G_1 = calibrate_measurement(1,channels,1,spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c,fsteps,s0);
G_final(:,1,:) = G_1(:,1,:);
%% alfa = 90°
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%         Begin calibration reading 90 degrees         %%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%prompt = 'Please enter the path to data set, alpha = 90 degrees in string format: ';
%data_path = input(prompt,'s');
%data_path = 'C:\Users\andre5\PycharmProjects\ML\tesis\my_csv_data_angle_90_2017-04-22_19-19';
%data_path = 'C:\Users\andre5\PycharmProjects\ML\tesis\my_csv_data_angle_90_2017-04-24_19-01';
% Select folder in GUI matlab using uigetdir():
data_path = uigetdir();
% Read csv files
z1_a = strcat(data_path,'\spectrum_z1_a*.csv');
csv_z1_a = dir(z1_a);
file_csv1 = {csv_z1_a.name};
file_z1_a = file_csv1{1,1};
csv1 = fullfile(data_path,file_z1_a);

z0_a = strcat(data_path,'\spectrum_z0_a*.csv');
csv_z0_a = dir(z0_a);
file_csv2 = {csv_z0_a.name};
file_z0_a = file_csv2{1,1};
csv2 = fullfile(data_path,file_z0_a);

z1_c = strcat(data_path,'\spectrum_z1_c*.csv');
csv_z1_c = dir(z1_c);
file_csv3 = {csv_z1_c.name};
file_z1_c = file_csv3{1,1};
csv3 = fullfile(data_path,file_z1_c);

z0_c = strcat(data_path,'\spectrum_z0_c*.csv');
csv_z0_c = dir(z0_c);
file_csv4 = {csv_z0_c.name};
file_z0_c = file_csv4{1,1};
csv4 = fullfile(data_path,file_z0_c)
% Read the data from the ROACH
[spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c] = calibrate_input(csv1, csv2, csv3, csv4);

% Second measurement
G_2 = calibrate_measurement(2,channels,2,spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c,fsteps,s0);
G_final(:,2,:) = G_2(:,2,:);

%% alfa = 45°
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%         Begin calibration reading 45 degrees         %%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%prompt = 'Please enter the path to data set, alpha = 45 degrees in string format: ';
%data_path = input(prompt,'s');
%data_path = 'C:\Users\andre5\PycharmProjects\ML\tesis\my_csv_data_angle_45_2017-04-22_19-19';
%data_path = 'C:\Users\andre5\PycharmProjects\ML\tesis\my_csv_data_angle_45_2017-04-24_19-01';
% Select folder in GUI matlab using uigetdir():
data_path = uigetdir();
% Read csv files
z1_a = strcat(data_path,'\spectrum_z1_a*.csv');
csv_z1_a = dir(z1_a);
file_csv1 = {csv_z1_a.name};
file_z1_a = file_csv1{1,1};
csv1 = fullfile(data_path,file_z1_a);

z0_a = strcat(data_path,'\spectrum_z0_a*.csv');
csv_z0_a = dir(z0_a);
file_csv2 = {csv_z0_a.name};
file_z0_a = file_csv2{1,1};
csv2 = fullfile(data_path,file_z0_a);

z1_c = strcat(data_path,'\spectrum_z1_c*.csv');
csv_z1_c = dir(z1_c);
file_csv3 = {csv_z1_c.name};
file_z1_c = file_csv3{1,1};
csv3 = fullfile(data_path,file_z1_c);

z0_c = strcat(data_path,'\spectrum_z0_c*.csv');
csv_z0_c = dir(z0_c);
file_csv4 = {csv_z0_c.name};
file_z0_c = file_csv4{1,1};
csv4 = fullfile(data_path,file_z0_c)
%Read the data from the ROACH
[spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c] = calibrate_input(csv1, csv2, csv3, csv4);

%Third measurement
G_45 = calibrate_measurement_45(channels,probe,1,spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c,fsteps, G_final, s0);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Saving the Gain matrix and displaying it in a readable sense %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%                Saving the G matrix                   %%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
% create and open a text file
fileG1 = fopen('G_0_90.txt','w');

for k = 1:1:channels
    fprintf(fileG1,'G matrix for channel: %d\r\n',k);
    %matlab save complex data to file
    fprintf(fileG1,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_final(1,1,k)),imag(G_final(1,1,k)),imchar,real(G_final(1,2,k)),imag(G_final(1,2,k)),imchar);
    fprintf(fileG1,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_final(2,1,k)),imag(G_final(2,1,k)),imchar,real(G_final(2,2,k)),imag(G_final(2,2,k)),imchar);
    fprintf(fileG1,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_final(3,1,k)),imag(G_final(3,1,k)),imchar,real(G_final(3,2,k)),imag(G_final(3,2,k)),imchar);
    fprintf(fileG1,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_final(4,1,k)),imag(G_final(4,1,k)),imchar,real(G_final(4,2,k)),imag(G_final(4,2,k)),imchar);
    %logfile_45.write(str(G_final[0,0,k]).rjust(34)+' '+str(G_final[0,1,k]).rjust(34)+'\n'+str(G_final[1,0,k]).rjust(34)+' '+str(G_final[1,1,k]).rjust(34)+'\n'+str(G_final[2,0,k]).rjust(34)+' '+str(G_final[2,1,k]).rjust(34)+'\n'+str(G_final[3,0,k]).rjust(34)+' '+str(G_final[3,1,k]).rjust(34)+'\n')
end
fclose(fileG1);

% create and open a text file
fileG = fopen('G_0_90_45.txt','w');

G_data = G_45;

for k = 1:1:channels
    fprintf(fileG,'G matrix for channel: %d\r\n',k);
    %matlab save complex data to file
    fprintf(fileG,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_data(1,1,k)),imag(G_data(1,1,k)),imchar,real(G_data(1,2,k)),imag(G_data(1,2,k)),imchar);
    fprintf(fileG,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_data(2,1,k)),imag(G_data(2,1,k)),imchar,real(G_data(2,2,k)),imag(G_data(2,2,k)),imchar);
    fprintf(fileG,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_data(3,1,k)),imag(G_data(3,1,k)),imchar,real(G_data(3,2,k)),imag(G_data(3,2,k)),imchar);
    fprintf(fileG,'(%8.8f + %8.8f%c)  (%8.8f + %8.8f%c)\r\n',real(G_data(4,1,k)),imag(G_data(4,1,k)),imchar,real(G_data(4,2,k)),imag(G_data(4,2,k)),imchar);
    %logfile_45.write(str(G_final[0,0,k]).rjust(34)+' '+str(G_final[0,1,k]).rjust(34)+'\n'+str(G_final[1,0,k]).rjust(34)+' '+str(G_final[1,1,k]).rjust(34)+'\n'+str(G_final[2,0,k]).rjust(34)+' '+str(G_final[2,1,k]).rjust(34)+'\n'+str(G_final[3,0,k]).rjust(34)+' '+str(G_final[3,1,k]).rjust(34)+'\n')
end
fclose(fileG);

input('Press enter to continue...')
close all;
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%                Done calibrating                      %%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
diary off

%%The End!
disp(' ');
disp(' ');
disp('Have Fun!');