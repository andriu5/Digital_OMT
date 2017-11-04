classdef calibrate_functions
    %calibrate_functions is class with only methods used in calibrate_measurement.m
    methods (Static)
        %Compute the power of the spectral channels
        function [power_spectrum_z1_a, power_spectrum_z0_a, power_spectrum_z1_c, power_spectrum_z0_c] = channel_power(spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c)
            power_spectrum_z1_a = 10*log10(abs(spectrum_z1_a)^2 + 1);
            power_spectrum_z0_a = 10*log10(abs(spectrum_z0_a)^2 + 1);
            power_spectrum_z1_c = 10*log10(abs(spectrum_z1_c)^2 + 1);
            power_spectrum_z0_c = 10*log10(abs(spectrum_z0_c)^2 + 1);
            %[v,i] = max(a)
            %index1 = np.argmax(power_spectrum_z1_a, axis=0);
            %index2 = np.argmax(power_spectrum_z1_c, axis=0);
            %index3 = np.argmax(power_spectrum_z0_a, axis=0);
            %index4 = np.argmax(power_spectrum_z0_c, axis=0);
            %disp('The maximum of the spectrum are at channel: " + str(index1) + ', ' + str(index2) + ', ' + str(index3) + ', ' + str(index4))
        end
        %This function computes the matrix M = <VV*>
        function M = compute_m(V)
            M = zeros(4, 4);
            M = V*conj(V');
        end
%         function M = compute_m(V)
%             M = zeros(4, 4);
%             for i = 1:1:4
%                 for k = 1:1:4
%                     M(i,k) = V(i,1)*conj(V(k,1));
%                 end
%             end            
%         end
        %This function computes the magnitude coefficients of the gain matrix G
        function magnitude = compute_mag(M)
            magnitude = zeros(4,1);
            for i =1:1:4
                magnitude(i,:) = sqrt(abs(M(i, i)));
            end
        end
        %Compute the relative phases of the gain matrix G
        function rel_phase = compute_relative_phase(M)
            rel_phase = zeros(4, 4);
            for i = 1:1:4
                for j = 1:1:4
                    rel_phase(i,j) = atan2(imag(M(i,j)),real(M(i,j)));
                end
            end
        end
        %Do a sanity check on the data. 
        %If all goes well this should check out and all should return 0 or close too 0.
        function consistent = consistency_magnitude(M)
            consistent = zeros(4, 4);
            for i = 1:1:4
                for j = 1:1:4
                    consistent(i,j) = abs(M(i, j))^2 - abs(M(i, i)) * abs(M(j, j));
                end
            end
            disp('Consistency magnitude check (should be zero or close to 0)');
            disp(consistent);
        end
        %A second sanity check on the data. The resulting matrix should be zero or a multiple of 2pi.
        function consistent_phase = consistency_phase(M)
            %First number in each row is M_{i,k} and the following numbers are M_{i,j}+M_{j,k}
            consistent_phase = zeros(4, 4);
            for i =1:1:4
                consistent_phase(i,1) = phase(M(i, i));
            end
            consistent_phase(1,2) = phase(M(1,2)) + phase(M(2,1));
            consistent_phase(1,3) = phase(M(1,3)) + phase(M(3,1));
            consistent_phase(1,4) = phase(M(1,4)) + phase(M(4,1));
            consistent_phase(2,2) = phase(M(2,1)) + phase(M(1,2));
            consistent_phase(2,3) = phase(M(2,3)) + phase(M(3,2));
            consistent_phase(2,4) = phase(M(2,4)) + phase(M(4,2));
            consistent_phase(3,2) = phase(M(3,1)) + phase(M(1,3));
            consistent_phase(3,3) = phase(M(3,2)) + phase(M(2,3));
            consistent_phase(3,4) = phase(M(3,4)) + phase(M(4,3));
            consistent_phase(4,2) = phase(M(4,1)) + phase(M(1,4));
            consistent_phase(4,3) = phase(M(4,2)) + phase(M(2,4));
            consistent_phase(4,4) = phase(M(4,3)) + phase(M(3,4));
            disp('Consistency phase check (should be zero or a multiple of 2pi)');
            disp(consistent_phase);
        end
    end
    
end

