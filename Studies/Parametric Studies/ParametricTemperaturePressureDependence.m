
%Inconel
p1 = [1000 5000:5000:20000];
T4 = 850:10:1150;

% % Stainless
% p1 = 8000:500:10000;
% T4 = 900:20:1040;

for j = 1:length(p1)
    
    parfor i = 1:length(T4)
        T4(i)
        [ TotalMinMass(i,j),UA(i,j),UA_min,A_panel(i,j),mass_reactor(i,j),mass_recuperator(i,j),mass_radiator(i,j),m_dot(i,j) ] = minimizeTotalMassMixtures( 40000,p1(j),T4(i),2,200,'CO2',2,'UO2','IN' );
        
    end
end
% Inconel
figure(3)
for k = 1:length(p1)
plot(T4,TotalMinMass(:,k))
hold on
end
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
box on
legend({'p_1 = 1 MPa','p_1 = 5 MPa','p_1 = 10 MPa','p_1 = 15 MPa','p_1 = 20 MPa'},'fontsize',11)
grid on

% for k = 1:length(p1)
%     [minMass,I] = min(TotalMinMass(:,k));
%     scatter(T4(I),minMass,'k')
% end


% figure(2)
% for k = 1:length(T4)
%     plot(p1/1000,TotalMinMass(k,:))
%     hold on
% end
% ylabel('Mass of optimized cycle [kg]','fontsize',18)
% xlabel('Compressor Inlet Pressure [Pa]','fontsize',18)
% box on
% legend('T_4 = 900 K','p_1 = 5 MPa','p_1 = 7 MPa','p_1 = 9 MPa')
% grid on

% % Stainless Steel
% figure(1)
% for k = 1:length(p1)
% plot(T4,TotalMinMass(:,k))
% hold on
% end
% ylabel('Optimum Cycle Mass [kg]','fontsize',18)
% xlabel('Turbine Inlet Temperature [K]','fontsize',18)
% box on
% legend({'p_1 = 8 MPa','p_1 = 8.5 MPa','p_1 = 9 MPa','p_1 = 9.5 MPa','p_1 = 10 MPa'},'fontsize',11,'location','north')
% grid on

% figure(2)
% plot(T4,mass_reactor,'k')
% hold on 
% plot(T4,mass_recuperator,'--k')
% plot(T4,mass_radiator,'-.k')
% ylabel('Mass [kg]','fontsize',18)
% xlabel('Turbine inlet temperature [K]','fontsize',18)
% legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)