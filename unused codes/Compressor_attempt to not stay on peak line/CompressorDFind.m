function [ D_actual, eta_actual ] = CompressorDFind( u_t,V_dot,h_12s )
% not used: finds diameter that gives maximum efficiency, not constrained
% to peak of efficiency curve.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Inputs:
% u_t: tip belocity of the compressor rotor [m/s]
% V_dot: volumetric flow rate [m3/s]
% h_12s: isentropic enthalpy change [J/kg]
%
% Outputs:
% Dguess: guess value for compressor diameter
% eta_actual: efficiency of compressor
 
Dmin = 0.0001;
Dmax = 0.05;
 
D = linspace(Dmin,Dmax,50);
N = 2*u_t./D;
n_s = N*sqrt(V_dot)/h_12s^(3/4);
d_s = D*h_12s^(1/4)/sqrt(V_dot);
 
n_c = zeros(1,length(D));
 
for i = 1:length(D)
    [n_c(i),~] = compressorEfficiency(n_s(i),d_s(i));
end
 
[efficiency(1),inde] = max(n_c);
Dia(1)=D(inde);
Dia(2) = D(inde-2);
efficiency(2)=n_c(inde-2);
Dia(3) = D(inde+2);
efficiency(3)=n_c(inde+2);
 
err = 1;
 
while err > 0.001
    p = polyfit(Dia,efficiency,2);
    d = [2*p(1), p(2)];                   % derivative of polynomial
    D_middle = -d(2)/d(1);                % set derivative = 0
    
    N_middle = 2*u_t./D_middle;
    n_s_middle = N_middle*sqrt(V_dot)/h_12s^(3/4);
    d_s_middle = D_middle*h_12s^(1/4)/sqrt(V_dot);
    
    [efficiency_middle,~] = compressorEfficiency(n_s_middle,d_s_middle);
    
    Dia_new = [Dia, D_middle];
    efficiency_new = [efficiency, efficiency_middle];
    
    [~,inde_min] = min(efficiency_new);
    
    Dia_new(inde_min) = [];
    Dia = Dia_new;
    
    efficiency_new(inde_min) = [];
    efficiency = efficiency_new;
    
    err = max(Dia)-min(Dia);          % difference between end points
end
 
D_actual=D_middle;
eta_actual=efficiency_middle;
 
end


