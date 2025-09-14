clc;
clear;
close all;

% ------------------------------------------------------------
% Name : Varun
% Roll No : 102315115
% --- (a) Input sequence from user ---
x = input('Enter the input sequence (e.g., [1 2 3 4]): ');
N = input('Enter the number of DFT points N: ');   % User chooses N

L = length(x);   % Length of original sequence

% --- Check for valid N ---
if N < L
    error('N must be greater than or equal to the length of x(n)');
end

% --- Zero padding if N > L ---
x_padded = [x zeros(1, N - L)];

% --- (a) Compute DFT without fft() ---
X = zeros(1,N);   % Initialize DFT result
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x_padded(n+1)*exp(-1j*2*pi*k*n/N);
    end
end

% --- Plot magnitude and phase spectrum ---
k = 0:N-1;
figure;
sgtitle('DFT Analysis (Manual) - Varun, Roll No: 102315115','FontWeight','bold');

subplot(2,1,1);
stem(k, abs(X), 'filled');
title('Magnitude Spectrum of X[k]');
xlabel('k'); ylabel('|X[k]|');

subplot(2,1,2);
stem(k, angle(X), 'filled');
title('Phase Spectrum of X[k]');
xlabel('k'); ylabel('∠X[k] (radians)');

% --- (b) Compute IDFT ---
x_reconstructed = zeros(1,N);
for n = 0:N-1
    for k = 0:N-1
        x_reconstructed(n+1) = x_reconstructed(n+1) + X(k+1)*exp(1j*2*pi*k*n/N);
    end
    x_reconstructed(n+1) = x_reconstructed(n+1)/N;
end

% --- Display results ---
disp('Original sequence:');
disp(x);

disp('Reconstructed sequence from IDFT:');
disp(real(x_reconstructed(1:L))); % Show only first L values

% --- Compare Original vs Reconstructed ---
figure;
sgtitle('Original vs Reconstructed Signal - Varun, Roll No: 102315115','FontWeight','bold');

subplot(2,1,1);
stem(0:L-1, x, 'filled');
title('Original Input x(n)');
xlabel('n'); ylabel('x(n)');

subplot(2,1,2);
stem(0:L-1, real(x_reconstructed(1:L)), 'filled');
title('Reconstructed x(n) from IDFT');
xlabel('n'); ylabel('x_{reconstructed}(n)');
