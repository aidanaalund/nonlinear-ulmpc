function z = stateFunctionStateSpaceCT(x,u,ks,kus,ms,mus,bs,bus,Ts,Q_n,Q_ndot,R,E,zr,zr_dot,Hc,Fc_max,Fc_min,delta_Fc_max,delta_Fc_min,n_max,n_min2)
    % states: z1, z1_dot, z2, z2_dot
    z = zeros(4,1);
    z(1) = x(1) + x(2) + x(3)*0 + x(4) + 0*u(1) + 0;
    z(2) = (-ks/ms)*x(1) + (-bs/ms)*x(2) + (ks/ms)*x(3) + (bs/ms)*x(4) + (1/ms)*u(1) + 0;
    z(3) = x(1)*0 + x(2)*0 + x(3)*1 + x(4) + 0*u(1) + 0;
    z(4) = (ks/ms)*x(1) + (bs/mus)*x(2) + (-(kus+ks)/mus)*x(3) + (-(bus+bs)/mus)*x(4) + (-1/mus)*u(1) + (((kus/mus)*zr) + ((bus/mus)*zr_dot));
end
%% FUNCTION BASED ON:
% function [A, B, d, C, D] = Syst(Ks, Ms, Bs, Kus, Mus, Bus, zr, zr_dot_ADE)
%     A = [    0,      1,             0,              0; 
%         -Ks/Ms, -Bs/Ms,         Ks/Ms,          Bs/Ms; 
%              0,      0,             0,              1; 
%         Ks/Mus, Bs/Mus, -(Kus+Ks)/Mus, -(Bus+Bs)/Mus];
% 
% 
%     B = [0; 1/Ms; 0; -1/Mus];
% 
% 
%     d = [0;    0; 0;  Kus/Mus*zr + Bus/Mus*zr_dot_ADE];
% 
% 
%     C = [    1,      0,    -1,     0;
%              0,      1,     0,    -1];
% 
%     D = [0; 0];
% 
% 
% end