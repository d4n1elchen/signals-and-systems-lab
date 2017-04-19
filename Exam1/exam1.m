clc; clear;

% 1
%in = random('Normal',-6666,6666,6666,1);
% reverb(input, N, cycle)
out = reverb([18], 300, 1000);
save('exam1', 'out');

audiowrite('exam1.wav', out, 44100);