clc; clear;

src = [];
for i=0:3
    [y, fs] = audioread(['track', num2str(i), '.wav']);
    src = [src y];
end

t = [0, 1, 13, 20];
l = [-3, -3, -6, -5];
r = [-5, -2, -4, -5];

sz = size(src);
left = zeros(sz(1), 1);
right = zeros(sz(1), 1);

for i=1:4
    n = t(i)*fs;
    src(:, i) = [zeros(n, 1); src(1:end-n, i)];
    left = left + src(:, i) * 10^(l(i)/20);
    right = right + src(:, i) * 10^(r(i)/20);
end

audiowrite('mixed.wav',[left right],fs);