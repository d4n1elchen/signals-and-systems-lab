function output = reverb( input, N, cycle )
    sz = size(input, 1);
    output = zeros(sz+cycle*N, 1);
    x = zeros(sz+cycle*N, 1);
    % init input
    x(1:sz, 1) = input;
    % do cycles
    for i=1:cycle
        x1 = [zeros(N, 1); x(1:end-N)];
        x2 = [0; x1(1:end-1)];
        output = output + x2;
        x = x1/2 + x2/2;
    end
end

