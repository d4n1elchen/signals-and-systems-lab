clc; clear;

[src, fs] = audioread('clean.wav');

a = 0.3;
upperbound = 0.6 * max(src);
lowerbound = -0.6 * max(src);
plot(src);
hold on;
src(src > upperbound) = upperbound + a * (src(src > upperbound)-upperbound);
src(src < lowerbound) = lowerbound + a * (src(src < lowerbound)-lowerbound);
plot(src);
audiowrite('distortion.wav',src,fs);