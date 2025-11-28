% Name: Varun Goyal
% Roll No: 102315115
% Down-sampling and Up-sampling Assignment

clear all; close all; clc;

%% ================== USER INPUTS ====================
f1 = input('Enter normalized frequency for first sinusoid (e.g., 0.15): ');
f2 = input('Enter first frequency for second signal (e.g., 0.1): ');
f3 = input('Enter second frequency for second signal (e.g., 0.3): ');

N = 51;                      % Sequence length
n = 0:N-1;                   % Time index

%% ============ (a) Generate the sequences ============
x1 = sin(2*pi*f1*n);                 % First sinusoidal sequence
x2 = sin(2*pi*f2*n) + sin(2*pi*f3*n);% Sum of two sinusoids



%% ============ (b) Down-sampling by factor 4 ============
M1 = 4;
y1 = downsample(x1, M1);      % Down-sampled x1
y2 = downsample(x2, M1);      % Down-sampled x2
L1 = length(y1);
L2 = length(y2);

figure(1);
sgtitle('Down-sampling by 4  |  Varun Goyal 102315115');

subplot(2,2,1);
stem(n, x1); xlabel('n'); ylabel('x1[n]');
title('Original Signal x1[n]');

subplot(2,2,2);
stem(0:L1-1, y1); xlabel('m'); ylabel('y1[m]');
title('Down-sampled x1 (factor 4)');

subplot(2,2,3);
stem(n, x2); xlabel('n'); ylabel('x2[n]');
title('Original Signal x2[n]');

subplot(2,2,4);
stem(0:L2-1, y2); xlabel('m'); ylabel('y2[m]');
title('Down-sampled x2 (factor 4)');


%% ============ (c) Up-sampling by factor 5 ============
M2 = 5;
u1 = upsample(x1, M2);        % Up-sampled x1
u2 = upsample(x2, M2);        % Up-sampled x2
U1 = length(u1);
U2 = length(u2);

figure(2);
sgtitle('Up-sampling by 5  |  Varun Goyal 102315115');

subplot(2,2,1);
stem(n, x1); xlabel('n'); ylabel('x1[n]');
title('Original Signal x1[n]');

subplot(2,2,2);
stem(0:U1-1, u1); xlabel('n'); ylabel('u1[n]');
title('Up-sampled x1 (factor 5)');

subplot(2,2,3);
stem(n, x2); xlabel('n'); ylabel('x2[n]');
title('Original Signal x2[n]');

subplot(2,2,4);
stem(0:U2-1, u2); xlabel('n'); ylabel('u2[n]');
title('Up-sampled x2 (factor 5)');
