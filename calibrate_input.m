function [spectrum_z1_a, spectrum_z0_a, spectrum_z1_c, spectrum_z0_c] = calibrate_input(csv1, csv2, csv3, csv4)
%CREATEFIGURE(X1, YMATRIX1)
%  csv1:  matrix of z0_a data
%  csv2:  matrix of z0_c data
%  csv3:  matrix of z1_a data
%  csv4:  matrix of z1_c data

spectrum_z1_a = csvread(csv1);
spectrum_z0_a = csvread(csv2);
spectrum_z1_c = csvread(csv3);
spectrum_z0_c = csvread(csv4);
