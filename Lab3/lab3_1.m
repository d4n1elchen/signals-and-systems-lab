clc; clear;

[src, fs] = audioread('clean.wav');

upperbound = 0.5 * max(src);
lowerbound = -0.5 * max(src);
plot(src);
hold on;
src(src > upperbound) = upperbound;
src(src < lowerbound) = lowerbound;
plot(src);
audiowrite('distortion.wav',src,fs);