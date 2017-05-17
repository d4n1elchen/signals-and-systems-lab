function output = shift(arr, shift)
    output = [zeros(shift,1); arr(1:end-shift)];
end

