function z = stateFunction(x,u,alpha_o,eta_ddot,Q_n,Q_ndot,R,E,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min,Ts,Fc_last,Hc)
    z = zeros(2,1);
    z(1) = x(1)+(Ts*x(2));
    z(2) = x(2) + alpha_o*Ts*u(1) + eta_ddot*Ts;
end
