function calibrate_plot_45(channels,power_spectrum_z1_a, power_spectrum_z0_a,power_spectrum_z1_c, power_spectrum_z0_c, magnitude, phase, total_magnitude,total_phase)
%                                   power_45_spectrum_z1_a, power_45_spectrum_z0_a,power_45_spectrum_z1_c, power_45_spectrum_z0_c
%Local matrix
channel = 1:1:channels;

%Figure 1: Plot the powers of the channels.
figure;
subplot(2,2,1);
plot(channel,power_spectrum_z1_a);
title('Instanteneous power channel z1 a');
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Magnitude [dB]','FontSize',12);

subplot(2,2,2);
plot(channel,power_spectrum_z1_c);
title('Instanteneous power channel z1 c');
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Magnitude [dB]','FontSize',12);

subplot(2,2,3);
plot(channel,power_spectrum_z0_a);
title('Instanteneous power channel z0 a');
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Magnitude [dB]','FontSize',12);

subplot(2,2,4);
plot(channel,power_spectrum_z0_c);
title('Instanteneous power channel z0 c');
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Magnitude [dB]','FontSize',12);

% %Figure 2: Plot the calibration vectors.
% figure(2);
% data = zeros(4,4);
% magnitude1 = magnitude/max(magnitude);
% for i = 1:1:4
%     data(i,2) = magnitude1(i)*cos(phase(i));
%     data(i,3) = magnitude1(i)*sin(phase(i));
% end
% plotv(data,'-')
% title('Vectors representation of the instantaneous reading');

%Figure 3: Plot the magnitude of each channel non normalized
figure;
YMATRIX(:,1) =  total_magnitude(1,1,:);
YMATRIX(:,2) =  total_magnitude(2,1,:);
YMATRIX(:,3) =  total_magnitude(3,1,:);
YMATRIX(:,4) =  total_magnitude(4,1,:);
plot1 = plot(channel, YMATRIX,'LineWidth',4);
% Create multiple lines using matrix input to plot
set(plot1(1),'DisplayName','z1 a 45°');
set(plot1(2),'DisplayName','z0 a 45°');
set(plot1(3),'DisplayName','z1 c 45°');
set(plot1(4),'DisplayName','z0 c 45°');

title('Probe Magnitude');
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Magnitude [dB]','FontSize',12);

%Figure 4: Plot the phase of each channel non normalized
figure;
YMATRIX1(:,1) =  total_phase(1,1,:);
YMATRIX1(:,2) =  total_phase(2,1,:);
YMATRIX1(:,3) =  total_phase(3,1,:);
YMATRIX1(:,4) =  total_phase(4,1,:);
plot2 = plot(channel, YMATRIX1,'LineWidth',4);
% Create multiple lines using matrix input to plot
set(plot2(1),'DisplayName','z1 a 45°');
set(plot2(2),'DisplayName','z0 a 45°');
set(plot2(3),'DisplayName','z1 c 45°');
set(plot2(4),'DisplayName','z0 c 45°');
title('Probe phase: x-pol')
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Phase [Radians]','FontSize',12);


