
clearvars
close all

tspan = 0:0.1:12; % in months
Y0 = [3000 50 2 0 0];

[T, Y] = ode45(@ode_eq,tspan,Y0);

hold("on")
plot(T,Y(:,3),'linewidth',1,'color','k')
plot(T,Y(:,5),'linewidth',1,'color','k')

set(gca,'fontsize', 12)
xlabel('t','fontsize',12)
ylabel('i d','fontsize',12)
title('y vs t','fontsize',12)
% legend()

function dy = ode_eq(t,y)
    % initialise dy vector
    dy = zeros(5,1);

    S = y(1);
    E = y(2);
    I = y(3);
    R = y(4);
    % D = y(5);

    beta = 8.9;
    gamma = 0.4;
    sigma = 0.5;
    mew = 0.8;
    v = 0;
    N = S + E + I + R;

    dy(1,1) = (-beta * ((S * I) / N)) - (v * S);
    dy(2,1) = (beta ((S * I) / N)) - (sigma * E);
    dy(3,1) = (sigma * E) - (mew + gamma) * I;
    dy(4,1) = (gamma * I) + (v * S);
    dy(5,1) = mew * I;
end
