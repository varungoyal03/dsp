clc; clear; close all;

% ---------------------------------------------------------
% FIR BANDPASS FILTER USING KAISER WINDOW
% Varun Goyal | Roll No. 102315115
% ---------------------------------------------------------

% ------------ USER INPUTS --------------------------------
fp1 = input('Enter lower passband edge frequency fp1 (Hz) (e.g., 2000): ');
fp2 = input('Enter upper passband edge frequency fp2 (Hz) (e.g., 4000): ');

df  = input('Enter transition width (Hz) (e.g., 500): ');
Ap  = input('Enter passband ripple Ap (dB) (e.g., 0.5): ');
As  = input('Enter stopband attenuation As (dB) (e.g., 60): ');
Fs  = input('Enter sampling frequency Fs (Hz) (e.g., 20000): ');

% ------------ DIGITAL (NORMALIZED) FREQUENCIES -----------
wp1 = 2*pi*fp1 / Fs;
wp2 = 2*pi*fp2 / Fs;

ws1 = 2*pi*(fp1 - df) / Fs;
ws2 = 2*pi*(fp2 + df) / Fs;

% Effective transition width
dw = min(abs(wp1 - ws1), abs(wp2 - ws2));

% ------------ KAISER WINDOW PARAMETERS -------------------
A = As;

if A > 50
    beta = 0.1102*(A - 8.7);
elseif A >= 21
    beta = 0.5842*(A - 21)^0.4 + 0.07886*(A - 21);
else
    beta = 0;
end

% Filter order
M = ceil((A - 8) / (2.285 * dw));

% ---------- FIX: MAKE M EVEN TO AVOID INDEX ERROR --------
if mod(M,2) ~= 0
    M = M + 1;
end

N = M + 1;

fprintf('\nKaiser Window beta = %.3f\n', beta);
fprintf('Filter Order N = %d\n', N);

% ------------ IDEAL BANDPASS IMPULSE RESPONSE ------------
n = 0:M;

wc1 = (wp1 + ws1)/2;
wc2 = (wp2 + ws2)/2;

hd = (sin(wc2*(n - M/2)) - sin(wc1*(n - M/2))) ./ (pi*(n - M/2));

% L'Hospital correction at center
hd(M/2 + 1) = (wc2 - wc1) / pi;

% ------------ KAISER WINDOW ------------------------------
w = kaiser(N, beta).';

% ------------ FIR COEFFICIENTS ---------------------------
h = hd .* w;

% ------------ FREQUENCY RESPONSE --------------------------
figure;
freqz(h,1,2048,Fs);
title('Bandpass FIR Filter using Kaiser Window | Varun Goyal 102315115');

% ------------ IMPULSE RESPONSE ----------------------------
figure;
stem(n, h, 'filled');
xlabel('n'); ylabel('h[n]');
title('Impulse Response h[n] | Varun Goyal 102315115');

% ------------ MAGNITUDE SPECTRUM --------------------------
figure;
plot(abs(fft(h,2048)));
xlabel('Frequency Index'); ylabel('|H(k)|');
title('Magnitude Spectrum | Varun Goyal 102315115');
