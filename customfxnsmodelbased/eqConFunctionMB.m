function ceq = eqConFunction(X,U,data,alpha_o,eta_ddot,Q_n,Q_ndot,R,E,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min,Ts,Fc_last,Hc)
    p = data.PredictionHorizon; % Hp = 20
    % Hc = 1 
    U1 = U(Hc+1:p,data.MVIndex(1));
    % delta u == 0 starting after Hc and through Hp
    ceq = U1;
end

