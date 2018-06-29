% mass fraction of mixture that is H2O
figure
fraction_H2O = linspace(0,1,1000);
for i=1:length(fraction_H2O)
    x(1) = fraction_H2O(i);
    x(2) = 1-fraction_H2O(i);
    Tcrit(i) = refpropm('T','C',0,'',0,'Water','CO2',x);
end
plot(fraction_H2O,Tcrit)
xlabel('fraction of water in mixture')
ylabel('Critical Temperature [K]')
