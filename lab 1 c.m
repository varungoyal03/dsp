clc; clear; close all;

disp('=== Advanced Composite Signal Generator ===');

% 1. Robust User Input
N = input('Enter the number of sinusoids: ');
if isempty(N) || N <= 0 || mod(N,1) ~= 0
    error('Number of sinusoids must be a positive integer.');
end

% Preallocate parameter arrays for efficiency
A   = zeros(N, 1);
f   = zeros(N, 1);
phi = zeros(N, 1);

disp('Enter parameters for each sinusoid:');
for k = 1:N
    A(k)   = input(sprintf('  Amplitude of sinusoid %d: ', k));
    f(k)   = input(sprintf('  Frequency of sinusoid %d (Hz): ', k));
    phi(k) = input(sprintf('  Phase (in degrees) of sinusoid %d: ', k));
end

% 2. Adaptive Sampling Frequency
% Ensures Nyquist criterion is heavily satisfied (prevents aliasing for high frequencies)
Fs = max(max(f) * 20, 1000); 
t = 0:1/Fs:1; % 1 second duration

% 3. Vectorized Signal Generation
% Replaces the traditional 'for' loop with matrix broadcasting for maximum performance
phase_rad = deg2rad(phi);
% f is Nx1, t is 1xL -> f*t is an NxL matrix. 
% This calculates all sinusoids simultaneously.
signal_matrix = A .* sin(2 * pi * f * t + phase_rad); 
signal = sum(signal_matrix, 1); % Sum along the columns to get the 1xL composite signal

% 4. Frequency Domain Analysis (Fast Fourier Transform)
L = length(signal);
Y = fft(signal);
P2 = abs(Y / L);               % Two-sided spectrum
P1 = P2(1:floor(L/2)+1);       % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);   % Double amplitude (excluding DC and Nyquist)
f_fft = Fs * (0:(L/2)) / L;    % Frequency vector for X-axis

% 5. Advanced Visualization
figure('Name', 'Advanced Signal Analysis', 'Color', 'w', 'Position', [100, 100, 900, 600]);

% --- Time Domain Plot ---
subplot(2, 1, 1);
plot(t, signal, 'm', 'LineWidth', 1.5);
hold on;
% Lightly overlay the individual sinusoids in the background if N isn't too large
if N <= 5 
    plot(t, signal_matrix, '--', 'LineWidth', 0.8, 'Color', [0.6 0.6 0.6 0.5]);
end
grid on;
title('Time Domain: Composite Sinusoidal Signal', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (s)'); 
ylabel('Amplitude');
legend('Composite Signal (Varun Goyal 102315115)', 'Location', 'best');

% Smart Zoom: Zoom in to show a few cycles of the lowest non-zero frequency
if any(f > 0)
    xlim([0, min(1, 5/min(f(f>0)))]); 
end

% --- Frequency Domain Plot (FFT Spectrum) ---
subplot(2, 1, 2);
stem(f_fft, P1, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
grid on;
title('Frequency Domain: Single-Sided Amplitude Spectrum', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Frequency (Hz)'); 
ylabel('|P(f)| (Amplitude)');
% Smart Zoom: Scale x-axis to 1.5x the maximum input frequency
if max(f) > 0
    xlim([0, max(f) * 1.5]); 
end
