clearvars
close all

tspan = 0:0.1:12;
Y0 = [3000 50 2 0 0];

[T, Y] = ode45(@ode_eq,tspan,Y0);

hold("on")
plot(T,Y(:,3))
plot(T,Y(:,5))
title("I & D vs Time");
xlabel("Time, t (Months)");
ylabel("Population, I & D (People)")
legend("I", "D")

[M, I] = max(Y(:, 3));
B = T(I);

function dy = ode_eq(t,y)
    % initialise dy vector
    dy = zeros(5,1);

    beta = 8.9;
    gamma = 0.4;
    sigma = 0.5;
    mu = 0.8;
    nu = 0;

    S = y(1);
    E = y(2);
    I = y(3);
    R = y(4);
    % D = y(5);

    N = S + E + I + R;

    dy(1,1) = -beta * ((S*I)/N) - nu * S;
    dy(2,1) = beta * ((S*I)/N) - sigma * E;
    dy(3,1) = sigma * E - (mu + gamma) * I;
    dy(4,1) = gamma * I + nu * S;
    dy(5,1) = mu * I;
end