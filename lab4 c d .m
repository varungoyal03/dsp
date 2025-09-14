% Aim:
%   (c) Compute circular convolution using linear convolution 
%       and verify with result obtained in (a).
%   (d) Compute circular convolution using DFT-IDFT method.
% Name: Varun
% Roll No: 102315115

clc; clear; close all;

% ----- User Input -----
x = input('Enter first sequence x[n]: ');
h = input('Enter second sequence h[n]: ');

N = max(length(x), length(h));

%% ===================== (c) Circular Convolution via Linear Convolution =====================
% Linear convolution
lin_full = conv(x, h);

% Wrap linear conv result into N samples (modulo-N)
circ_conv_lin = zeros(1, N);
for i = 1:length(lin_full)
    idx = mod(i-1, N) + 1;
    circ_conv_lin(idx) = circ_conv_lin(idx) + lin_full(i);
end

disp('Circular Convolution (from Linear Convolution):');
disp(circ_conv_lin);

figure;
stem(0:N-1, circ_conv_lin, 'filled');
title('Circular Convolution via Linear Convolution - Varun (Roll No: 102315115)');
xlabel('n'); ylabel('y_c[n]');
grid on;

%% ===================== (d) Circular Convolution via DFT-IDFT =====================
% Zero-pad both to length N
x_circ = [x, zeros(1, N - length(x))];
h_circ = [h, zeros(1, N - length(h))];

% Compute DFTs
X = fft(x_circ, N);
H = fft(h_circ, N);

% Multiply in frequency domain
Y = X .* H;

% IDFT -> Circular convolution
circ_conv_dft = ifft(Y);

disp('Circular Convolution (DFT-IDFT):');
disp(real(circ_conv_dft));

figure;
stem(0:N-1, real(circ_conv_dft), 'filled');
title('Circular Convolution via DFT-IDFT - Varun (Roll No: 102315115)');
xlabel('n'); ylabel('y_c[n]');
grid on;
