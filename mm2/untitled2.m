% Task 2
clearvars
close all

tspan = 0:0.1:12; % in months
Y0 = [3000 50 2 0 0];

[T, Y] = ode45(@ode_eqs,tspan,Y0);

plot(T,Y(:,1),'linewidth',1,'color','k')
set(gca,'fontsize', 12)
xlabel('t','fontsize',12)
ylabel('y','fontsize',12)
title('y vs t','fontsize',12)

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

    % derivative(1,1) = (-beta * ((S * I) / N)) - (v * S);
    % derivative(2,1) = (beta ((S * I) / N)) - (sigma * E);
    % derivative(3,1) = (sigma * E) - (mew + gamma) * I;
    % derivative(4,1) = (gamma * I) + (v * S);
    % derivative(5,1) = mew * I;

end