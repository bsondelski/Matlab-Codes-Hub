tic
p1=9000;
T4=1100;
PR_c=2;
A_panel=50:10:120;
T_amb=100;
fluid='CO2';
mode=2;

desiredPower=40000;
parfor i=1:length(A_panel)
UA(i)=fzero(@maxPowerMatch,10000,[],desiredPower,p1,T4,PR_c,A_panel(i),T_amb,fluid,mode);
[~,m_dot(i)] = findMaxPower(p1,T4,PR_c,UA(i),A_panel(i),T_amb,fluid,mode);
end


for i=1:length(UA)
[~,cyc_efficiency(i),~,~,~,~,~,q_reactor(i),q_rad(i),~,~,~,~,~,~,~,~,T3(i),p3(i),T4_out(i),p4(i),~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(i),A_panel(i),T_amb,fluid,mode);
end

UA_new=UA/1000;
% recup_mass=0.3051*UA_new+863.05;
recup_mass=2.522*UA_new;

q_rad=q_rad/1000;
Rad_mass=3.5136*-q_rad+58.244;

total_mass=Rad_mass+recup_mass;
plot(UA,total_mass)
hold on
plot(UA,Rad_mass)
plot(UA,recup_mass)
xlabel('UA [W/K]')
ylabel('Mass [kg]')
legend('Total Mass','Radiator Mass','Recuperator Mass')
toc

figure
plot(A_panel,UA)
xlabel('Panel Area [m^3]')
ylabel('UA [W/K]')

T3_new=transpose(T3);
T4_new=transpose(T4_out);
p3_new=transpose(p3);
p4_new=transpose(p4);
m_dot_new=transpose(m_dot);
cyc_efficiency_new=transpose(cyc_efficiency);
q_reactor_new=transpose(q_reactor)
T=table(T3_new,T4_new,p3_new,p4_new,m_dot_new,cyc_efficiency_new,q_reactor_new)

writetable(T,'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Simple Brayton Cycle\CycleParameters.txt','Delimiter','\t')



