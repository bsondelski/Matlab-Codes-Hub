
%Inconel
% p1 = 3000:2000:9000;
% T4 = 900:20:1100;

% Stainless
p1 = 8000:500:10000;
T4 = 900:20:1040;

for j = 1:length(p1)
    
    parfor i = 1:length(T4)
        T4(i)
        [ TotalMinMass(i,j),UA(i,j),UA_min,A_panel(i,j),mass_reactor(i,j),mass_recuperator(i,j),mass_radiator(i,j),m_dot(i,j) ] = minimizeTotalMass( 40000,p1(j),T4(i),2,200,'CO2',2 );
        
    end
end
% Inconel
figure(1)
for k = 1:length(p1)
plot(T4,TotalMinMass(:,k))
hold on
end
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
box on
legend({'p_1 = 3 MPa','p_1 = 5 MPa','p_1 = 7 MPa','p_1 = 9 MPa'},'fontsize',11)
grid on

figure(2)
for k = 1:length(T4)
    plot(p1/1000,TotalMinMass(k,:))
    hold on
end
ylabel('Mass of optimized cycle [kg]','fontsize',18)
xlabel('Compressor Inlet Pressure [Pa]','fontsize',18)
box on
legend('T_4 = 900 K','p_1 = 5 MPa','p_1 = 7 MPa','p_1 = 9 MPa')
grid on

% Stainless Steel
figure(1)
for k = 1:length(p1)
plot(T4,TotalMinMass(:,k))
hold on
end
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
box on
legend({'p_1 = 8 MPa','p_1 = 8.5 MPa','p_1 = 9 MPa','p_1 = 9.5 MPa','p_1 = 10 MPa'},'fontsize',11,'location','north')
grid on

% figure(2)
% plot(T4,mass_reactor,'k')
% hold on 
% plot(T4,mass_recuperator,'--k')
% plot(T4,mass_radiator,'-.k')
% ylabel('Mass [kg]','fontsize',18)
% xlabel('Turbine inlet temperature [K]','fontsize',18)
% legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)