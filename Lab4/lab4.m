clc; clear;

% Reading source file
[src, fs] = audioread('2-1.wav');
sz = size(src, 1);

% Settings
mul = .1;
cycle = 5;
path = 3;
delay = 44100*mul;

% Params
q = [.5 .6 .7;
    .3 .4 .5;
    .2 .3 .4];
g = [0.2; 0.2; 0.2;];
c = [0.3; 0.09; 0.027];
b = [1 1 1];
d = 0.5;
M = [1 3 5];

% Initialize output signal with direct signal
out = zeros(sz+delay*max(M)*cycle, 1);
out(1:sz,1) = src*d;

% First input signal of z
u = out*b;

% Initialize temp y
y_t = zeros(sz+delay*max(M)*cycle, 3);

% Calc first y_t
for j=1:path
    y_t(:,j) = shift(u(:,j), delay*M(j)); % Shift input by delay*M
end
out = out + y_t*c; % Add to output signal

% Run feedback cycle
for i=1:cycle
    x = u + y_t*q*g; % Add feedback signal to input
    for j=1:path
        y_t(:,j) = shift(x(:,j), delay*M(j));
    end
    out = out + y_t*c;
end

% Save file
audiowrite('reverb.wav',out,fs);
