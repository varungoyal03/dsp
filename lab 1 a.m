%% (a) Unit Step, Unit Impulse, and Signum Function
n = -10:10;      % time axis

% Unit step
u = double(n >= 0);

% Unit impulse (delta)
d = double(n == 0);

% Signum function
sgn = sign(n);

% Plot
figure;
subplot(3,1,1);
stem(n, u, 'LineWidth',1.5); grid on;
title('Unit Step Function u[n]'); xlabel('n'); ylabel('u[n]');

subplot(3,1,2);
stem(n, d, 'LineWidth',1.5); grid on;
title('Unit Impulse Function \delta[n]'); xlabel('n'); ylabel('\delta[n]');

subplot(3,1,3);
stem(n, sgn, 'LineWidth',1.5); grid on;
title('Signum Function sgn[n]'); xlabel('n'); ylabel('sgn[n]');

sgtitle('Experiment 1 (a) - Varun Goyal, Roll No: 102315115');
