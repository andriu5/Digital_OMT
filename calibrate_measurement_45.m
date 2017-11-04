function G_f = calibrate_measurement_45( channels,probe,reading,spectrum_z1_a, spectrum_z0_a, spectrum_z1_c,...
    spectrum_z0_c,fsteps, gain_matrix_g, s0)
%Function : calibrate_measurement_45. It is used to compute the calibrate
%constants
%
%Output : 1)G_f
%
% Input  : 1) channels
%          2) probe 
%          3) reading
%          4) spectrum_z1_a
%          5) spectrum_z0_a
%          6) spectrum_z1_c
%          7) spectrum_z0_c
%          8) fsteps
%          9) gain_matrix_g
%          10) s0

% Some matrices for efficiency
G_f = zeros(4,2,channels);
phase = zeros(4,1);
total_magnitude = zeros(4,1,channels);
total_phase = zeros(4,1,channels);
V_45_power = zeros(4,1);
power_45_spectrum_z1_a = zeros(1, channels);
power_45_spectrum_z1_c = zeros(1, channels);
power_45_spectrum_z0_a = zeros(1, channels);
power_45_spectrum_z0_c = zeros(1, channels);

% create and open a text file
fileID = fopen('V_45.txt','w');

% local variables
imchar = 'i';
s0_2 = s0*s0;

for channel_number = 1:fsteps:channels
    %Constructing the voltage vectors V. 
    %We are only interested in the channel where the tone is, the rest can be discarded.
    V = [spectrum_z1_a(1,channel_number); spectrum_z0_a(1,channel_number);...
        spectrum_z1_c(1,channel_number); spectrum_z0_c(1,channel_number)];
    
    fprintf(fileID,'V matrix for channel: %d\r\n',channel_number);
    %matlab save complex data to file
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(1,1)),imag(V(1,1)),imchar);
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(2,1)),imag(V(2,1)),imchar);
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(3,1)),imag(V(3,1)),imchar);
    fprintf(fileID,'%8.8f + %8.8f%c \r\n',real(V(4,1)),imag(V(4,1)),imchar);
    fprintf(fileID,'\n');
    
    %Computing the power of the spectra for plotting
    [V_45_power(1,1), V_45_power(2,1), V_45_power(3,1), V_45_power(4,1)] = calibrate_functions.channel_power(spectrum_z1_a(1,channel_number),...
        spectrum_z0_a(1,channel_number), spectrum_z1_c(1,channel_number), spectrum_z0_c(1,channel_number));
    %Computing the power of the spectra for plotting
    [power_45_spectrum_z1_a(channel_number), power_45_spectrum_z0_a(channel_number), power_45_spectrum_z1_c(channel_number), power_45_spectrum_z0_c(channel_number)] = calibrate_functions.channel_power(spectrum_z1_a(1,channel_number),...
        spectrum_z0_a(1,channel_number), spectrum_z1_c(1,channel_number), spectrum_z0_c(1,channel_number));
    
    %Check if the channel with the maximum power correspond to the input frequency
    fprintf('Powers on channel: %d\r\n',channel_number);
    disp(V_45_power);
    
    M = calibrate_functions.compute_m(V);
    disp('The cross-spectrum matrix M = ');
    disp(M);

    %Computing the magnitudes of M
    magnitude = calibrate_functions.compute_mag(M);
    fprintf('\nMagnitude is equal to: \r\n');
    disp(magnitude);
    %Computing the magnitudes of M
    s0 = max(abs(V.^2));
    s0_2 = s0*s0;
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
        phase(4,1) = abs(rel_phase(4, index));
    elseif index == 2
        phase(1,1) = rel_phase(1, index);
        phase(2,1) = rel_phase(2, index);
        phase(3,1) = rel_phase(3, index);
        phase(4,1) = rel_phase(4, index);
    elseif index == 3
        phase(1,1) = rel_phase(1, index);
        phase(2,1) = rel_phase(2, index);
        phase(3,1) = rel_phase(3, index);
        phase(4,1) = rel_phase(4, index);
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
%         disp('Magnitude: ');
%         disp(magnitude_s0);
%         disp('Phase: ');
%         disp(phase);
    end
    
    gain_matrix_h = pinv(gain_matrix_g(:,:,channel_number));
    %print gain_matrix_g[:,:,channel_number].shape
    %print gain_matrix_g.shape
    
    % obtain the estimated values of given the partialy
    % calibrated matrix
    % H = (2,4,1)
    s_prima = gain_matrix_h*V;
    disp('S_prima = ');
    disp(s_prima);
    % print s_prima.shape
    
    % convert from linear polarization to circular
    to_circular_matrix(1,1) = 1;
    to_circular_matrix(1,2) = -1j;
    to_circular_matrix(2,1) = 1;
    to_circular_matrix(2,2) = 1j;
    s_circular = to_circular_matrix*s_prima;

    % get the square module of each polarization component
    %s_left_abs_2 = s_circular(1,1)*conj(s_circular(1,1));
    %s_rigth_abs_2 = s_circular(2,1)*conj(s_circular(2,1));

    % get the value of eps given equation 22a of the paper
    % compact orthomode transducers using digital polarizatio synthesis
    %sin_eps = real(((abs(s_circular(1,1)).^2 + abs(s_circular(2,1)).^2)/(2*s0_2) - 1.0));
    sin_eps = ((abs(s_circular(1,1)).^2 + abs(s_circular(2,1)).^2)/(10*s0_2) - 1.0);
    fprintf('sin(eps) = %f\r\n',sin_eps);
    eps = asin(sin_eps);
    fprintf('eps = %f\r\n',eps*180/pi);
    % values that are needed for leater
    cos_eps = cos(eps);
    fprintf('cos(eps) = %f\r\n',cos_eps);
    sin_2_eps = 2*sin_eps*cos_eps;
    fprintf('sin(2*eps) = %f\r\n',sin_2_eps);

    %calculate phi given equation 22b
    sin_phi = (abs(s_circular(1,1)).^2 - abs(s_circular(2,1)).^2)/(s0_2*(sin_2_eps + 2*cos_eps));
    fprintf('sin(phi) = %f\r\n',sin_phi);
    s_cross_product = s_circular(2,1)*conj(s_circular(1,1));
    %calculate phi given equation 23b
    cos_phi = 10*(imag(s_cross_product))/(s0_2*(sin_2_eps + 2*cos_eps));
    fprintf('cos(phi) = %f\r\n',cos_phi);

    % the rotations matrix given equaton 24
    rotation_matrix_eps(1,1) = 1;
    rotation_matrix_eps(1,2) = sin_eps;
    rotation_matrix_eps(2,1) = 0;
    rotation_matrix_eps(2,2) = cos_eps;
    disp('The rotation matrix given equaton 24 (eps): ');
    disp(rotation_matrix_eps);

    rotation_matrix_phi(1,1) = 1;
    rotation_matrix_phi(1,2) = 0;
    rotation_matrix_phi(2,1) = 0;
    rotation_matrix_phi(2,2) = cos_phi + 1j*sin_phi;
    disp('The rotation matrix given equaton 24 (phi): ');
    disp(rotation_matrix_phi);

    G_f(:,:,channel_number) = gain_matrix_g(:,:,channel_number) * rotation_matrix_phi * rotation_matrix_eps;
    disp('G matrix = ');
    disp(G_f(:,:,channel_number));

end

%Plot the spectra
calibrate_plot_45(channels,power_45_spectrum_z1_a, power_45_spectrum_z0_a,power_45_spectrum_z1_c, power_45_spectrum_z0_c, magnitude, phase, total_magnitude,total_phase);

fclose(fileID);

end



