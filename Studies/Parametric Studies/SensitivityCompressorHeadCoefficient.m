% change compressor info for each iteration and manipulate i as
% necessary

i = 7
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,900,2,200,'CO2',2,'UO2','SS' )

% get values to plot to understand why there is an optimum head coefficient
i = 7;
    [~,efficiency,D_T(i),D_c(i),Ma_T(i),Ma_c(i),Anozzle(i),q_reactor(i),...
    q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),energy(i),p1,T2(i),p2,T3(i),p3,~,p4,T5(i),...
    p5,T6(i),p6,~,Vratio(i)] = BraytonCycle(m_dot(i),9000,900,2,UA(i),...
    A_panel(i),200,'CO2',2,1);
cyc_efficiency(i) = efficiency(1);
i = 6

psi = [0.35:0.05:0.65]
n_c = [0.870400345964811 0.871051181 0.87025468 0.86770194 0.862744623 0.853835338 0.835275807];
n_s = [1.162329967524568 1.044309422 0.941559798 0.848580205 0.76067162 0.672026784 0.567931523];
d_s = [2.908483058484519 3.028104117 3.166473311 3.333128807 3.545287321 3.842092248 4.367946821];


set(0,'defaultAxesFontSize',12)
figure
plot(psi,T1,'k')
xlabel('Compressor Head Cefficient','fontsize',18)
ylabel('Temperature at Compressor Inlet [K]','fontsize',18)
grid on
xlim([0.35,0.65])

figure
plot(psi,cyc_efficiency,'k')
xlabel('Compressor Head Cefficient','fontsize',18)
ylabel('Cycle Efficiency','fontsize',18)
grid on
xlim([0.35,0.65])

figure(1)
plot(psi,T1,'-*')
hold on
plot(psi,T2,'-x')
plot(psi,T3,'-o')
plot(psi,T5,'-s')
plot(psi,T6,'-+')
delta = 0.01;
text(psi(end)+delta,T1(end),'T_1')
text(psi(end)+delta,T2(end)-10,'T_2')
text(psi(end)+delta,T3(end)-5,'T_3')
text(psi(end)+delta,T5(end)+5,'T_5')
text(psi(end)+delta,T6(end)+10,'T_6')
grid on

% to get compressor inf - results are in excel file and also shown below

% psi = 0.35:0.05:0.65;
% for j = 1:length(psi)
%     d_s(j) = fzero(@psiDiameterError,[2, 5],[],psi(j));
%     [~,~,n_s(j)] = psiDiameterError(d_s(j),psi(j));
%     [n_c(j),~] = compressorEfficiencyOld(n_s(j),d_s(j));
% end


%%%%%%%%%%%%%%%%%% alter A_panel bound find to 110 to 185 %%%%%%%%%%%%%%%%

% psi = 0.35;
% d_s = 2.908483058484519;
% n_s = 1.162329967524568;
% n_c = 0.870400345964811;

% psi = 0.4;
% d_s = 3.028104117;
% n_s = 1.044309422;
% n_c = 0.871051181;

% psi = 0.45;
% d_s = 3.166473311;
% n_s = 0.941559798;
% n_c = 0.87025468;

%%%%%%%%%%%%%%%%%% alter A_panel bound find to 70 to 120 %%%%%%%%%%%%%%%%

% psi = 0.5;
% d_s = 3.333128807;
% n_s = 0.848580205;
% n_c = 0.86770194;
% 
% psi = 0.55;
% d_s = 3.545287321;
% n_s = 0.76067162;
% n_c = 0.862744623;
% 
% psi = 0.6;
% d_s = 3.842092248;
% n_s = 0.672026784;
% n_c = 0.853835338;
% 
% psi = 0.65;
% d_s = 4.367946821;
% n_s = 0.567931523;
% n_c = 0.835275807;

set(0,'defaultAxesFontSize',12)
figure(1)
plot(psi,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
grid on 
xlim([0.35,0.65])


figure(2)
plot(psi,mass_reactor,'k')
grid on
hold on 
plot(psi,mass_recuperator,'--k')
plot(psi,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','northeast')
xlim([0.35,0.65])

figure(6)
subplot(3,1,1)
plot(psi,n_c,'k')
grid on
ylabel('Compressor Efficiency','fontsize',18)
xlim([0.35,0.65])

subplot(3,1,2)
plot(psi,n_s,'k')
grid on
ylabel('Specific Speed','fontsize',18)
xlim([0.35,0.65])

subplot(3,1,3)
plot(psi,d_s,'k')
grid on
ylabel('Specific Diameter','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.35,0.65])


figure(3)
plot(psi,n_c,'k')
grid on
ylabel('Compressor Efficiency','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.35,0.65])

figure(4)
plot(psi,n_s,'k')
grid on
ylabel('Specific Speed','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.35,0.65])

figure(5)
plot(psi,d_s,'k')
grid on
ylabel('Specific Diameter','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.35,0.65])
