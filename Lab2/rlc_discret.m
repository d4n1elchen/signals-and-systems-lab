function [Vc_n_2, Vc_n_1] = rlc_discret(Vc_n_1, Vc_n, d)
    V = 1.0;
    R = 2.0;
    L = 100.0e-9;
    C = 1.0e-9;
    Vc_n_2 = d*d/(L*C) * (V-Vc_n-R*C/d*(Vc_n_1-Vc_n)) + 2*Vc_n_1 - Vc_n;
end