% mass fraction of mixture that is H2O
clear

set(0,'defaultAxesFontSize',12)

figure

%array of mol fractions
molfraction_H2O = linspace(0,1,1000);

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

% frac_sum = fraction_H2O + fraction_CO2


for i=1:length(fraction_H2O)
    x(1) = fraction_H2O(i);
    x(2) = 1-fraction_H2O(i);
    Tcrit(i) = refpropm('T','C',0,'',0,'Water','CO2',x);
end
plot(molfraction_H2O,Tcrit,'k')
xlabel('Mole Fraction H_2O','fontsize',18)


ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.1325*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
ylabel('Critical Temperature [K]','fontsize',18)
grid on

% fraction_H2O = linspace(0.01,0.99,50);
for i=1:length(fraction_H2O)
    x(1) = fraction_H2O(i);
    x(2) = 1-fraction_H2O(i);
    pcrit(i) = refpropm('p','C',0,'',0,'Water','CO2',x);
end
pcrit = pcrit';

figure
plot(molfraction_H2O,pcrit./1000,'k')
xlabel('Mole Fraction H_2O','fontsize',18)

ylim = get(gca,'ylim');
yLabLoc = ylim(1)-0.1325*(ylim(2)-ylim(1));
text(-0.05,yLabLoc,'(CO_2)','fontsize',12)
text(0.95,yLabLoc,'(H_2O)','fontsize',12)
ylabel('Critical Pressure [MPa]','fontsize',18)
grid on