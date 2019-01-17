% must have results from ParametricMultiRun in the 'Parametric
% Studies/Results' folder

% comment out plots not wanted - Run script
% DO NOT "Evaluate Selection" - it doesn't work



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UO2 Studies %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % plot PR dependence
% % figure 1 - total mass
% % figure 2 - Turbine Mach numbers
% % figure 3 - Compressor Mach numbers
% plotPRdependence
% 
% % plot temperature mass dependence along with recuperator inlet temps
% % for UO2 only
% % figure 4
% plotTtinDependence

% plot p1 dependence
% figure 5
plotP1Dependence



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% UW Studies %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % plot PR dependence
% % figure 1 - total mass
% % figure 2 - Turbine Mach numbers
% % figure 3 - Compressor Mach numbers
% plotPRdependenceUW
% 
% % plot temperature mass dependence along with recuperator inlet temps
% % figure 4
% plotTtinDependenceUW
% 
% % plot p1 dependence
% % figure 5
% plotP1DependenceUW
% 
% 
% %%%%%%%%%%%%%%%%%%%%%% plot with both UW and UO2 %%%%%%%%%%%%%%%%%%%%%%%%%
% % plot temperature mass dependence along with recuperator inlet temps
% % figure 4
% plotTtinDependence_UO2_UW
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%% why reactor mass increases %%%%%%%%%%%%%%%%%%%%%
% % figure 1 - UW reactor component mass v Turbine inlet temp
% % figure 2 - UW cycle component mass v Turbine inlet temp
% % figure 3 - UO2 reactor component mass v Turbine inlet temp
% % figure 4 - UO2 cycle component mass v Turbine inlet temp
% ReactorMassEval


function [] = plotPRdependence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot PR dependence
% figure 1 - total mass
% figure 2 - Turbine Mach numbers
% figure 3 - Compressor Mach numbers
% stainless steel near term
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSPRNear.mat'
set(0,'defaultAxesFontSize',12)
figure(1)
plot(PR,TotalMinMass,'k')
hold on
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
box on
grid on

[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 900 K'],'fontsize',11)
text(PR(end)+0.01,TotalMinMass(end)+35,['Stainless Steel'],'fontsize',11)

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
        q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
        p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),900,PR(i),UA(i),...
        A_panel(i),200,'CO2',2,0);
end

figure(2)
plot(PR,Ma_T,'k')
hold on
scatter(PR(I),Ma_T(I),'k')
text(PR(I)+0.02,Ma_T(I)-0.023,['T_4 = 900 K'],'fontsize',11)
text(PR(I)+0.02,Ma_T(I)-0.008,['Stainless Steel'],'fontsize',11)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on
hold on

figure(3)
plot(PR,Ma_c,'k')
hold on
scatter(PR(I),Ma_c(I),'k')
text(PR(I)+0.02,Ma_c(I)-0.023,['T_4 = 900 K'],'fontsize',11)
text(PR(I)+0.02,Ma_c(I)-0.008,['Stainless Steel'],'fontsize',11)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on
hold on

clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSPRFar.mat'
figure(1)
plot(PR,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 980 K'],'fontsize',11)
text(PR(end)+0.01,TotalMinMass(end)+35,['Stainless Steel'],'fontsize',11)

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
        q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
        p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),Tmin,PR(i),UA(i),...
        A_panel(i),200,'CO2',2,0);
end

figure(2)
plot(PR,Ma_T,'k')
scatter(PR(I),Ma_T(I),'k')
text(PR(I)+0.02,Ma_T(I)-0.023,['T_4 = 980 K'],'fontsize',11)
text(PR(I)+0.02,Ma_T(I)-0.008,['Stainless Steel'],'fontsize',11)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(3)
plot(PR,Ma_c,'k')
scatter(PR(I),Ma_c(I),'k')
% text(PR(I)-0.2,Ma_c(I)+0.015,['T_4 = 980 K'],'fontsize',11)
% text(PR(I)-0.2,Ma_c(I)+0.03,['Stainless Steel'],'fontsize',11)
text(PR(I)+0.02,Ma_c(I)-0.03,['T_4 = 980 K'],'fontsize',11)
text(PR(I)+0.02,Ma_c(I)-0.015,['Stainless Steel'],'fontsize',11)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INPR.mat'
figure(1)
plot(PR,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 1070 K'],'fontsize',11)
text(PR(end)+0.01,TotalMinMass(end)+35,['Inconel'],'fontsize',11)

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
        q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
        p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),Tmin,PR(i),UA(i),...
        A_panel(i),200,'CO2',2,0);
end

figure(2)
plot(PR,Ma_T,'k')
scatter(PR(I),Ma_T(I),'k')
text(PR(I)+0.02,Ma_T(I)-0.023,['T_4 = 1070 K'],'fontsize',11)
text(PR(I)+0.02,Ma_T(I)-0.008,['Inconel'],'fontsize',11)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(3)
plot(PR,Ma_c,'k')
scatter(PR(I),Ma_c(I),'k')
text(PR(I)-0.22,Ma_c(I)+0.005,['T_4 = 1070 K'],'fontsize',11)
text(PR(I)-0.22,Ma_c(I)+0.02,['Inconel'],'fontsize',11)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(1)
xlim([2 3.35])
ylim([450 1000])

figure(3)
xlim([2 3])
end

function [] = plotTtinDependence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot temperature mass dependence along with recuperator inlet temps
% plot Stainless Steel 
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSTemp.mat'
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',16)
figure(4)
set(gcf, 'units','normalized','outerposition',[0 0 0.5 0.8]);
plot(T4(1:6),TotalMinMass(1:6),'--k','linewidth',1.5)
hold on
plot(T4(6:end),TotalMinMass(6:end),':k','linewidth',1.5)
set(gca,'box','off')

% plot Stainless Steel 
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INTemp.mat'

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)

plot(T4,TotalMinMass,'k')
ylim([500 1000])
ylabel('Optimum Cycle Mass [kg]','fontsize',22)
xlabel('Turbine Inlet Temperature [K]','fontsize',22)
legend({'Stainless Steel Near Term','Stainless Steel Far Term','Inconel'},'fontsize',16,'location','north')


ax1 = gca;
ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
line(T5,TotalMinMass,'Parent',ax2,'Color','k')
set(gca,'YTickLabel',[])
xlim([T5(1),T5(end)])
ylim([500 1000])
xlabel('Recuperator Inlet Temperature [K]','fontsize',22)
end

function [] = plotP1Dependence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot p1 dependence
% stainless steel near term
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSp1Near.mat'
set(0,'defaultAxesFontSize',12)
figure(5)
plot(p1./1000,TotalMinMass,'k')
hold on
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
box on
grid on

[minMass,I] = min(TotalMinMass);
scatter(p1(I)/1000,minMass,'k')
text(p1(end)/1000+0.2,TotalMinMass(end),['T_4 = 900 K'],'fontsize',11)
text(p1(end)/1000+0.2,TotalMinMass(end)+20,['Stainless Steel'],'fontsize',11)

% stainless steel far term
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSp1Far.mat'
plot(p1./1000,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(p1(I)/1000,minMass,'k')
text(p1(end)/1000+0.2,TotalMinMass(end),['T_4 = 970 K'],'fontsize',11)
text(p1(end)/1000+0.2,TotalMinMass(end)+20,['Stainless Steel'],'fontsize',11)

% Inconel
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INp1.mat'
plot(p1./1000,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(p1(I)/1000,minMass,'k')
text(p1(end)/1000+0.2,TotalMinMass(end),['T_4 = 1050 K'],'fontsize',11)
text(p1(end)/1000+0.2,TotalMinMass(end)+20,['Inconel'],'fontsize',11)

xlim([9 24])
ylim([500 850])
% plot([9 9],[500 850],'--k')
end

function [] = plotPRdependenceUW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot PR dependence
% figure 1 - total mass
% figure 2 - Turbine Mach numbers
% figure 3 - Compressor Mach numbers
% stainless steel near term
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSPRNear.mat'
set(0,'defaultAxesFontSize',12)
figure(1)
plot(PR,TotalMinMass,'k')
hold on
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
box on
grid on

[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 900 K'],'fontsize',11)
text(PR(end)+0.01,TotalMinMass(end)+35,['Stainless Steel'],'fontsize',11)

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),900,PR(i),UA(i),...
    A_panel(i),200,'CO2',2,0);
end

figure(2)
plot(PR,Ma_T,'k')
hold on
scatter(PR(I),Ma_T(I),'k')
text(PR(I)+0.06,Ma_T(I)-0.005,['T_4 = 900 K'],'fontsize',11)
text(PR(I)+0.06,Ma_T(I)+0.01,['Stainless Steel'],'fontsize',11)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on
hold on

figure(3)
plot(PR,Ma_c,'k')
hold on
scatter(PR(I),Ma_c(I),'k')
text(PR(I)+0.06,Ma_c(I)-0.015,['T_4 = 900 K'],'fontsize',11)
text(PR(I)+0.065,Ma_c(I),['Stainless Steel'],'fontsize',11)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on
hold on

clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSPRFar.mat'
figure(1)
plot(PR,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 970 K'],'fontsize',11)
text(PR(end)+0.01,TotalMinMass(end)+35,['Stainless Steel'],'fontsize',11)

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),970,PR(i),UA(i),...
    A_panel(i),200,'CO2',2,0);
end

figure(2)
plot(PR,Ma_T,'k')
scatter(PR(I),Ma_T(I),'k')
text(PR(I)+0.06,Ma_T(I)-0.01,['T_4 = 970 K'],'fontsize',11)
text(PR(I)+0.065,Ma_T(I)+0.005,['Stainless Steel'],'fontsize',11)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(3)
plot(PR,Ma_c,'k')
scatter(PR(I),Ma_c(I),'k')
text(PR(I)+0.06,Ma_c(I)-0.015,['T_4 = 970 K'],'fontsize',11)
text(PR(I)+0.07,Ma_c(I),['Stainless Steel'],'fontsize',11)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INPR.mat'
figure(1)
plot(PR,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(PR(I),minMass,'k')
text(PR(end)+0.01,TotalMinMass(end),['T_4 = 1050 K'],'fontsize',11)
text(PR(end)+0.01,TotalMinMass(end)+35,['Inconel'],'fontsize',11)

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T(i),Ma_c(i),Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,~,T2,p2,T3,p3,~,p4,T5,...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),p1(i),1050,PR(i),UA(i),...
    A_panel(i),200,'CO2',2,0);
end

figure(2)
plot(PR,Ma_T,'k')
scatter(PR(I),Ma_T(I),'k')
text(PR(I)+0.02,Ma_T(I)-0.025,['T_4 = 1050 K'],'fontsize',11)
text(PR(I)+0.02,Ma_T(I)-0.01,['Inconel'],'fontsize',11)
ylabel('Turbine Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(3)
plot(PR,Ma_c,'k')
scatter(PR(I),Ma_c(I),'k')
text(PR(I)-0.25,Ma_c(I),['T_4 = 1050 K'],'fontsize',11)
text(PR(I)-0.15,Ma_c(I)+0.015,['Inconel'],'fontsize',11)
ylabel('Compressor Mach Number','fontsize',18)
xlabel('Pressure Ratio','fontsize',18)
grid on

figure(1)
xlim([2 3.35])
% ylim([600 1050])

figure(3)
xlim([1.8 3])
end

function [] = plotTtinDependenceUW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot temperature mass dependence along with recuperator inlet temps
% plot Stainless Steel 

% sometimes - must change y limits for second axis - run until "ax1 =" line
% and replace y limits with the y limits that are natural until that point
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSTemp.mat'
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)
figure(4)
set(gcf, 'units','normalized','outerposition',[0 0 0.5 0.8]);
plot(T4(1:6),TotalMinMass(1:6),'--k','linewidth',1.5)
hold on
plot(T4(6:end),TotalMinMass(6:end),':k','linewidth',1.5)
set(gca,'box','off')

% plot Stainless Steel 
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INTemp.mat'

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)

plot(T4,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
legend({'Stainless Steel Near Term','Stainless Steel Far Term','Inconel'},'fontsize',12,'location','north')


ax1 = gca;
ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
line(T5,TotalMinMass,'Parent',ax2,'Color','k')
set(gca,'YTickLabel',[])
xlim([T5(1),T5(end)])
ylim([650 1200])
xlabel('Recuperator Inlet Temperature [K]','fontsize',18)
end

function [] = plotP1DependenceUW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot p1 dependence
% stainless steel near term
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSp1Near.mat'
set(0,'defaultAxesFontSize',12)
figure(5)
plot(p1./1000,TotalMinMass,'k')
hold on
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Compressor Inlet Pressure [MPa]','fontsize',18)
box on
grid on

[minMass,I] = min(TotalMinMass);
scatter(p1(I)/1000,minMass,'k')
text(p1(end)/1000+0.2,TotalMinMass(end),['T_4 = 900 K'],'fontsize',11)
text(p1(end)/1000+0.2,TotalMinMass(end)+20,['Stainless Steel'],'fontsize',11)

% stainless steel far term
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSp1Far.mat'
plot(p1./1000,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(p1(I)/1000,minMass,'k')
text(p1(end)/1000+0.2,TotalMinMass(end),['T_4 = 970 K'],'fontsize',11)
text(p1(end)/1000+0.2,TotalMinMass(end)+20,['Stainless Steel'],'fontsize',11)

% Inconel
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INp1.mat'
plot(p1./1000,TotalMinMass,'k')
[minMass,I] = min(TotalMinMass);
scatter(p1(I)/1000,minMass,'k')
text(p1(end)/1000+0.2,TotalMinMass(end),['T_4 = 1050 K'],'fontsize',11)
text(p1(end)/1000+0.2,TotalMinMass(end)+20,['Inconel'],'fontsize',11)

xlim([2 19.5])
% plot([9 9],[600 950],'--k')
end

function [] = plotTtinDependence_UO2_UW
%%%%%%%%%%%%%%%%%%%%% plot with both UW and UO2 %%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot temperature mass dependence along with recuperator inlet temps
% plot Stainless Steel 
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSTemp.mat'
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)
figure(4)
set(gcf, 'units','normalized','outerposition',[0 0 0.5 0.8]);
plot(T4(1:6),TotalMinMass(1:6),'--k','linewidth',1.5)
hold on
plot(T4(6:end),TotalMinMass(6:end),':k','linewidth',1.5)
set(gca,'box','off')

% plot Stainless Steel 
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INTemp.mat'

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)

plot(T4,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot temperature mass dependence along with recuperator inlet temps
% plot Stainless Steel 
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSTemp.mat'
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)
figure(4)
set(gcf, 'units','normalized','outerposition',[0 0 0.5 0.8]);
plot(T4(1:6),TotalMinMass(1:6),'--b','linewidth',1.5)
hold on
plot(T4(6:end),TotalMinMass(6:end),':b','linewidth',1.5)
set(gca,'box','off')

% plot Stainless Steel 
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INTemp.mat'

for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)

plot(T4,TotalMinMass,'b')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
legend({'Stainless Steel Near Term - UO2','Stainless Steel Far Term-UO2','Inconel-UO2','Stainless Steel Near Term-UW','Stainless Steel Far Term-UW','Inconel-UW'},'fontsize',12,'location','north')



ax1 = gca;
ax1_pos = ax1.Position;

ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
line(T5,TotalMinMass,'Parent',ax2,'Color','b')
set(gca,'YTickLabel',[])
xlim([T5(1),T5(end)])
ylim([500 1100])
xlabel('Recuperator Inlet Temperature [K]','fontsize',18)
end

function [] = ReactorMassEval
%%%%%%%%%%%%%%%% why reactor mass increases %%%%%%%%%%%
clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INTemp.mat'
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)

% plot to figure out why reactor mass increases with temperature - run with
% Inconel

for i=1:length(TotalMinMass)
rxtr = py.reactor_mass.reactor_mass('UW', 'CO2', q_reactor(i), m_dot(i), [T3(i), T4(i)], [p3(i)*1000, p4(i)*1000])
mass(i) = rxtr.mass;
refl_mass(i) = rxtr.refl_mass;
fuel_mass(i) = rxtr.fuel_mass;
PV_mass(i) = rxtr.PV_mass;
clad_mass(i) = rxtr.clad_mass;
gen_Q(i) = rxtr.gen_Q;
end

figure(1)
% plot(T4,mass)

plot(T4,refl_mass)
hold on
plot(T4,fuel_mass)
plot(T4,PV_mass)
plot(T4,clad_mass)
delta = 10;
% text(T4(end)+delta,mass(end),'Total Reactor mass')
text(T4(end)+delta,refl_mass(end)-3,'Reflector mass','fontsize',12)
text(T4(end)+delta,fuel_mass(end),'Fuel mass','fontsize',12)
text(T4(end)+delta,PV_mass(end),'Pressure vessel mass','fontsize',12)
text(T4(end)+delta,clad_mass(end)+5,'Cladding mass','fontsize',12)
xlim([850 1265])
% ylim([0 150])
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
ylabel('Reactor Component Mass [kg]','fontsize',18)
grid on
title('UW')

figure(2)
plot(T4,mass_reactor,'k')
hold on 
plot(T4,mass_recuperator,'--k')
plot(T4,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Turbine inlet temperature [K]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)
grid on
title('UW')


clear
load 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INTemp.mat'
for i=1:length(TotalMinMass)
    [net_power,~,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(i),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(i),p3(i),~,p4(i),T5(i),...
    p5,T6,p6,~,Vratio] = BraytonCycle(m_dot(i),9000,T4(i),2,UA(i),...
    A_panel(i),200,'CO2',2,0);
end
set(0,'defaultAxesFontSize',12)



% plot to figure out why reactor mass increases with temperature - run with
% Inconel

for i=1:length(TotalMinMass)
rxtr = py.reactor_mass.reactor_mass('UO2', 'CO2', q_reactor(i), m_dot(i), [T3(i), T4(i)], [p3(i)*1000, p4(i)*1000])
mass(i) = rxtr.mass;
refl_mass(i) = rxtr.refl_mass;
fuel_mass(i) = rxtr.fuel_mass;
PV_mass(i) = rxtr.PV_mass;
clad_mass(i) = rxtr.clad_mass;
gen_Q(i) = rxtr.gen_Q;
end

figure(3)
% plot(T4,mass)

plot(T4,refl_mass)
hold on
plot(T4,fuel_mass)
plot(T4,PV_mass)
plot(T4,clad_mass)
delta = 10;
% text(T4(end)+delta,mass(end),'Total Reactor mass')
text(T4(end)+delta,refl_mass(end)-3,'Reflector mass','fontsize',12)
text(T4(end)+delta,fuel_mass(end),'Fuel mass','fontsize',12)
text(T4(end)+delta,PV_mass(end),'Pressure vessel mass','fontsize',12)
text(T4(end)+delta,clad_mass(end)+5,'Cladding mass','fontsize',12)
xlim([850 1265])
ylim([0 150])
xlabel('Turbine Inlet Temperature [K]','fontsize',18)
ylabel('Reactor Component Mass [kg]','fontsize',18)
grid on
title('UO2')


figure(4)
plot(T4,mass_reactor,'k')
hold on 
plot(T4,mass_recuperator,'--k')
plot(T4,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Turbine inlet temperature [K]','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',11)
grid on
title('UO2')
end