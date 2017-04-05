clc; clear;

[src, fs] = audioread('clean.wav');

plot(src);
hold on;
src = arrayfun(@(x) x*sin(x*2*pi), src);
plot(src);
audiowrite('distortion.wav',src,fs);