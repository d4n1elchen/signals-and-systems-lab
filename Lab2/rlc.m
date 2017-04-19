function dydt = rlc(~,y)
    V = 1.0;
    R = 1.0;
    L = 100.0e-9;
    C = 1.0e-9;
    dydt = [y(2); (V-y(1)-(y(2)*R*C))/(L*C)];
    % y1' = ...
    % y2' = ...
end