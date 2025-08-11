% Plots for NULMPC Paper
% Authors: Aidan Aalund and Zejiang Wang
% Description: script used by nulmpc.m and nmpc.m to initialize variables
% for use in Simulink. Edit them here to programatically change things.

%% sample time
Ts = 0.01;
%% spring coefficients (nominal)
ks = 900;% or 1040 Suspension Stiffness (N/m) 
kt = 2500;% or 2300
kus = kt;% Tire stiffness (N/m)
ms = 2.45;% or 2.5 Sprung Mass (kg) 
mu = 1;% or 1.150
mus = mu;% Unsprung Mass (kg)
bs = 7.5;% Suspension Inherent Damping coefficient (sec/m)
bus = 5;% Tire Inhenrent Damping coefficient (sec/m)
%% physical constraints
% maximum forces (currently +/- 15) (units: N)
Fc_max = 15;
Fc_min = -15;
% maximum rate of change in forces (units: N/Ts) (at Ts = 0.01 this is 10)
delta_Fc_max = 1000*Ts;
delta_Fc_min =-1000*Ts;
% maximum displacement of the spacing (units: m)
n_max = 0.05;
n_min = -0.05;
%% misc. params
Hc = 1; % used in ultra-local ONLY
%% dummy variable parameters (only used to tell MPC toolbox to expect these variables later on as signals)
eta_ddot = 0; 
Fc_last = 0;
zr = 0;
zr_dot = 0;
%% initial conditions
z1_init = 0.005;
z1_dot_init = 0;
z2_init = 0;
z2_dot_init = 0;