% Aim - Compute circular convolution without using direct command and also
%       compute linear convolution using circular convolution
% Name: Varun
% Roll No: 102315115

clc; clear; close all;

% ----- User Input -----
x = input('Enter first sequence x[n]: ');
h = input('Enter second sequence h[n]: ');

% ===================== (a) Circular Convolution =====================
N = max(length(x), length(h));    % Length for circular convolution

% Zero-pad both sequences to length N
x_circ = [x, zeros(1, N - length(x))];
h_circ = [h, zeros(1, N - length(h))];

circ_conv = zeros(1, N);

% Circular convolution formula
for n = 1:N
    for k = 1:N
        m = mod(n-k, N);          % modulo index
        if m == 0, m = N; end
        circ_conv(n) = circ_conv(n) + x_circ(k) * h_circ(m);
    end
end

disp('Circular Convolution Result:');
disp(circ_conv);

figure;
stem(0:N-1, circ_conv, 'filled');
title('Circular Convolution Result - Varun (Roll No: 102315115)');
xlabel('n'); ylabel('y_c[n]');
grid on;

% ===================== (b) Linear Convolution via Circular =====================
L = length(x);
M = length(h);
N_lin = L + M - 1;   % Length of linear convolution

% Zero-pad both sequences to length N_lin
x_lin = [x, zeros(1, N_lin - L)];
h_lin = [h, zeros(1, N_lin - M)];

lin_conv = zeros(1, N_lin);

% Perform circular convolution of length N_lin (this equals linear conv)
for n = 1:N_lin
    for k = 1:N_lin
        m = mod(n-k, N_lin);
        if m == 0, m = N_lin; end
        lin_conv(n) = lin_conv(n) + x_lin(k) * h_lin(m);
    end
end

disp('Linear Convolution Result (using Circular Convolution):');
disp(lin_conv);

figure;
stem(0:N_lin-1, lin_conv, 'filled');
title('Linear Convolution Result (via Circular Convolution) - Varun (Roll No: 102315115)');
xlabel('n'); ylabel('y_l[n]');
grid on;
