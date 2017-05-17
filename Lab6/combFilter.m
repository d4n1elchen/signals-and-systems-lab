function out = combFilter(src, m)
out = src./2 + shift(src./2, m);
end