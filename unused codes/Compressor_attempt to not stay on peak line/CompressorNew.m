function [T_out,D,N,Power,Ma,h2a] = CompressorNew(m_dot,T_in,p_in,p_out,fluid,mode)
% Not used: max compressor efficiency, not on peak
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Inputs:
% m_dot: the mass flow into the compressor [kg/s]
% T_in: flow temp at inlet of the compressor [K]
% p_in: flow pressure at inlet of the compressor [kPa]
% p_out: flow pressure at outlet of the compressor [kPa]
% fluid: working fluid for the system
% Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
% 
% Outputs:
% T_out: flow temp at outlet of compresor [K]
% D: the diameter of the rotor in the compressor (compressor diameter) [m]
% N: the shaft speed of the compressor [rad/s]
% Power: the power consumed by the compressor [W]
% Ma: the mach number of the compressor outlet
% h2a: enthalpy of the flow at the outlet of the compressor [J/kg]
 
 
% get initial properties
% compressor inlet - s [J/kg-K], rho [kg/m3], h [J/kg]
[s1, rho1, h1] = getPropsTP(T_in,p_in,fluid,mode,2);  
h2s = getPropsPS(s1,p_out,fluid,mode);  % isentropic outlet enthalpy [J/kg]
h_12s = h2s-h1;             % isentropic enthaply change [J/kg]        
 






% % dimensionless head coefficient
% psi = fzero(@compressorPsiError,[0.3, 0.62],[],h_12s,m_dot,rho1);
%  
% % find the diameter of the compressor
% u_t = sqrt(h_12s/psi);      % tip velocity of the compressor rotor [m/s]
V_dot = m_dot/rho1;         % volumetric flow rate [m3/s]



dsmin = 1;
dsmax = 15;
 
d_s = linspace(dsmin,dsmax,50);
D=d_s*sqrt(V_dot)/h_12s^(1/4);
% d_s = D*h_12s^(1/4)/sqrt(V_dot);
 
n_c = zeros(1,length(D));
 
for i = 1:length(D)
    [n_c(i),~] = compressorEfficiency(inf,d_s(i));
end
 
[efficiency(1),inde] = max(n_c);
Dia(1)=D(inde);
Dia(2) = D(inde-2);
efficiency(2)=n_c(inde-2);
Dia(3) = D(inde+2);
efficiency(3)=n_c(inde+2);
 
err = 1;
 
while err > 0.01
    p = polyfit(Dia,efficiency,2);
    d = [2*p(1), p(2)];                   %derivative of polynomial
    D_middle = -d(2)/d(1);                %set derivative = 0

    d_s_middle = D_middle*h_12s^(1/4)/sqrt(V_dot);
    
    [efficiency_middle,~] = compressorEfficiency(inf,d_s_middle);
    
    Dia_new = [Dia, D_middle];
    efficiency_new = [efficiency, efficiency_middle];
    
    [~,inde_min] = min(efficiency_new);
    
    Dia_new(inde_min) = [];
    Dia = Dia_new;
    
    efficiency_new(inde_min) = [];
    efficiency = efficiency_new;
    
    err = max(Dia)-min(Dia);          %difference between end points
end
 
D_actual=D_middle;
d_s = D_actual*h_12s^(1/4)/sqrt(V_dot);
[n_c,n_s]=compressorEfficiency(inf,d_s);
eta_actual=efficiency_middle;



% 
% % Dguess= CompressorDBoundFind(u_t,V_dot,h_12s);  %calcualte diameter bounds
% % 
% % % use Fzero to find D
% % D=fzero(@compressorDError,Dguess,[],u_t,V_dot,h_12s);
% % N=2*u_t/D;              %calculate the shaft speed of the compressor in [rad/s]
% % n_s=N*sqrt(V_dot)/h_12s^(3/4);  %calculate specific speed
% % 
% % [n_c,d_s]=compressorEfficiency(n_s,inf);       %isentropic compressor efficiency
% % 
% % D=d_s*sqrt(V_dot)/h_12s^(1/4);  %calcualte diameter
% 
% 
% 
% %forcing to be n_c max
% [ D, n_c ] = CompressorDFind( u_t,V_dot,h_12s )
% % Dguess = CompressorDBoundFind(u_t,V_dot,h_12s);  
% % D = fzero(@compressorDError,Dguess,[],u_t,V_dot,h_12s);
% % 
% N = 2*u_t/D;              % shaft speed of compressor [rad/s]
% % n_s = N*sqrt(V_dot)/h_12s^(3/4);  % specific speed
% % 
% % d_s = D*h_12s^(1/4)/sqrt(V_dot);
% % [n_c,d_s] = compressorEfficiency(n_s,d_s);       % isentropic compressor efficiency




%calculate flow coefficient
Area=pi()*D^2/4;
phi=m_dot/(rho1*u_t*Area);   

Power=m_dot*h_12s/n_c;  %calculate power from isentropic efficiency[W]
h2a=Power/m_dot+h1;     %calculate actual outlet enthalpy
[T_out,a,~]=getPropsPH(p_out,h2a,fluid,mode,2);   %calculate temperature at outlet of compressor[K] 
Ma=u_t/a;               %calculate the mach number of the tip velocity 
end

