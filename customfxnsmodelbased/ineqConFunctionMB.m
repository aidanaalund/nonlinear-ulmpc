function cineq = ineqConFunctionMB(X,U,e,data,ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min)
    %cineq = zeros(6,1);
    p = data.PredictionHorizon;

    U1 = U(1:Hc,data.MVIndex(1));
    X1 = X(2:p+1,1);
    
    % does this break with a Hc != 1?
    cineq = [(U1) - Fc_max;
            -(U1) + Fc_min;
            X1 - n_max;
            -X1 + n_min;
            (U1-data.LastMV) - delta_Fc_max;
            -(U1-data.LastMV) + delta_Fc_min;];
end