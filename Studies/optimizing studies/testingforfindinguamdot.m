tic
p1 = 9000;
T4 = 1100;
PR_c = 2;
A_panel = 40:10:120;
T_amb = 100;
fluid = 'CO2';
mode = 2;

desiredPower = 40000;
parfor i = 1:length(A_panel)
    %     A_panel(i)
    [ UA(i),m_dot(i) ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel(i),T_amb,fluid,mode)
    % UA(i) = fzero(@maxPowerMatch,10000,[],desiredPower,p1,T4,PR_c,A_panel(i),T_amb,fluid,mode);
    % [~,m_dot(i)] = findMaxPower(p1,T4,PR_c,UA(i),A_panel(i),T_amb,fluid,mode);
end

% parfor i = 1:length(UA)
% [~,cyc_efficiency(i),~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),~,~,~,~,~,T2(i),p2(i),T3(i),p3(i),T4_out(i),p4(i),T5(i),p5(i),T6(i),p6(i),A_panel(i),~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(i),A_panel(i),T_amb,fluid,mode);
% end

% recup_mass = 0.3051*UA_new+863.05;
recup_mass = 0.0131*UA; %convert to kW/K

Rad_mass = 5.8684*A_panel;

total_mass = Rad_mass+recup_mass;
figure
plot(UA/1000,total_mass)
hold on
plot(UA/1000,Rad_mass)
plot(UA/1000,recup_mass)
xlabel('UA [kW/K]')
ylabel('Mass [kg]')
legend('Total Mass','Radiator Mass','Recuperator Mass')
grid on
toc

figure
plot(A_panel,UA/1000)
xlabel('Panel Area [m^2]')
ylabel('UA [kW/K]')
grid on

[~,minind]=min(total_mass);

UAplot=[UA(1),UA(minind),UA(length(A_panel))];
m_dotplot=[m_dot(1),m_dot(minind),m_dot(length(A_panel))];
A_panelplot=[A_panel(1),A_panel(minind),A_panel(length(A_panel))];
for i=1:length(A_panelplot)
    [~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dotplot(i),p1,T4,PR_c,UAplot(i),A_panelplot(i),T_amb,fluid,mode,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotting various parameters
% figure
% plot(UA,T1)
% xlabel('UA [W/K]')
% ylabel('T1 [K]')
%
% figure
% plot(UA,T2)
% xlabel('UA [W/K]')
% ylabel('T2 [K]')
%
% figure
% plot(UA,T3)
% xlabel('UA [W/K]')
% ylabel('T3 [K]')
%
% figure
% plot(UA,T5)
% xlabel('UA [W/K]')
% ylabel('T5 [K]')
%
% figure
% plot(UA,T6)
% xlabel('UA [W/K]')
% ylabel('T6 [K]')
%
% figure
% plot(UA,p2)
% xlabel('UA [W/K]')
% ylabel('p2 [kPa]')
%
% figure
% plot(UA,p3)
% xlabel('UA [W/K]')
% ylabel('p3 [kPa]')
%
% figure
% plot(UA,p5)
% xlabel('UA [W/K]')
% ylabel('p5 [kPa]')
%
% figure
% plot(UA,p6)
% xlabel('UA [W/K]')
% ylabel('p6 [kPa]')
%
% figure
% plot(UA,m_dot)
% xlabel('UA [W/K]')
% ylabel('m_dot [kg/s]')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % for Alex
% T3_new = transpose(T3);
% T4_new = transpose(T4_out);
% p3_new = transpose(p3);
% p4_new = transpose(p4);
% m_dot_new = transpose(m_dot);
% cyc_efficiency_new = transpose(cyc_efficiency);
% q_reactor_new = transpose(q_reactor)
% T = table(T3_new,T4_new,p3_new,p4_new,m_dot_new,cyc_efficiency_new,q_reactor_new)
%
% writetable(T,'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Simple Brayton Cycle\CycleParameters.txt','Delimiter','\t')




