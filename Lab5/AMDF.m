function amdf=AMDF(src, fs, framesize)
    sz = size(src, 1);  
    
    % Params
    n = framesize;
    startFrame = 1;
    frameNum = floor(sz/n);

    amdf = zeros(frameNum, 1);

    for f=startFrame:frameNum-1
        start = (f-1)*n+1;
        Frame = src(start:start+n);
        tAmdf = ones(n, 1)*99999;
        for t=10:n
            ShiftFrame = src(start+t:start+n+t);
            tAmdf(t) = sum(abs(Frame(1:n-1-t)-ShiftFrame(1:n-1-t)));
        end
        if f==8
            figure;
            plot(tAmdf(10:end));
            break;
        end
        [~,i] = min(tAmdf);
        amdf(f) = fs/i;
    end
end