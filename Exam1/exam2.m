clc; clear;

% 2
load('exam1');

figure;
plot(out);

% finPitch(algorithm, input, framesize, start_frame, end_frame, plot_frame)
% ACF only for algorithm
out = findPitch('ACF', out, 5000, 50, 55, 52);

figure;
plot(out);