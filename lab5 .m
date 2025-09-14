%% Experiment 5: Window Functions
% Name: Varun
% Roll No: 102315115

clc; clear; close all;

x = input("Enter input sequence: ");
N = length(x);
L = (N-1)/2;

% --- Window Definitions ---
r   = zeros(1, 2*L+1);    % Rectangular
han = zeros(1, 2*L+1);    % Hanning
ham = zeros(1, 2*L+1);    % Hamming
blk = zeros(1, 2*L+1);    % Blackman

for i = 1:(2*L+1)
    n = i-1;
    r(i)   = 1;                                        % Rectangular
    han(i) = 0.5 - 0.5*cos(2*pi*n/(N-1));              % Hanning
    ham(i) = 0.54 - 0.46*cos(2*pi*n/(N-1));            % Hamming
    blk(i) = 0.42 - 0.5*cos(2*pi*n/(N-1)) + 0.08*cos(4*pi*n/(N-1));                   % Blackman
end

%% Rectangular Window
r1 = fftshift(fft(r,1000));
y1 = abs(r1)/max(abs(r1));
r2 = 20*log10(y1);

subplot(4,2,1), plot(r); 
title("Time domain of Rectangular Window - Varun (Roll No: 102315115)");
xlabel('n'); ylabel('Amplitude');

subplot(4,2,2), plot(r2); 
title("Frequency domain of Rectangular Window");
xlabel('Frequency'); ylabel('Magnitude (dB)');

%% Hanning Window
han1 = fftshift(fft(han,1000));
y2   = abs(han1)/max(abs(han1));
han2 = 20*log10(y2);

subplot(4,2,3), plot(han); 
title("Time domain of Hanning Window - Varun (Roll No: 102315115)");
xlabel('n'); ylabel('Amplitude');

subplot(4,2,4), plot(han2); 
title("Frequency domain of Hanning Window");
xlabel('Frequency'); ylabel('Magnitude (dB)');

%% Hamming Window
ham1 = fftshift(fft(ham,1000));
y3   = abs(ham1)/max(abs(ham1));
ham2 = 20*log10(y3);

subplot(4,2,5), plot(ham); 
title("Time domain of Hamming Window - Varun (Roll No: 102315115)");
xlabel('n'); ylabel('Amplitude');

subplot(4,2,6), plot(ham2); 
title("Frequency domain of Hamming Window");
xlabel('Frequency'); ylabel('Magnitude (dB)');

%% Blackman Window
blk1 = fftshift(fft(blk,1000));
y4   = abs(blk1)/max(abs(blk1));
blk2 = 20*log10(y4);

subplot(4,2,7), plot(blk); 
title("Time domain of Blackman Window - Varun (Roll No: 102315115)");
xlabel('n'); ylabel('Amplitude');

subplot(4,2,8), plot(blk2); 
title("Frequency domain of Blackman Window");
xlabel('Frequency'); ylabel('Magnitude (dB)');
