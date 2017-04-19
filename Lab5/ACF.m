function acf=ACF(src, fs, framesize)
    sz = size(src, 1);  
    
    % Params
    n = framesize;
    startFrame = 1;
    frameNum = floor(sz/n);

    acf = zeros(frameNum, 1);

    for f=startFrame:frameNum-1
        start = (f-1)*n+1;
        Frame = src(start:start+n);
        tAcf = zeros(n, 1);
        for t=10:n
            ShiftFrame = src(start+t:start+n+t);
            tAcf(t) = dot(Frame(1:n-1-t), ShiftFrame(1:n-1-t));
        end
        if f==8
            figure;
            plot(tAcf(10:end));
            break;
        end
        [~,i] = max(tAcf);
        acf(f) = fs/i;
    end
end