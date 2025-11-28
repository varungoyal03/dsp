    
    % FIR High Pass Filter Design using Hamming and Hanning Windows 
clc; clear; close all; 

% ---- USER INPUTS ---- 
fp = 2000; 
df = 500; 
As = 50; 
fs =8000; 

% ---- NORMALIZED FREQUENCIES ---- 
wp = 2*pi*fp/fs;     % Passband edge (radians/sample) 
ws = wp - 2*pi*df/fs; % Stopband edge (radians/sample) 

% ---- DETERMINE FILTER ORDER ---- 
% Empirical formula for N depending on window type 
if As <= 44 
    windowType = 'Hamming'; 
    N = ceil((3.3*pi)/(2*pi*df/fs)); 
elseif As > 44 
    windowType = 'Hanning'; 
    N = ceil((3.1*pi)/(2*pi*df/fs)); 
end 

% Ensure N is odd (for symmetric linear phase) 
if mod(N,2)==0 
    N = N + 1; 
end 
fprintf('\nEstimated Filter Order N = %d\n', N); 

% ---- IDEAL HIGH-PASS IMPULSE RESPONSE ---- 
wc = (wp + ws)/2; % Cutoff frequency (radians/sample) 
n = 0:N-1; 
alpha = (N-1)/2; 
hd = -sin(wc*(n - alpha))./(pi*(n - alpha)); 
hd(alpha+1) = 1 - wc/pi; % Replace NaN at n = alpha 

% ---- WINDOW SELECTION ---- 
w_hamming = hamming(N)'; 
w_hanning = hanning(N)'; 

% ---- APPLY WINDOWS ---- 
h_hamming = hd .* w_hamming; 
h_hanning = hd .* w_hanning; 

% ---- FREQUENCY RESPONSE ---- 
[H_hamming, f] = freqz(h_hamming, 1, 1024, fs); 
[H_hanning, ~] = freqz(h_hanning, 1, 1024, fs); 

% ---- PLOTS ---- 
figure; 
subplot(2,1,1); 
plot(f, 20*log10(abs(H_hamming))); 
title('High Pass FIR Filter using Hamming Window'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude (dB)'); 
legend('Varun Goyal 102315115'); 
grid on; 

subplot(2,1,2); 
plot(f, 20*log10(abs(H_hanning))); 
title('High Pass FIR Filter using Hanning Window'); 
xlabel('Frequency (Hz)'); 
ylabel('Magnitude (dB)'); 
legend('Varun Goyal 102315115'); 
grid on; 

% ---- DISPLAY RESULTS ---- 
disp('---------------------------------------'); 
disp(' Filter Design Summary '); 
disp('---------------------------------------'); 
fprintf('Sampling Frequency = %.2f Hz\n', fs); 
fprintf('Passband Edge Frequency = %.2f Hz\n', fp); 
fprintf('Transition Width = %.2f Hz\n', df); 
fprintf('Stopband Attenuation = %.2f dB\n', As); 
fprintf('Filter Order (N) = %d\n', N); 
disp('---------------------------------------'); 
