clc; clear;

% Reading source file
[src, fs] = audioread('01-1.wav');

acf = ACF(src, fs, 1024);
amdf = AMDF(src, fs, 1024);
