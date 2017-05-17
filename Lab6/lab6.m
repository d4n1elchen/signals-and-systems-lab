% in = random('Normal',-6666,6666,44100*5,1);
% Fs = 44100;
infile = '01-1.wav';
angle = 45;
elevationAngle = 0;
[in, Fs] = audioread(infile);
[L, R] = hrtf(in, Fs, 30000, 8, angle, elevationAngle);

audiowrite([infile, '_hrtf_a', num2str(angle), '_e', num2str(elevationAngle), '.wav'],[L, R], Fs);