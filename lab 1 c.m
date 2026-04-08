%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJECT: Advanced Multi-Component Signal Synthesizer (AMSS)
% AUTHOR: Varun Goyal (ID: 102315115)
% DATE: 08-April-2026
% DESCRIPTION: Framework for generating, analyzing, and visualizing 
%              composite sinusoidal waveforms with additive noise.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all;

%% 1. CONFIGURATION & CONSTANTS
params.Fs = 2000;                     % Sampling Frequency (Nyquist compliant)
params.Duration = 1.0;                % Signal duration in seconds
params.t = 0:1/params.Fs:params.Duration-(1/params.Fs); 
params.NoiseFloor = 0.05;             % Additive White Gaussian Noise level

%% 2. USER DATA ACQUISITION
fprintf('--- AMSS Signal Configuration ---\n');
N = input('Enter number of components to synthesize: ');

% Pre-allocate memory for speed
signal_components = zeros(N, length(params.t));
composite_signal = zeros(1, length(params.t));

%% 3. COMPOSITE SIGNAL SYNTHESIS ENGINE
for k = 1:N
    fprintf('\nConfiguring Component #%d:\n', k);
    A   = input('  > Amplitude: ');
    f   = input('  > Frequency (Hz): ');
    phi = input('  > Phase (deg): ');
    
    % Generate individual component
    signal_components(k, :) = A * sin(2*pi*f*params.t + deg2rad(phi));
    
    % Accumulate into composite signal
    composite_signal = composite_signal + signal_components(k, :);
end

% Add Stochastic Noise Element
noise = params.NoiseFloor * randn(size(params.t));
composite_signal_noisy = composite_signal + noise;

%% 4. FREQUENCY DOMAIN ANALYSIS (FFT)
L = length(params.t);
Y = fft(composite_signal_noisy);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f_axis = params.Fs*(0:(L/2))/L;

%% 5. MULTI-PANEL VISUALIZATION
figure('Name', 'AMSS Framework Output', 'Color', [1 1 1], 'Position', [100 100 1000 700]);

% Subplot 1: Time Domain Signal
subplot(2,1,1);
plot(params.t, composite_signal_noisy, 'Color', [0.6350 0.0780 0.1840], 'LineWidth', 1.2);
hold on;
plot(params.t, composite_signal, 'k--', 'LineWidth', 0.8); % Clean reference
grid on; minorgrid on;
title(['\fontsize{14}Time Domain Analysis: Composite Waveform']);
xlabel('Time (seconds)'); ylabel('Amplitude');
legend(['Noisy Signal (Varun Goyal 102315115)'], 'Pure Signal');

% Subplot 2: Frequency Domain (Magnitude Spectrum)
subplot(2,1,2);
stem(f_axis, P1, 'Color', [0 0.4470 0.7410], 'MarkerFaceColor', 'flat');
grid on;
xlim([0 max(f_axis)/4]); % Zooming into relevant range
title('\fontsize{14}Frequency Domain Analysis: Power Spectrum');
xlabel('Frequency (Hz)'); ylabel('|P1(f)|');

%% 6. ANALYTICS REPORT
fprintf('\n--- Signal Analytics Report ---\n');
fprintf('Root Mean Square (RMS): %.4f\n', rms(composite_signal_noisy));
fprintf('Peak-to-Peak Amplitude: %.4f\n', peak2peak(composite_signal_noisy));
fprintf('Sampling Rate: %d Hz\n', params.Fs);
fprintf('Report generated for: Varun Goyal (102315115)\n');
