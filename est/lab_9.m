clc; clear; close all;

% ---------------------------------------------------------
% DIGITAL LOW PASS FILTER USING BUTTERWORTH PROTOTYPE
% IMPULSE INVARIANT TRANSFORMATION
% Varun Goyal | Roll No: 102315115
% ---------------------------------------------------------

% ----------- USER INPUTS WITH EXAMPLE IN PROMPT -------------

fp = input('Enter Passband edge frequency fp (Hz) (e.g., 1000): ');
fs = input('Enter Stopband edge frequency fs (Hz) (e.g., 2000): ');
Ap = input('Enter Passband Ripple Ap (dB) (e.g., 1): ');
As = input('Enter Stopband Attenuation As (dB) (e.g., 40): ');
Fs = input('Enter Sampling frequency Fs (Hz) (e.g., 8000): ');

% ----------- DIGITAL → ANALOG MAPPING -----------------------

Wp = 2*pi*fp;    % analog passband frequency (rad/s)
Ws = 2*pi*fs;    % analog stopband frequency (rad/s)

% ----------- BUTTERWORTH ORDER CALCULATION ------------------

ep = sqrt(10^(Ap/10) - 1);     % passband epsilon
es = sqrt(10^(As/10) - 1);     % stopband epsilon

N = ceil( log(es/ep) / (2 * log(Ws/Wp)) );   % filter order
Wc = Wp / (ep^(1/N));                         % cutoff freq

fprintf('\nButterworth Order N = %d\n', N);
fprintf('Analog Cutoff Frequency Wc = %.3f rad/s\n', Wc);

% ----------- ANALOG BUTTERWORTH TRANSFER FUNCTION -----------

[num_s, den_s] = butter(N, Wc, 's');

disp('Analog Transfer Function H(s):');
tf(num_s, den_s)

% ----------- IMPULSE INVARIANT TRANSFORMATION ---------------

[num_z, den_z] = impinvar(num_s, den_s, Fs);

disp('Digital Transfer Function H(z):');
tf(num_z, den_z, 1/Fs)

% ----------- FREQUENCY RESPONSE ------------------------------
figure;
freqz(num_z, den_z, 1024, Fs);
title('Digital LPF using Impulse Invariant Method | Varun Goyal 102315115');

% ----------- POLE-ZERO PLOT ---------------------------------
figure;
zplane(num_z, den_z);
title('Pole-Zero Plot | Varun Goyal 102315115');
