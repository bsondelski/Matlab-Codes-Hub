% change compressor info for each iteration and manipulate i as
% necessary

i = 9
[ TotalMinMass(i),UA(i),UA_min(i),A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i),~,~,~ ] = minimizeTotalMassMixtures( 40000,9000,900,2,200,'CO2',2,'UO2','SN' )

% get values to plot to understand why there is an optimum head coefficient

i = 6;
    [cyc_pwr(i),efficiency,D_T(i),D_c(i),Ma_T(i),Ma_c(i),Anozzle(i),q_reactor(i),...
    q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),energy(i),p1,T2(i),p2,T3(i),p3,~,p4,T5(i),...
    p5,T6(i),p6,~,Vratio(i)] = BraytonCycle(m_dot(i),9000,900,2,UA(i),...
    A_panel(i),200,'CO2',2,1);
cyc_efficiency(i) = efficiency(1);


psi = [0.5:0.02:0.66]
n_c = [0.86770194 0.866063085414148 0.863980627821614 0.861358651726087 0.858053555546182 0.853835338 0.848296022637343 0.840577144990190 0.828092509298680];
n_s = [0.848580205 0.813078758561479 0.778086077703289 0.743244445508534 0.708103080085482 0.672026784 0.633984120930741 0.591922579707275 0.539852347948822];
d_s = [3.333128807 3.411109873332688 3.497884549987988 3.595872710889376 3.708681307921196 3.842092248 4.006413498613934 4.223525315145657 4.560191002114597];

% psi = [0.35:0.05:0.65]
% n_c = [0.870400345964811 0.871051181 0.87025468 0.86770194 0.862744623 0.853835338 0.835275807];
% n_s = [1.162329967524568 1.044309422 0.941559798 0.848580205 0.76067162 0.672026784 0.567931523];
% d_s = [2.908483058484519 3.028104117 3.166473311 3.333128807 3.545287321 3.842092248 4.367946821];

set(0,'defaultAxesFontSize',12)
xq = [0.5:0.005:0.66];
s = spline(psi,T1,xq);
figure
plot(xq,s,'k')
xlabel('Compressor Head Cefficient','fontsize',18)
ylabel('Temperature at Compressor Inlet [K]','fontsize',18)
grid on
xlim([0.5,0.65])

s2 = spline(psi,cyc_efficiency,xq);
figure
plot(xq,s2,'k')
xlabel('Compressor Head Cefficient','fontsize',18)
ylabel('Cycle Efficiency','fontsize',18)
grid on
xlim([0.5,0.65])

s2 = spline(psi,m_dot,xq);
figure
plot(xq,s2,'k')
xlabel('Compressor Head Cefficient','fontsize',18)
ylabel('Mass Flow Rate','fontsize',18)
grid on
xlim([0.5,0.65])

s2 = spline(psi,q_reactor,xq);
figure
plot(xq,s2,'k')
xlabel('Compressor Head Cefficient','fontsize',18)
ylabel('Thermal Heat Input','fontsize',18)
grid on
xlim([0.5,0.65])

% set(0,'defaultAxesFontSize',12)
% figure
% plot(psi,T1,'k')
% xlabel('Compressor Head Cefficient','fontsize',18)
% ylabel('Temperature at Compressor Inlet [K]','fontsize',18)
% grid on
% xlim([0.5,0.65])

% figure
% plot(psi,cyc_efficiency,'k')
% xlabel('Compressor Head Cefficient','fontsize',18)
% ylabel('Cycle Efficiency','fontsize',18)
% grid on
% xlim([0.5,0.65])

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% new vals

psi = 0.5;
d_s = 3.333128807;
n_s = 0.848580205;
n_c = 0.86770194;

psi = 0.52;
d_s = 3.411109873332688;
n_s = 0.813078758561479;
n_c = 0.866063085414148;
   
psi = 0.54;
d_s = 3.497884549987988;
n_s = 0.778086077703289;
n_c = 0.863980627821614;
   
psi = 0.56;
d_s = 3.595872710889376;
n_s = 0.743244445508534;
n_c = 0.861358651726087;

psi = 0.58;
d_s = 3.708681307921196;
n_s = 0.708103080085482;
n_c = 0.858053555546182;
     
psi = 0.6;
d_s = 3.842092248;
n_s = 0.672026784;
n_c = 0.853835338;

psi = 0.62;
d_s = 4.006413498613934;
n_s = 0.633984120930741;
n_c = 0.848296022637343;

psi = 0.64;
d_s = 4.223525315145657;
n_s = 0.591922579707275;
n_c = 0.840577144990190;

psi = 0.66;
d_s = 4.560191002114597;
n_s = 0.539852347948822;
n_c = 0.828092509298680;

set(0,'defaultAxesFontSize',12)
figure(1)
s3 = spline(psi,TotalMinMass,xq);
plot(xq,s3,'k')
% figure
% plot(psi,TotalMinMass,'k')
ylabel('Optimum Cycle Mass [kg]','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
grid on 
xlim([0.5,0.65])


figure(2)
plot(psi,mass_reactor,'k')
grid on
hold on 
plot(psi,mass_recuperator,'--k')
plot(psi,mass_radiator,'-.k')
ylabel('Mass [kg]','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
legend({'m_r_e_a_c_t_o_r','m_r_e_c_u_p_e_r_a_t_o_r','m_r_a_d_i_a_t_o_r'},'fontsize',12,'location','east')
xlim([0.5,0.65])
ylim([0 700])

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
s4 = spline(psi,n_c,xq);
plot(xq,s4,'k')
% plot(psi,n_c,'k')
grid on
ylabel('Compressor Efficiency','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.5,0.65])

figure(4)
s5 = spline(psi,n_s,xq);
plot(xq,s5,'k')
grid on
ylabel('Specific Speed','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.5,0.65])

figure(5)
s6 = spline(psi,d_s,xq);
plot(xq,s6,'k')
grid on
ylabel('Specific Diameter','fontsize',18)
xlabel('Compressor Head Coefficient','fontsize',18)
xlim([0.5,0.65])
