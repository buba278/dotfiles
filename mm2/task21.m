%% Task 2.1 UPI: cmot464 ID: 513090963
clearvars
close all

tspan = 0:0.1:12; % in months
Y0 = [3000 50 2 0 0];

[T, Y] = ode45(@ode_eqs,tspan,Y0);

hold("on")
plot(T,Y(:,3),'linewidth',1,'color','g')
plot(T,Y(:,5),'linewidth',1,'color','k')

xlabel('Time t (months)','fontsize',12)
ylabel('Population I and D (people)','fontsize',12)
title('Infected and Deceased population vs Time','fontsize',12)
legend("Infected population, I", "Deceased population, D")

% System of equations
function derivative = ode_eqs(t, y)
    %init the vector
    derivative = zeros(5,1);

    [S, E, I, R, D] = deal(y(1), y(2), y(3), y(4), y(5));

    beta = 8.9;
    gamma = 0.4;
    sigma = 0.5;
    mew = 0.8;
    v = 0;
    N = S + E + I + R;

    %just labelling to not get confused
    dSdt = (-beta * ((S * I) / N)) - (v * S);
    dEdt = (beta * ((S * I) / N)) - (sigma * E);
    dIdt = (sigma * E) - (mew + gamma) * I;
    dRdt = (gamma * I) + (v * S);
    dDdt = mew * I;

    derivative(1,1) = dSdt;
    derivative(2,1) = dEdt;
    derivative(3,1) = dIdt;
    derivative(4,1) = dRdt;
    derivative(5,1) = dDdt;

end