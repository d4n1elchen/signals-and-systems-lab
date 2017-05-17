clear; clc;

[src, fs] = audioread('1.wav');
gain = [5.2, .5, 1.3, 1, .2, 1.3];
n = 3;
Wn = {.05, [.05 .2], [.2 .3], [.3 .4], [.4 .5], .5};
ftype = {'low','bandpass','bandpass','bandpass','bandpass','high'};
y = zeros(size(src));
for i=1:6
    [b, a] = butter(n,Wn{i},ftype{i});
    y = y + gain(i)*filter(b, a, src);
end
audiowrite('1_eq.wav', y, fs);