
% ==========================================================
% FIR High-Pass Filter using Rectangular and Triangular Windows
% Name: Varun Goyal
% Roll No: 102315115
% ==========================================================



clc; 
clear; 
close all; 

% --- User Inputs --- 
fp = 1500 
delta_f = 500
As = 40 
Fs = 8000

% --- Normalized Frequencies --- 
wp = 2 * pi * fp / Fs;              % Normalized passband edge (rad/s) 
ws = 2 * pi * (fp + delta_f) / Fs;  % Normalized stopband edge (rad/s) 
wc = (wp + ws) / 2;                 % Cutoff frequency (rad/s) 

% --- Estimate Filter Order --- 
N = ceil(4 * pi / (ws - wp));       % Rough estimate for rectangular/triangular 
if mod(N,2)==0 
    N = N + 1; % Make filter length odd for symmetry 
end 
fprintf('\nEstimated Filter Length (N): %d\n', N); 

% --- Ideal Impulse Response (hd[n]) --- 
alpha = (N - 1) / 2; 
n = 0:N-1; 
m = n - alpha; % center the sequence 
hd = sin(wc * m) ./ (pi * m); 
hd(alpha + 1) = wc / pi; % handle NaN at m=0 

% --- Window Functions --- 
w_rect = rectwin(N);       % Rectangular window 
w_tri = triang(N);         % Triangular (Bartlett) window 

% --- Apply Windows --- 
h_rect = hd .* w_rect'; 
h_tri = hd .* w_tri'; 

% --- Frequency Response --- 
[H_rect, f] = freqz(h_rect, 1, 1024, Fs); 
[H_tri, ~] = freqz(h_tri, 1, 1024, Fs); 

% --- Plot Impulse Responses --- 
figure; 
subplot(2,1,1); 
stem(n, h_rect, 'b', 'LineWidth', 1.2); 
title('Impulse Response using Rectangular Window'); 
xlabel('n'); ylabel('h[n]'); 
legend('Varun Goyal 102315115'); 
grid on; 

subplot(2,1,2); 
stem(n, h_tri, 'r', 'LineWidth', 1.2); 
title('Impulse Response using Triangular (Bartlett) Window'); 
xlabel('n'); ylabel('h[n]'); 
legend('Varun Goyal 102315115'); 
grid on; 

% --- Plot Magnitude Responses --- 
figure; 
subplot(2,1,1); 
plot(f, 20*log10(abs(H_rect)), 'b', 'LineWidth', 1.2); 
grid on; 
title('Magnitude Response (Rectangular Window)'); 
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); 
legend('Varun Goyal 102315115'); 

subplot(2,1,2); 
plot(f, 20*log10(abs(H_tri)), 'r', 'LineWidth', 1.2); 
grid on; 
title('Magnitude Response (Triangular (Bartlett) Window)'); 
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); 
legend('Varun Goyal 102315115'); 
