function G = calibrate_measurement(reading,channels,probe,spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c,fsteps,s0)
%UNTITLED Summary of this function goes here              spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c
%   Detailed explanation goes here

% Some matrices for efficiency
disp(channels)
G = zeros(4, 2, channels);
phase = zeros(4,1);
consistent_phase = zeros(4, 4);
power_plot = zeros(4, channels);
phase_plot = zeros(6, channels);
total_magnitude = zeros(4, 2, channels);
total_phase = zeros(4, 2, channels);
V_power = zeros(4,1);
power_spectrum_z1_a = zeros(1, channels);
power_spectrum_z1_c = zeros(1, channels);
power_spectrum_z0_a = zeros(1, channels);
power_spectrum_z0_c = zeros(1, channels);

% create and open a text file
fileID = fopen('V.txt','w');

% local variables
s0 = 1;
imchar = 'i';

for channel_number = 1:fsteps:channels
    %Constructing the voltage vectors V. 
    %We are only interested in the channel where the tone is, the rest can be discarded.
    V = [spectrum_z1_a(1,channel_number); spectrum_z0_a(1,channel_number);...
        spectrum_z1_c(1,channel_number); spectrum_z0_c(1,channel_number)];
    disp('V matrix for channel:')
    disp(channel_number)
    disp(V)
    
    fprintf(fileID,'V matrix for channel: %d\r\n',channel_number);
    %matlab save complex data to file
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(1,1)),imag(V(1,1)),imchar);
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(2,1)),imag(V(2,1)),imchar);
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(3,1)),imag(V(3,1)),imchar);
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(4,1)),imag(V(4,1)),imchar);
    fprintf(fileID,'\n');
    
    %Computing the power of the spectra for plotting
    [V_power(1,1), V_power(2,1), V_power(3,1), V_power(4,1)] = calibrate_functions.channel_power(spectrum_z1_a(1,channel_number), ...
        spectrum_z0_a(1,channel_number), spectrum_z1_c(1,channel_number), spectrum_z0_c(1,channel_number));
    %Computing the power of the spectra for plotting
    [power_spectrum_z1_a(1,channel_number), power_spectrum_z0_a(1,channel_number),...
        power_spectrum_z1_c(1,channel_number), power_spectrum_z0_c(1,channel_number)] = calibrate_functions.channel_power(spectrum_z1_a(1,channel_number),...
        spectrum_z0_a(1,channel_number), spectrum_z1_c(1,channel_number), spectrum_z0_c(1,channel_number));
    
    %Check if the channel with the maximum power correspond to the input frequency
    fprintf('Powers on channel: %d\r\n',channel_number);
    disp(V_power);
    
    M = calibrate_functions.compute_m(V);
    disp('The cross-spectrum matrix M = ');
    disp(M);

    %Computing the magnitudes of M
    magnitude = calibrate_functions.compute_mag(M);
    fprintf('Magnitude is equal to: \r\n');
    disp(magnitude);
    %Computing the magnitudes of M
    s0 = max(abs(V.^2));
    magnitude_s0 = magnitude/s0;
    fprintf('Magnitude is equal to: \r\n');
    disp(magnitude_s0);
    
    %Computing the phase of M
    rel_phase = calibrate_functions.compute_relative_phase(M);
    fprintf('Relative phase is equal to: \r\n');
    disp(rel_phase);
    
    %According to the probe settings the maximum is either user-defined or chosen by the maximum correlation
    index = probe;
    
    %% TODO: revisar esta parte! y arreglar disconinuidad en la fase!!
    %Normalising the matrix and changing to the definite phases
    if index == 1
        phase(1,1) = rel_phase(1, index);
        phase(2,1) = rel_phase(2, index);
        phase(3,1) = abs(rel_phase(3, index));
        phase(4,1) = rel_phase(4, index);
    elseif index == 2
        phase(1,1) = rel_phase(1, index);
        phase(2,1) = rel_phase(2, index);
        phase(3,1) = rel_phase(3, index);
        phase(4,1) = abs(rel_phase(4, index));
    elseif index == 3
        phase(1,1) = +abs(rel_phase(1, index));
        phase(2,1) = +abs(rel_phase(2, index));
        phase(3,1) = -abs(rel_phase(3, index));
        phase(4,1) = -abs(rel_phase(4, index));
    elseif index == 4
        phase(1,1) = rel_phase(1, index);
        phase(2,1) = rel_phase(2, index);
        phase(3,1) = rel_phase(3, index);
        phase(4,1) = rel_phase(4, index);
    else
        disp('No valid index for the phase')
    end
    
    %Writing the phases and magnitudes of the channels into a larger array. This is used to plot the increase of the phase and magnitude over the measurement.
    for i =1:1:4
        total_magnitude(i,reading,channel_number) = magnitude_s0(i,:);
%         if phase(i,:)<0
%             phase(i,:)=360+phase(i,:);
%         end
        total_phase(i,reading,channel_number) = phase(i,:)*180/pi;
%         fprintf('Normalisation has been done, the results are: \r\n');
         disp('Magnitude: ');
         disp(magnitude_s0);
%         disp('Phase: ');
%         disp(phase);
    end
    
    %See if the data is consistent (a.k.a. sanity check)
    calibrate_functions.consistency_magnitude(M);
    calibrate_functions.consistency_phase(M);
       
    %Saving the coefficients:
    for i = 1:1:4
        G(i, reading, channel_number) = magnitude_s0(i) * cos(phase(i)) + 1j * magnitude_s0(i) * sin(phase(i));
    end
end

%Plot the spectra
calibrate_plot(channels,power_spectrum_z1_a, power_spectrum_z0_a,power_spectrum_z1_c, power_spectrum_z0_c, magnitude, phase, total_magnitude,total_phase);

fclose(fileID);
end


