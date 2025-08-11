function z = stateFunctionStateSpace(x,u,ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min2)
    % states: z1, z1_dot, z2, z2_dot
    z = zeros(4,1);
    z(1) = x(1) + x(2)*Ts + x(3)*0 + x(4) + 0*u(1) + 0;
    z(2) = ((-ks/ms)*Ts)*x(1) + (((-bs/ms)*Ts)+1)*x(2) + ((ks/ms)*Ts)*x(3) + ((bs/ms)*Ts)*x(4) + (Ts/ms)*u(1) + 0;
    z(3) = x(1)*0 + x(2)*0 + x(3)*1 + x(4)*Ts + 0*u(1) + 0;
    z(4) = ((ks/ms)*Ts)*x(1) + ((bs/mus)*Ts)*x(2) + x(3)*(((-kus/mus)-(ks/mus))*Ts) + ((((-bus/mus)-(bs/mus))*Ts)+1)*x(4) + (-Ts/ms)*u(1) + Ts*(((kus/mus)*zr) + ((bus/mus)*zr_dot));
    % z(4) = ((ks/ms)*Ts)*x(1) + ((bs/mus)*Ts)*x(2) + x(3)*(((-kus/mus)-(ks/mus))*Ts) + ((((-bus/mus)-(bs/mus))*Ts)+1)*x(4) + (-Ts/ms)*u(1);
end

% function [A,B,C,D,dk] = createSystem(Ts,ms,mus,ks,kus,bs,bus,zr,zr_dot)
%     %none of this works!
%     A = [1,Ts,0,1;
%         (-ks/ms)*Ts,((-bs/ms)*Ts)+1,(ks/ms)*Ts,(bs/ms)*Ts;
%         0,0,1,Ts;
%         (ks/ms)*Ts,(bs/mus)*Ts,((-kus/mus)-(ks/mus))*Ts,(((-bus/mus)-(bs/mus))*Ts)+1];
% 
%     B = [0;Ts/ms;0;-Ts/mus];
% 
%     % C = [1,0,-1,0;
%     %     (-ks/ms),(-bs/ms),(ks/ms),(bs/ms)];
%     % 
%     % D = [0;1/ms];
% 
%     C = [1,0,-1,0;
%         0,1,0,-1];
% 
%     D = zeros(2,1);
% 
%     dk = [0;0;0;Ts*( ((kus/mus)*zr) + ((bus/mus)*zr_dot) )];
% end