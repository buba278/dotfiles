%% Task 1.5 UPI: cmot464 ID: 513090963

clearvars
close all

tspan = 0:1:200; % in hours
r = 0.1; % viral clearance rate /hr
V = (80 .* exp(-0.5 .* r .* tspan)) + (40 .* r .* tspan .* exp(-0.5 .* r .* tspan));

plot(tspan,V);
title("Viral Load vs Time");
xlabel("Time t (hours)");
ylabel("Viral Load V (UI/mL)")
