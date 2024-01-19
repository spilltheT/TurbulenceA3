clear, clc

H_T = 100; % [m]
D = 100; % [m]
C_T = 0.75; % [-]
S_x = 785; % [m]
S_y = 524; % [m]
z_lo = 0.1; % [m]
kappa = 0.4; % [-]

A = pi*D^2/4; % [m2]
cft = (C_T*A)/(S_x*S_y); % [-]
nu = 28*sqrt(0.5*cft); % [?]

%% Layer 1
z = linspace(0,50,51);
u_1 = (1/kappa)*log(z/z_lo);
figure(1)
plot(u_1,z,LineWidth=2,Color="#0072BD")

%% Layer 2, Low
z = linspace(50,100,51);
u_2_lo = (1/kappa)*log(((H_T-D/2)^(nu/(nu+1))*z.^(1/(1+nu)))/(z_lo));

hold on
plot(u_2_lo,z,LineWidth=2,Color="#D95319");
hold off

%% Layer 2, High
z = linspace(100,150,51);

u_hi_star = sqrt(1^2+0.5*cft*u_2_lo(51)^2);
z_hi = exp(log((H_T+D/2)^(nu/(1+nu))*H_T^(1/(1+nu)))-(1/u_hi_star)*(log((H_T-D/2)^(nu/(1+nu))*H_T^(1/(1+nu)))-log(z_lo)));
u_2_hi = (u_hi_star/kappa)*log(((H_T+D/2)^(nu/(nu+1))*z.^(1/(1+nu)))/(z_hi));

hold on
plot(u_2_hi,z,LineWidth=2,Color="#D95319");
hold off

%% Layer 3
z = linspace(150,1000,851);

a = u_hi_star/kappa;
c = a*log((H_T+D/2)^(nu/(1+nu))*H_T^(1/(1+nu)));
d = (1/kappa)*(log((H_T-D/2)^(nu/(1+nu))*H_T^(1/(1+nu)))-log(z_lo));
z_hi = exp((c-d)/a);

u_3 = (u_hi_star/kappa)*log(z/z_hi);

hold on
plot(u_3,z,LineWidth=2,Color="#77AC30")
xlabel("u(z) [u^*_{lo}]"), ylabel("z [m]")
hold off
