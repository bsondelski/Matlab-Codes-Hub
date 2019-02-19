%%%%%%%%%%%%%%%%%%%%%%%% compressor %%%%%%%%%%%%%%%%%%%%%%%
ns=0:0.01:30;
ds=0:0.01:20;

% [nsg,dsg] = meshgrid(ns,ds);
% logds=log10(ds);
% logns=log10(ns);

% [ efficiency, ~ ] = compressorEfficiencyOld( nsg, dsg );

for i = 1:length(ns)
    for j = 1:length(ds)
        [ efficiency(j,i), ~ ] = compressorEfficiency( ns(i), ds(j) );
    end
end



figure
v1=[0.5, 0.7, 0.8];
v2=[0.6, 0.75, 0.85];
contour(ns,ds,efficiency,v1,'k','LineWidth',1);
hold on
contour(ns,ds,efficiency,v2,'--k','LineWidth',1);
% clabel(cs,hh)
% contour(ns,ds,efficiency,v,'LineWidth',1.5,'LineStyle','none')
xlim([0.1 30]);
ylim([0.1 20]);
xlabel('Specific Speed','fontsize',18)
ylabel('Specific Diameter','fontsize',18)
% colorbar
set(gca, 'YScale', 'log') 
set(gca, 'XScale', 'log')
grid on



%%%%%%%%%%%%%%%%% turbine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
ns=0:0.01:2;
ds=1:0.01:15;


for i = 1:length(ns)
    for j = 1:length(ds)
        [ efficiency(j,i), ~ ] = turbineEfficiency( ns(i), ds(j) );
    end
end



figure
v1=[0.6, 0.8];
v2=[0.7, 0.9];
contour(ns,ds,efficiency,v1,'k','LineWidth',1);
hold on
contour(ns,ds,efficiency,v2,'--k','LineWidth',1);
% clabel(cs,hh)
% contour(ns,ds,efficiency,v,'LineWidth',1.5,'LineStyle','none')
xlim([0.08 2]);
ylim([1 20]);
xlabel('Specific Speed','fontsize',18)
ylabel('Specific Diameter','fontsize',18)
% colorbar
set(gca, 'YScale', 'log') 
set(gca, 'XScale', 'log')
grid on