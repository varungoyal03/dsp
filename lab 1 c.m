clc; clear; close all;

% User input
N = input('Enter number of sinusoids: ');

Fs = 1000;                % Sampling frequency
t = 0:1/Fs:1;             % 1 second duration

signal = zeros(size(t));

for k = 1:N
    A = input(sprintf('Enter amplitude of sinusoid %d: ', k));
    f = input(sprintf('Enter frequency of sinusoid %d (Hz): ', k));
    phi = input(sprintf('Enter phase (in degrees) of sinusoid %d: ', k));
    
    % Add sinusoid to composite signal
    signal = signal + A * sin(2*pi*f*t + deg2rad(phi));
end

% Plot composite signal
figure;
plot(t, signal, 'm','LineWidth',1.5); grid on;
title('Composite Sinusoidal Signal');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Varun Goyal 102315115')
