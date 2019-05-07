
% Inconel - good plot
p1 = 1000:500:20000;
T4 = 900:50:1150;

% % Stainless - needs work
% p1 = 7000:500:10000;
% T4 = 900:50:1050;

for i = 1:length(T4) 
    T4(i)
    parfor j = 1:length(p1)
        [ TotalMinMass(i,j),UA(i,j),UA_min,A_panel(i,j),mass_reactor(i,j),mass_recuperator(i,j),mass_radiator(i,j),m_dot(i,j) ] = minimizeTotalMassMixtures( 40000,p1(j),T4(i),2,200,'CO2',2,'UO2','IN' );
        
    end
end

% figure(1)
% for k = 1:length(p1)
% plot(T4,TotalMinMass(:,k))
% hold on
% end
% ylabel('Mass of optimized cycle [kg]','fontsize',18)
% xlabel('Turbine inlet temperature [K]','fontsize',18)
% box on
% legend('p_1 = 8 MPa','p_1 = 8.5 MPa','p_1 = 9 MPa','p_1 = 9.5 MPa','p_1 = 10 MPa')
% grid on

figure(1)
for k = 1:length(T4)-1
    plot(p1/1000,TotalMinMass(k,:))
    hold on
    text(p1(end)/1000+0.2,TotalMinMass(k,end),['T_4 = ',num2str(T4(k)),' K'])
end
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Compressor Inlet Pressure [Pa]','fontsize',18)
box on
% legend('T_4 = 900 K','T_4 = 950 K','T_4 = 1000 K','T_4 = 1050 K')

grid on


for k = 1:length(T4)-1
    [minMass,I] = min(TotalMinMass(k,:));
    scatter(p1(I)/1000,minMass,'k')
    hold on
end

xlim([1 25])



% figure(2)
% plot(T4,mass_reactor,'k')
% hold on 
% plot(T4,mass_recuperator,'--k')
% plot(T4,mass_radiator,'-.k')
% ylabel('Mass [kg]','fontsize',18)
% xlabel('Turbine inlet temperature [K]','fontsize',18)
% legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)