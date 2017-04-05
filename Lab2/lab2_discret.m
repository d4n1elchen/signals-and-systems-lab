clc; clear;

t = 0.6e-6;
d = 1e-9;
time = 0:d:t;

sz = size(time);
res = zeros(sz);
res(1) = 0;
res(2) = 0;
[Vc_n_1, Vc_n] = rlc_discret(0, 0, d);

for i=3:sz(2)
    [Vc_n_1, Vc_n] = rlc_discret(Vc_n_1, Vc_n, d);
    res(i) = Vc_n_1;
end

plot(time, res);