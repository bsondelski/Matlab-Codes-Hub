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
colormap(cool)
v1=[0.5, 0.6, 0.7, 0.75, 0.8, 0.85];
contour(ns,ds,efficiency,v1,'LineWidth',1);
hold on
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

pause
logns=log10(ns);

for i = 1:length(logns)
    if logns(i) > 1.4
        middle(i) = 0.076445106688;
    elseif logns(i) < -0.79
        middle(i) = -0.643301783584803*logns(i)+0.706787306595485;
    else
        middle(i) = 0.488977-0.426379*logns(i)+0.638746*logns(i)^2-0.637014*logns(i)^3-...
            0.249812*logns(i)^4+0.580012*logns(i)^5-0.196472*logns(i)^6;
    end
end

actualMiddle=10.^middle;
plot(ns,actualMiddle,'LineWidth',2)

pause
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
contour(ns,ds,efficiency,v1,'b','LineWidth',1);
hold on
contour(ns,ds,efficiency,v2,'--b','LineWidth',1);
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

pause
logns=log10(ns);

for i = 1:length(logns)
    if logns(i) > 0.065
        middle(i) = -0.702209532478022*logns(i)+0.371756558699681;
    elseif logns(i) < -1
        middle(i) = -0.625631000000001*logns(i)+0.475997999999999;
    else
        middle(i) = 0.369142-0.629575*logns(i)-0.381976*logns(i)^2-1.73486*logns(i)^3-...
            0.991895*logns(i)^4+1.07147*logns(i)^5+0.813393*logns(i)^6;
    end
end

actualMiddle=10.^middle;
plot(ns,actualMiddle,'b','LineWidth',2)