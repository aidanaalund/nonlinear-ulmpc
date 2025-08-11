function y = outputFunctionStateSpace(x,u,ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min)
% outputs: eta, eta_dot
y = [(x(1)-x(3)); (x(2)-x(4))];
end

