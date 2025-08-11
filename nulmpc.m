% Nonlinear Ultra-Local MPC for Regenerative Active Suspension Control
% Authors: Aidan Aalund and Zejiang Wang
% Description: run this script to initialize and run the associated .slx
% file titled NULMPC_RAS.slx. Associated functions are in customfxnUL folder.
% Using MPC Toolbox and Optimization toolbox, reference the Nonlinear MPC
% documentation to learn more, or email me!

%% Load parameters and SLX model definitions
initparams;
%% cost function weights & tuning 
%% (best perf @ alpha = 1/ms + 1/mu, Q_n = 2500, Q_ndot = 100, R = 300, E = 100)
%% without noise: alpha = "", Q=1000, Q_dot=50, R=100, E = 0
%% alt: "",100,3,2,1
%% with ADE cheating: "",1000,5,10,5
alpha_o = 1/(ms) + 1/(mu); % = 1.41, likely near the best possible
Q_n = 1000;
Q_ndot = 5; % fix this
R = 10; 
E = 5; % a value of 100 vs 1 seems to actually impact generation in a positive way.
% positive spikes are lowered and negatives increase. Just can't let it
% overpower the trac

%% NMPC settings, weights, and constraints
nx = 2; % [eta,eta_dot]^T
ny = nx; % same as states
nu = 1; % [delta_Fc]
nulmpcobj = nlmpc(nx,ny,nu);
nulmpcobj.Ts = Ts;
nulmpcobj.PredictionHorizon = 20; 
nulmpcobj.ControlHorizon = Hc;

% How plant states evolve over time. UL model is DT.
nulmpcobj.Model.StateFcn = "stateFunction";
nulmpcobj.Model.IsContinuousTime = false;
nulmpcobj.Model.NumberOfParameters = 15;
% how state dynamics work (just passes through all states as outputs at the
% moment)
nulmpcobj.Model.OutputFcn = "outputFunction";

% Cost Function
nulmpcobj.Optimization.CustomCostFcn = "costFunctionEnergy";
nulmpcobj.Optimization.ReplaceStandardCost = true; % turns off built-in cost fxn
% Constraints
% nulmpcobj.Optimization.CustomEqConFcn = "eqConFunction"; % I'm pretty
% sure this is broken
nulmpcobj.Optimization.CustomIneqConFcn = "ineqConFunction";

%% WARNING: EVERY TIME 'PARAMETERS' IS EDITED, YOU NEED TO ADD THE NEW VARIABLES TO ALL OTHER FUNCTIONS THAT USE IT
parameters = {alpha_o,eta_ddot,Q_n,Q_ndot,R,E,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min,Ts,Fc_last,Hc};
% Set up parameter bus for NMPC object (if it isn't already initialized)
mdl = 'NULMPC_RAS';
if exist('paramBus','var')==0
    open_system(mdl)
    createParameterBus(nulmpcobj,[mdl '/NULMPC'],'paramBus',parameters);
end

%% Now the NULMPC and simulation parameters are ready to go! 
%% Run the simulation or optionally validate the NMPC functions here in MATLAB.
% validateFcns(nulmpcobj,rand(nx,1),rUand(nu,1),[],parameters);
sim(mdl);