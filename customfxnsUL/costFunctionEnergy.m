function J = costFunctionEnergy(X,U,e,data,alpha_o,eta_ddot,Q_n,Q_ndot,R,E,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min,Ts,Fc_last,Hc)
    p = data.PredictionHorizon; % p+1 contains the final predicted state and the input from p (duplicated)
    Ts = data.Ts;
    % tracking
    X1 = X(2:p+1,1);
    X2 = X(2:p+1,2);
    % comfort
    U1 = U(1:Hc,data.MVIndex(1));
    % energy
    U2 = U(1:p,data.MVIndex(1));
    X3 = X(1:p,2);

    %% NOTE: this fxn only works with a 0 right now. If you'd like to use a varying one, let me know and I'll code it up.
    J = Q_n*sum((X1-data.References(1,1)).^2) + Q_ndot*sum((X2-data.References(1,2)).^2) + R*sum(U1.^2);
    % J = Q_n*sum((X1-0).^2) + Q_ndot*sum((X2-0).^2) + R*sum(U1.^2);

    %% energy term
    % At each predicted step, know if you're generating
    for i = 1:p
        u = Fc_last+sum(U2(1:i)); % later
        if (u)*X3(i) >= 0 % motor mode
            J = J + E*Ts*(1/0.85)*(u)*(X3(i));
        else % generator mode
            J = J - E*Ts*0.85*(u)*(X3(i));
        end 
    end 
end

