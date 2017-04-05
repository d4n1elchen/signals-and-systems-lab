clc; clear;

time = linspace(0,0.6e-6,1001);
[t,y] = ode45(@rlc,time,[0; 0]);
plot(t,y(:,1));
xlabel('Time t');
ylabel('Solution Vc');