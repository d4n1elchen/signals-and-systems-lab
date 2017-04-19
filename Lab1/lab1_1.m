clc; clear;

src = [];
for i=0:3
    [y, fs] = audioread(['track', num2str(i), '.wav']);
    src = [src y];
end

t = [0, 1, 13, 20];
l = [0.55, 0.6, 0.3, 0.3];
r = [0.4, 0.8, 0.5, 0.4];

sz = size(src, 1);
left = zeros(sz, 1);
right = zeros(sz, 1);

for i=1:4
    n = t(i)*fs;
    src(:, i) = [zeros(n, 1); src(1:end-n, i)]; % shift
    left = left + src(:, i) * l(i);             % left amp
    right = right + src(:, i) * r(i);           % right amp
end

audiowrite('mixed.wav',[left right],fs);