substance = {'CO2','WATER',[0.90,0.10]};


% % plot isobars
% p = [9000,18000,1.7906e4,1.7423e4,9.2293e3,9.0909e3];
% 
% % s,rho,h vs T
% T = linspace(308,1100,1000);
% s = zeros(length(T),length(p));
% rho = zeros(length(T),length(p));
% h = zeros(length(T),length(p));
% 
% for j = 1:length(p)
%     for i = 1:length(T)
% %         p(j)
% %         T(i)
%         [s(i,j), rho(i,j), h(i,j)] = refpropm('SDH','T',T(i),'P',p(j),substance{1},substance{2},substance{3});
%     end
%     
%     s(:,j) = s(:,j)/1000;
%     figure(1)
%     plot(s(:,j),T)
%     xlabel('s[kJ/kg-K]')
%     ylabel('T[K]')
%     hold on
%     
%     figure(2)
%     plot(rho(:,j),T)
%     xlabel('rho[kg/m^3]')
%     ylabel('T[K]')
%     hold on
%     
%     h(:,j) = h(:,j)/1000;
%     figure(3)
%     plot(h(:,j),T)
%     xlabel('h[kJ/kg]')
%     ylabel('T[K]')
%     hold on
% end




% figure
% p = 18000;
% T = linspace(308,1100,1000);
% 
% for i = 1:length(T)
%         [h(i)] = refpropm('H','T',T(i),'P',p,substance{1},substance{2},substance{3});
% end
% h = h/1000;
% 
% plot(h,T)
% hold on
% 
% difference = h(1:(length(T)-1))-h(2:length(T));
% 
% inds = find(abs(difference)>10);
% 
% for i=1:(length(inds)/2)
%     h(inds(1):inds(2)) = [];
%     T(inds(1):inds(2)) = [];
%     
%     correction = inds(2) - inds(1);
%     inds(1:2) = [];
%     inds = inds - correction;
% end
% 
% plot(h,T)
% 
% poly = polyfit(h,T,2);
% hvals = linspace(h(1),h(end),1000);
% 
% %     hval = poly(1)*Tplot.^6 + poly(2)*Tplot.^5 + poly(3)*Tplot.^4 + poly(4)*Tplot.^3 + poly(5)*Tplot.^2 + poly(6)*Tplot + poly (5);
%     Tplot = poly(1)*hvals.^2 + poly(2)*hvals + poly(3);
% 
% plot(hvals,Tplot,'k')
% xlabel('h [kJ/kg]')
% ylabel('T [K]')
% legend('original','valid data','polynomial','location','northwest')

figure
p = 18000;
T = linspace(350,1100,1000);

for i = 1:length(T)
        [h(i)] = refpropm('H','T',T(i),'P',p,substance{1},substance{2},substance{3});
end
h = h/1000;

plot(h,T)
hold on

difference = h(1:(length(T)-1))-h(2:length(T));

inds = find(abs(difference)>10);

for i=1:(length(inds)/2)
    h(inds(1):inds(2)) = [];
    T(inds(1):inds(2)) = [];
    
    correction = inds(2) - inds(1);
    inds(1:2) = [];
    inds = inds - correction;
end

plot(h,T)

poly = polyfit(h,T,2);
hvals = linspace(h(1),h(end),1000);

%     hval = poly(1)*Tplot.^6 + poly(2)*Tplot.^5 + poly(3)*Tplot.^4 + poly(4)*Tplot.^3 + poly(5)*Tplot.^2 + poly(6)*Tplot + poly (5);
    Tplot = poly(1)*hvals.^2 + poly(2)*hvals + poly(3);

plot(hvals,Tplot,'k')
xlabel('h [kJ/kg]')
ylabel('T [K]')
legend('original','valid data','polynomial','location','northwest')