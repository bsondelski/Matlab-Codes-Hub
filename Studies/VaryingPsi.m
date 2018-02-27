
%%% plots for error and efficiency effects from d_s guesses
% psi = 0.1:0.1:0.7;
% d_s_guess = 1:0.1:15;
% for j = 1:length(psi)
%     for i = 1:length(d_s_guess)
%         [err(i),d_s,n_s] = psiDiameterError(d_s_guess(i),psi(j));
%         [eta_c(i),~] = compressorEfficiencyOld(n_s,d_s);
%     end
%     
%     figure(1)
%     plot(d_s_guess,err)
%     hold on
%     
%     figure(2)
%     plot(d_s_guess,eta_c)
%     hold on   
% end
% figure(1)
% xlabel('ds_g_u_e_s_s')
% ylabel('error')
% legend('psi = 0.1', 'psi = 0.2', 'psi = 0.3', 'psi = 0.4', 'psi = 0.5', 'psi = 0.6', 'psi = 0.7')
% ylim([-2 4])
% grid on
% 
% figure(2)
% xlabel('ds_g_u_e_s_s')
% ylabel('eta_c')
% legend('psi = 0.1', 'psi = 0.2', 'psi = 0.3', 'psi = 0.4', 'psi = 0.5', 'psi = 0.6', 'psi = 0.7')
% ylim([0.7 0.9])
% grid on





%%% plots for d_s, n_s, efficiency effects from psi variance 
% psi = 0.1:0.02:0.67;
% for i = 1:length(psi)
%     psi(i)
%     d_s(i) = fzero(@psiDiameterError,[2, 5],[],psi(i));
%     [~,~,n_s(i)] = psiDiameterError(d_s(i),psi(i));
%     [eta_c(i),~] = compressorEfficiencyOld(n_s(i),d_s(i));
% end
% 
% 
% figure(1)
% plot(psi,eta_c)
% xlabel('psi')
% ylabel('Efficiency')
% grid on
% 
% figure(2)
% plot(psi,n_s)
% xlabel('psi')
% ylabel('Specific Speed')
% grid on
% 
% figure(3)
% plot(psi,d_s)
% xlabel('psi')
% ylabel('Specific Diameter')
% grid on
% 
% figure(4)
% plot(psi,eta_c,psi,n_s,psi,d_s)
% xlabel('psi')
% legend('Efficiency', 'Specific Speed', 'Specific Diameter')
grid on






%%% plot of Mach number 

m_dot = 0.75;
T_in = 350;
p_in = 9000;
p_out = 18000;
fluid = 'CO2';
mode = 2;
psi = 0.1:0.02:0.67;

% get initial properties
% compressor inlet - s [J/kg-K], rho [kg/m3], h [J/kg]
[s1, rho1, h1] = getPropsTP(T_in,p_in,fluid,mode,2);
% isentropic outlet enthalpy [J/kg]
[h2s,~] = getPropsPS(s1,p_out,fluid,mode,1);
h_12s = h2s-h1;             % isentropic enthaply change [J/kg]
V_dot = m_dot/rho1;         % volumetric flow rate [m3/s]


for i = 1:length(psi)
    u_t = sqrt(h_12s/psi(i));          % compressor rotor tip velocity [m/s]
    
    d_s = fzero(@psiDiameterError,[2, 5],[],psi(i));
    [~,~,n_s] = psiDiameterError(d_s,psi(i));
    [n_c,~] = compressorEfficiencyOld(n_s,d_s);
    
    D = d_s*sqrt(V_dot)/(h_12s^(1/4));
    N1 = 2*u_t./D;
    N = n_s*h_12s^(3/4)/sqrt(V_dot);
    
    Power = m_dot*h_12s./n_c;  % [W]
    h2a = Power./m_dot+h1;     % actual outlet enthalpy
    % compressor outlet temperature [K]
    [T_out,a,~] = getPropsPH(p_out,h2a,fluid,mode,2);
    Ma(i) = u_t/a;               % tip mach number
end

plot(psi,Ma)
xlabel('psi')
ylabel('Mach Number')
grid on