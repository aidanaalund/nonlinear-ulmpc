function cineq = ineqConFunction(X,U,e,data,alpha_o,eta_ddot,Q_n,Q_ndot,R,E,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min,Ts,Fc_last,Hc)
    p = data.PredictionHorizon;
    % the first row of x is current state
    % the last row of u is duplicated

    % magnitude constraint max/min
    U1 = U(1:Hc,data.MVIndex(1));
    % cineq(1) = (U1 + Fc_last) - Fc_max;
    % cineq(2) = -(U1 + Fc_last) + Fc_min;
    % output constraint max/min
    X1 = X(2:p+1,1);
    % cineq(3) = X1 - n_max;
    % cineq(4) = -X1 + n_min;
    % % delta magnitude max/min
    % cineq(5) = U1 - delta_Fc_max;
    % cineq(6) = -U1 + delta_Fc_min;

    cineq = [(U1 + Fc_last) - Fc_max;
            -(U1 + Fc_last) + Fc_min;
            X1 - n_max;
            -X1 + n_min;
            U1 - delta_Fc_max;
            -U1 + delta_Fc_min;
    ];
end

