% Nonlinear MPC for Regenerative Active Suspension Control
% Authors: Aidan Aalund and Zejiang Wang
% Description: run this script to initialize and run the associated .slx
% file titled NMPC_RAS.slx. Associated functions are in customfxnmodelbased folder.
% Using MPC Toolbox and Optimization toolbox, reference the Nonlinear MPC
% documentation to learn more, or email me!

%% Load parameters and SLX model definitions
initparams;
HcMB = 1; % control horizon parameter for this controller only
%% cost function weights (best performance @ Q_n = _, Q_ndot = _, R = _, E = _)
Q_n = 10000;
Q_ndot = 100;
R = 10; 
E = 1; % energy not tuned well yet

%% NMPC settings, weights, and constraints 
nx = 4; % [z1,z1_dot,z2,z2_dot]^T
ny = 2; % [eta,eta_dot]^T
nu = 1; % [Fc]
nmpcobj = nlmpc(nx,ny,nu);
nmpcobj.Ts = Ts;
nmpcobj.PredictionHorizon = 20;
nmpcobj.ControlHorizon = HcMB;

% How plant states evolve over time. State space model is DT.
nmpcobj.Model.StateFcn = "stateFunctionStateSpaceCT";
nmpcobj.Model.IsContinuousTime = true;
nmpcobj.Model.NumberOfParameters = 20;
nmpcobj.Model.OutputFcn = "outputFunctionStateSpace";

% Set up custom cost function
nmpcobj.Optimization.CustomCostFcn = "costFunctionMB";
% Ignore built in cost function
nmpcobj.Optimization.ReplaceStandardCost = true;
% Equality and Inequality Constraints
% Optimization.CustomEqConFcn = "eqConFunctionMB";
% fmincon holds the U constant after Hc
nmpcobj.Optimization.CustomIneqConFcn = "ineqConFunctionMB";

% % Solver options: 'sqp' (default for NMPC), 'interior-point' (default for
% % fmincon), 'trust-region-reflective', 'active-set'
% nmpcobj.Optimization.SolverOptions.Algorithm = 'sqp'; % put alternate
% % solver here, sqp is the default
% nmpcobj.Optimization.SolverOptions.MaxIters = 400; % default is 400, 1000
% % if using interior-point. Lower to speedup performance.
% nmpcobj.Optimization.SolverOptions.ObjectiveLimit = -1e20; % once this
% % value is hit for J, it is good enough and do not iterate more. Raise to
% % speedup performance.

%% WARNING: EVERY TIME THIS IS EDITED, YOU NEED TO EDIT ALL OTHER FUNCTIONS WITH PARAMS...
parameters = {ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min};
size(parameters)
% Set up parameter bus for NMPC object (if it isn't already initialized)
mdl = 'NMPC_RAS';
if exist('paramBusMB','var')==0
    open_system(mdl)
    createParameterBus(nmpcobj,[mdl '/NMPC'],'paramBusMB',parameters);
end

%% Now the NLMPC and simulation parameters are ready to go! 
%% Run the simulation or optionally validate the NMPC functions here in MATLAB.
% validateFcns(nmpcobj,rand(nx,1),rand(nu,1),[],parameters,[0.02,0]);
sim(mdl);