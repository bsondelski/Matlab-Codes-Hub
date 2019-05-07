
set(0,'defaultAxesFontSize',12)

% mol fraction converted to mass fraction **
%array of mol fractions
molfraction_H2O = 0.15;

%change to mass fractions
molfraction_CO2 = 1 - molfraction_H2O;

% moles of each constituent if 100 total moles
moles_H2O = molfraction_H2O*100;
moles_CO2 = molfraction_CO2*100;

% grams of each constituent - converted with molecular weight
mass_H2O = moles_H2O*18.01528;
mass_CO2 = moles_CO2*44.01;

% find mass fractions
total_mass = mass_H2O + mass_CO2;
fraction_H2O = mass_H2O./total_mass;
fraction_CO2 = mass_CO2./total_mass;



substance = {'CO2','WATER',[fraction_CO2,fraction_H2O]};


% plot isobars
% p = [9000,18000,1.7906e4,1.7423e4,9.2293e3,9.0909e3];
p = [25000,50000];%,1.7906e4,1.7423e4,9.2293e3,9.0909e3];

% s,rho,h vs T
T = linspace(308,600,500);
s = zeros(length(T),length(p));
rho = zeros(length(T),length(p));
h = zeros(length(T),length(p));

for j = 1:length(p)
    for i = 1:length(T)
%         p(j)
%         T(i)
        [s(i,j), rho(i,j), h(i,j)] = refpropm('SDH','T',T(i),'P',p(j),substance{1},substance{2},substance{3});
    end
    
    s(:,j) = s(:,j)/1000;
    figure(1)
    plot(s(:,j),T)
    xlabel('Entropy [kJ/kg-K]','fontsize',18)
    ylabel('Temperature [K]','fontsize',18)
    hold on
    
    figure(2)
    plot(rho(:,j),T)
    xlabel('Density [kg/m^3]','fontsize',18)
    ylabel('Temperature [K]','fontsize',18)
    hold on
    
    h(:,j) = h(:,j)/1000;
    figure(3)
    plot(h(:,j),T)
    xlabel('Enthalpy [kJ/kg]','fontsize',18)
    ylabel('Temperature [K]','fontsize',18)
    hold on
end

% plot critical point
Tcrit = refpropm('T','C',0,'',0,substance{1},substance{2},substance{3});
Tcritvec = Tcrit*ones(2,1);

figure(1)
xlim = get(gca,'xlim');
plot(xlim,Tcritvec,'k')
legend({'p_l_o_w = 25 MPa','p_h_i_g_h = 50 MPa','Tcrit'},'location','northwest','fontsize',12)
grid on

figure(2)
xlim = get(gca,'xlim');
plot(xlim,Tcritvec,'k')
legend({'p_l_o_w = 25 MPa','p_h_i_g_h = 50 MPa','Tcrit'},'location','northeast','fontsize',12)
grid on

figure(3)
xlim = get(gca,'xlim');
plot(xlim,Tcritvec,'k')
legend({'p_l_o_w = 25 MPa','p_h_i_g_h = 50 MPa','Tcrit'},'location','northwest','fontsize',12)
grid on

% 
% % s,rho vs h
% T = linspace(308,600,500);
% 
% s = zeros(length(T),length(p));
% rho = zeros(length(T),length(p));
% 
% 
% for j = 1:length(p)
%     for i = 1:length(T)
% %         p(j)
% %         T(i)
%         [s(i,j), rho(i,j), h(i,j)] = refpropm('SDH','T',T(i),'P',p(j),substance{1},substance{2},substance{3});
%     end
%     h(:,j) = h(:,j)/1000;
%     
%     s(:,j) = s(:,j)/1000;
%     figure(4)
%     plot(s(:,j),h(:,j))
%     xlabel('s[kJ/kg-K]')
%     ylabel('h[kJ/kg]')
%     hold on
%     
%     figure(5)
%     plot(rho(:,j),h(:,j))
%     xlabel('rho[kg/m^3]')
%     ylabel('h[kJ/kg]')
%     hold on
%     
%     
% %     figure(6)
% %     plot(a(:,j),h(:,j))
% %     xlabel('ss [m/s]')
% %     ylabel('h[kJ/kg]')
% %     hold on
% end
% 
% % plot critical point
% hcrit = refpropm('H','C',0,'',0,substance{1},substance{2},substance{3});
% hcrit = hcrit/1000;
% hcritvec = hcrit*ones(i,1);
% 
% figure(4)
% plot(s(:,j),hcritvec,'k')
% legend('p1 = 9000 kPa','p2 = 18000 kPa','p3 = 17906 kPa','p4 = 17423 kPa','p5 = 9229 kPa','p6 = 9091 kPa','Tcrit','location','northwest')
% 
% figure(5)
% plot(rho(:,j),hcritvec,'k')
% legend('p1 = 9000 kPa','p2 = 18000 kPa','p3 = 17906 kPa','p4 = 17423 kPa','p5 = 9229 kPa','p6 = 9091 kPa','Tcrit','location','northeast')
% 
% % a vs h
% 
% T = linspace(500,600,500);
% a = zeros(length(T),length(p));
% 
% for j = 1:length(p)
%     for i = 1:length(T)
% %         p(j)
% %         T(i)
%         [a(i,j), h(i,j)] = refpropm('AH','T',T(i),'P',p(j),substance{1},substance{2},substance{3});
%     end
%     h(:,j) = h(:,j)/1000;
%   
%     figure(6)
%     plot(a(:,j),h(:,j))
%     xlabel('ss [m/s]')
%     ylabel('h[kJ/kg]')
%     hold on
% end
% 
% % plot critical point
% hcrit = refpropm('H','C',0,'',0,substance{1},substance{2},substance{3});
% hcrit = hcrit/1000;
% hcritvec = hcrit*ones(i,1);
% 
% figure(6)
% plot(a(:,j),hcritvec,'k')
% legend('p1 = 9000 kPa','p2 = 18000 kPa','p3 = 17906 kPa','p4 = 17423 kPa','p5 = 9229 kPa','p6 = 9091 kPa','Tcrit','location','east')
% 
