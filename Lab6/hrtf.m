% radius (cm)
function [L, R] = hrtf(src, Fs, sourceRadius, headRadius, angle, elevationAngle)
rad = pi/180;
elevationRad = elevationAngle*rad;
rightRad = angle*rad;
leftRad = (180-angle)*rad;
rightDist = sqrt( (sourceRadius*sin(elevationRad))^2 +  ...
                  (headRadius^2 + (sourceRadius*cos(elevationRad))^2 - 2*headRadius*(sourceRadius*cos(elevationRad))*cos(rightRad)) );
leftDist  = sqrt( (sourceRadius*sin(elevationRad))^2 + ...
                  (headRadius^2 + (sourceRadius*cos(elevationRad))^2 - 2*headRadius*(sourceRadius*cos(elevationRad))*cos(leftRad)) );
diff = rightDist-leftDist;
disp(diff);
diffSampleNum = round(abs(diff)/34000*Fs); % sound speed = 34000cm/s
disp(diffSampleNum);
near = src;
far = shift(src, diffSampleNum);
if(diff>0) % R>L
    R = far;
    L = near;
elseif(diff<0) % R<L
    R = near;
    L = far;
else % R=L
    R = src;
    L = src;
end
end