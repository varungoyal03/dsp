% Linear convolution without using inbuilt conv()

% VARUN GOYAL
% 102315115

% Input sequences
x = input('Enter the first sequence x[n]: ');
h = input('Enter the second sequence h[n]: ');

% Length of sequences
N = length(x);
M = length(h);

% Length of output sequence
L = N + M - 1;

% Zero-padding
x = [x, zeros(1, M-1)];
h = [h, zeros(1, N-1)];

% Initialize result
y = zeros(1, L);

% Convolution process
for n = 1:L
    for k = 1:N
        if (n-k+1 > 0)
            y(n) = y(n) + x(k) * h(n-k+1);
        end
    end
end

% Display output
disp('Linear Convolution result y[n]: ');
disp(y);

% Plotting
subplot(3,1,1);
stem(0:N-1, x(1:N), 'filled');
title('Input Sequence x[n]');
xlabel('n'); ylabel('x[n]');

subplot(3,1,2);
stem(0:M-1, h(1:M), 'filled');
title('Impulse Response h[n]');
xlabel('n'); ylabel('h[n]');

subplot(3,1,3);
stem(0:L-1, y, 'filled');
title('Linear Convolution y[n] - VARUN GOYAL (102315115)');
xlabel('n'); ylabel('y[n]');
