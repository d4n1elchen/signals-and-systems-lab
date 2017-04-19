clc; clear;

[src, fs] = audioread('2-1.wav');

% setting
channel = 3;
cycle = 5;
delay = 4410*.3;
sz = size(src,1);

% params
b = [1; 1; 1];
g = [.3; .3; .3];
M = [1; 5; 10];
c = [.3; .09; .027];
q = [.5 .6 .7;
    .3 .4 .5;
    .2 .3 .4];
d = .3;

% init result with src
y = zeros(sz+delay*max(M)*cycle, 1);
y(1:sz) = src;

% init x_f with src*b
x_f = zeros(sz+delay*max(M)*cycle, channel);
for i=1:channel
    x_f(1:sz, i) = src*b(i);
end

% init x with zeros
x = zeros(sz+delay*max(M), channel);

% loops
for k=1:cycle
    x = x_f + x*q*g;
    for i=1:channel
        shift = M(i)*delay;
        x(:, i) = [zeros(shift, 1); x(1:end-shift, i)];
        y = y + x(:, i)*c(i);
    end
end

% save result
audiowrite('re.wav',y,fs);

