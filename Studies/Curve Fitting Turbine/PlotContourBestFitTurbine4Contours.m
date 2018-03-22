clear
ns=0:0.01:2;
ds=1:0.01:15;

logds=log10(ds);
logns=log10(ns);

for i=1:length(logns)
    if logns(i)>0.06
        eff_max(i)=0.6865*0.1497^logns(i);
    elseif logns(i)<-0.8392
        eff_max(i)=1.436*2.349^logns(i);
    else
        eff_max(i)=0.695455-1.47518*logns(i)+0.0529263*logns(i)^2+21.3801*logns(i)^3+56.9767*logns(i)^4+58.1086*logns(i)^5+20.8809*logns(i)^6;
        
    end
end


for i=1:length(logns)
    if logns(i)>0.065
        middle(i)=-0.702209532478022*logns(i)+0.371756558699681;
    elseif logns(i)<-1
        middle(i)=-0.625631000000001*logns(i)+0.475997999999999;
%         x1=-1;
%         slope=-0.629575-2*0.381976*x1-3*1.73486*x1^2-4*0.991895*x1^3+5*1.07147*x1^4+6*0.813393*x1^5;
%         y1=0.369142-0.629575*x1-0.381976*x1^2-1.73486*x1^3-0.991895*x1^4+1.07147*x1^5+0.813393*x1^6;
%         yb=-slope*x1+y1
%         middle(i)=slope*(logns(i)-x1)+y1;
    else
        middle(i)=0.369142-0.629575*logns(i)-0.381976*logns(i)^2-1.73486*logns(i)^3-0.991895*logns(i)^4+1.07147*logns(i)^5+0.813393*logns(i)^6;
    end
end



for i=1:length(logns)
    if logns(i)>-0.045
        stdeviation(i)=0.175353691653290;
    elseif logns(i)<-1
        stdeviation(i)=0.229935999999995;
    else
        stdeviation(i)=0.165216-0.39868*logns(i)-4.93956*logns(i)^2-26.6755*logns(i)^3-58.8628*logns(i)^4-56.5442*logns(i)^5-19.7513*logns(i)^6;
    end
end

lns=length(ns);
lds=length(ds);

efficiency=zeros(lds,lns);
for j=1:lds
    efficiency(j,:)=eff_max.*exp(-(logds(j)-middle).^2./stdeviation.^2);
end

figure
v=[0.6, 0.7, 0.8, 0.9];
% [C,h] = contour(ns,ds,efficiency,v,'LineWidth',1.5,'LineStyle','none');
[C,h] = contour(ns,ds,efficiency,v,'LineWidth',1.5);
xlim([0.08 2]);
ylim([1 20]);
xlabel('Specific Speed')
ylabel('Specific Diameter')
colorbar
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
grid on
% set(gca, 'color', 'none')
% clabel(C,'manual','FontSize',16);

%%%%%% plot centerline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
pause

Middle=10.^middle;
plot(ns,Middle,'LineWidth',2)