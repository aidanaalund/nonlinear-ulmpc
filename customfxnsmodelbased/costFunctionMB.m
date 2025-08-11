function J = costFunctionMB(X,U,e,data,ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min)
    % u = Fc;
    % x = [z1,z1_dot,z2,z2_dot]^T;
    % y = [n,n_dot]^T;

    p = data.PredictionHorizon;
    Y = zeros(p+1,data.NumOfOutputs);
    for i=2:p+1
        % uncomment this line and comment the below two lines for a
        % slowdown
        % Y(i,:) = outputFunctionStateSpace(X(i,:)',U(i,:)',ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc)';
        Y(i,1) = X(i,1)-X(i,3);
        Y(i,2) = X(i,2)-X(i,4);
    end
    % could be sped up?
    Y1 = Y(2:p+1,1);
    Y2 = Y(2:p+1,2);
    U1 = U(1:Hc,data.MVIndex(1));
    % this currently only works w/flat trajectory... (ref is a Hp x ny
    % matrix)
    J = Q_n*sum((Y1-data.References(1,1)).^2) + Q_ndot*sum((Y2-data.References(1,2)).^2) + R*sum((U1-data.LastMV(1)).^2);

    %% energy term
    U2 = U(1:p,data.MVIndex(1));
    for i = 1:p
        u = U2(i);
        if (u)*Y2(i) >= 0 % motor mode
            J = J + E*sum((1/0.85)*(u)*(Y2(i)));
        else % generator mode
            J = J - E*sum(0.85*(u)*(Y2(i)));
        end
    end
end

