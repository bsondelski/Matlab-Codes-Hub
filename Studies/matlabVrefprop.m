

substance = {'CO2','WATER',[0.99,0.01]};
p = 18000;

% s,rho,h vs T
T = linspace(350,600,500);
s = zeros(length(T),length(p));
rho = zeros(length(T),length(p));
h = zeros(length(T),length(p));

% plot matlab data
for j = 1:length(p)
    for i = 1:length(T)
        [s(i,j), rho(i,j), h(i,j)] = refpropm('SDH','T',T(i),'P',p(j),substance{1},substance{2},substance{3});
    end
    
%     s(:,j) = s(:,j)/1000;
    figure(1)
    plot(s(:,j),T)
    xlabel('s[kJ/kg-K]')
    ylabel('T[K]')
    hold on
    
    figure(2)
    plot(rho(:,j),T)
    xlabel('rho[kg/m^3]')
    ylabel('T[K]')
    hold on
    
%     h(:,j) = h(:,j)/1000;
    figure(3)
    plot(h(:,j),T)
    xlabel('h[kJ/kg]')
    ylabel('T[K]')
    hold on
end

% critical point
Tcrit = refpropm('T','C',0,'',0,substance{1},substance{2},substance{3});
Tcritvec = Tcrit*ones(i,1);

% plot refprop data when props is a variable in matlab workspace containing
% data aquired from refprop GUI
figure(1)
plot(props(1:end,5),props(1:end,1))
plot(s(:,j),Tcritvec,'k')
legend('Matlab','Refprop','Tcrit','location','northwest')

figure(2)
plot(props(1:end,3),props(1:end,1))
plot(rho(:,j),Tcritvec,'k')
legend('Matlab','Refprop','Tcrit','location','northeast')

figure(3)
plot(props(1:end,4),props(1:end,1))
plot(h(:,j),Tcritvec,'k')
legend('Matlab','Refprop','Tcrit','location','northwest')


% % a vs T
%  
% T = linspace(500,600,500);
% a = zeros(length(T),length(p));
%  
% for j = 1:length(p)
%     for i = 1:length(T)
% %         p(j)
% %         T(i)
%         [a(i,j)] = refpropm('A','T',T(i),'P',p(j),substance{1},substance{2},substance{3});
%     end
%     h(:,j) = h(:,j)/1000;
%   
%     figure(6)
%     plot(a(:,j),T)
%     xlabel('ss [m/s]')
%     ylabel('T[K]')
%     hold on
% end
%  
% % plot critical point
% Tcrit = refpropm('T','C',0,'',0,substance{1},substance{2},substance{3});
% Tcritvec = Tcrit*ones(i,1);
%  
% figure(6)
% plot(props(1:334,6),props(1:334,1))
% plot(a(:,j),Tcritvec,'k')
% legend('Matlab','Refprop','Tcrit','location','east')



