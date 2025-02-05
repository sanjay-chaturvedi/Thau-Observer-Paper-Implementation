%{
    Author: Sanjay Chaturvedi
    
    Implemented examples given in following paper. 
    "Observing the state of non-linear dynamics systems, F.E. Thau, 1973"

    Feel free to use and share this code.
%}

%% clean everything
clear all; 
close all; 
clc; 

%% using ODE solver for calculating states
% time span
t_start = 0;
t_end = 0.01*800; % simulation for 8 seconds

%% state vector X1 combines system(x) and observer(z) states
X1_init = [1;1;0;0];

% Case 1 section 3
[tx,X1] = ode45(@system1,[t_start t_end],X1_init);

x = X1(:,1:2);
z = X1(:,3:4);

figure(1)
plot(z(:,1),z(:,2),'LineWidth',1.5); hold on;
plot(x(:,1),x(:,2),'LineWidth',1.5);
plot(x(1,1),x(1,2),'-*','LineWidth',2);
legend('observer state','system state')
title('Case 1');
xlabel('z1, x1'); ylabel('z2, x2');
grid on; hold off;

%% state vector X2 combines system(x) and observer(z) states
X2_init = [0.5;0.5;0;0];

% Case 2 section 3
[tx,X2] = ode45(@system2,[t_start t_end],X2_init);

x = X2(:,1:2);
z = X2(:,3:4);

figure(2)
plot(z(:,1),z(:,2),'LineWidth',1.5); hold on;
plot(x(:,1),x(:,2),'LineWidth',1.5);
plot(x(1,1),x(1,2),'-*','LineWidth',2);
legend('observer state','system state')
title('Case 2');
xlabel('z1, x1'); ylabel('z2, x2');
grid on; hold off;
axis([-1, 1, -1, 1]);

figure(3)
plot(tx,z(:,2),'LineWidth',1.5); hold on;
plot(tx,x(:,2),'LineWidth',1.5);
plot(tx(1,1),x(1,2),'-*','LineWidth',2);
legend('z2','x2')
title('Case 2: x2 and z2 Vs Time');
grid on; hold off;
axis([0, 2, -0.8, 0.8]);

%% Section 3, Examples, Case 1
function [X_dot] = system1(t,X)

% breaking vector X
x = X(1:2,1); x1 = x(1); x2 = x(2);
z = X(3:4,1); z1 = z(1); z2 = z(2);
a = 1;

% measurements
y = x1;

% system state
x1_dot = x2;
x2_dot = -a*x2*abs(x2);
x_dot = [x1_dot;x2_dot];

% state reconstructor
z1_dot = -20*z1 + z2 + 20*y;
z2_dot = -100*z1 - a*z2*abs(z2) + 100*y;
z_dot = [z1_dot;z2_dot];

% final output vector
X_dot = [x_dot;z_dot];

end

%% Section 3, Examples, Case 2
function [X_dot] = system2(t,X)

% breaking vector X
x = X(1:2,1); x1 = x(1); x2 = x(2);
z = X(3:4,1); z1 = z(1); z2 = z(2);

% measurements
y = x1;

% system state
x1_dot = x2*x1^2 + x2;
x2_dot = -(x1)^3 - x1;
x_dot = [x1_dot;x2_dot];

% state reconstructor
z1_dot = -5*z1 + z2 + 5*y + (z1^2)*z2;
z2_dot = -11*z1 - z1^3 + 10*y; 
z_dot = [z1_dot;z2_dot];

% final output vector
X_dot = [x_dot;z_dot];

end