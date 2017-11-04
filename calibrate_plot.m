function calibrate_plot(channels,power_spectrum_z1_a, power_spectrum_z0_a,power_spectrum_z1_c, power_spectrum_z0_c, magnitude, phase, total_magnitude,total_phase)
%                                power_spectrum_z1_a, power_spectrum_z0_a,power_spectrum_z1_c, power_spectrum_z0_c
%Local matrix
channel = 1:1:(channels);

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
YMATRIX(:,5) =  total_magnitude(1,2,:);
YMATRIX(:,6) =  total_magnitude(2,2,:);
YMATRIX(:,7) =  total_magnitude(3,2,:);
YMATRIX(:,8) =  total_magnitude(4,2,:);
plot1 = plot(channel, YMATRIX,'LineWidth',4);
% Create multiple lines using matrix input to plot
set(plot1(1),'DisplayName','z1 a x');
set(plot1(2),'DisplayName','z0 a x');
set(plot1(3),'DisplayName','z1 c x');
set(plot1(4),'DisplayName','z0 c x');
set(plot1(5),'DisplayName','z1 a y');
set(plot1(6),'DisplayName','z0 a y');
set(plot1(7),'DisplayName','z1 c y');
set(plot1(8),'DisplayName','z0 c y');

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
%subplot(1,2,1);
plot2 = plot(channel, YMATRIX1,'LineWidth',4);
% Create multiple lines using matrix input to plot
set(plot2(1),'DisplayName','z1 a x');
set(plot2(2),'DisplayName','z0 a x');
set(plot2(3),'DisplayName','z1 c x');
set(plot2(4),'DisplayName','z0 c x');
title('Probe phase: x-pol')
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Phase [Radians]','FontSize',12);

%Figure 4: Plot the phase of each channel non normalized
figure;
YMATRIX2(:,1) =  total_phase(1,2,:);
YMATRIX2(:,2) =  total_phase(2,2,:);
YMATRIX2(:,3) =  total_phase(3,2,:);
YMATRIX2(:,4) =  total_phase(4,2,:);
%subplot(1,2,2);
plot3 = plot(channel, YMATRIX2,'LineWidth',4);
% Create multiple lines using matrix input to plot
set(plot3(1),'DisplayName','z1 a y');
set(plot3(2),'DisplayName','z0 a y');
set(plot3(3),'DisplayName','z1 c y');
set(plot3(4),'DisplayName','z0 c y');
title('Probe phase: y-pol')
% Create xlabel
xlabel('Channel[#]','FontSize',12);
% Create ylabel
ylabel('Phase [degrees]','FontSize',12);
% axis(plot3,[0 channels -360 360])