function [ s_cycle ] = TSDiagram( Tvector,pvector,fluid,mode,Tmin )
% plots a TS diagram 

% Inputs: 
% Tvector: vector of temperatures around cycle [K]
% pvector: vector of pressures around cycle [kPa]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% s_cycle: vector of enthalpies around the cycle [kJ/kg-K]

figure
set(0,'defaultAxesFontSize',14)
% plot isobars
p = [21000,18000,15000,12000,9000,6000];

% tf = strcmp('CO2',fluid);
% if tf == 1
%     Tmin = 240;
% elseif tf == 0
%     tf = strcmp('OXYGEN',fluid);
%     if tf == 1
%         Tmin = 60;
%     else
%     end
% end
% Tmin = 240;
T = linspace(Tmin,1100,1000);

for i = 1:length(p)
    [s,~,~] = getPropsTP(T,p(i),fluid,mode,2);
    s = s/1000;
    plot(s,T)
    xlabel('Entropy [kJ/kg-K]','fontsize',18)
    ylabel('Temperature [K]','fontsize',18)
    hold on
end
tf = iscell(fluid(1));
if tf == 1
    Tcrit = refpropm('T','C',0,' ',0,fluid{1},fluid{2},fluid{3});
else
    Tcrit = refpropm('T','C',0,' ',0,fluid);
end
Tcrit = floor(Tcrit);
% plot vapor dome
T_q = linspace(Tcrit,Tmin);
q = 1;
if mode == 2
    s_q = CO2_TQ(T_q,q,'entr');
elseif mode ==3
    s_q = zeros(1,length(T_q));
    tf = iscell(fluid(1));
    if tf == 1
        for i = 1:length(T_q)
            s_q(i) = refpropm('S','T',T_q(i),'Q',q,fluid{1},fluid{2},fluid{3});
        end
    else
        for i = 1:length(T_q)
            s_q(i) = refpropm('S','T',T_q(i),'Q',q,fluid);
        end
    end
    s_q = s_q/1000;
end

T_q2 = linspace(Tmin,Tcrit);
q2 = 0;
if mode == 2
    s_q2 = CO2_TQ(T_q2,q2,'entr');
elseif mode == 3
    s_q2 = zeros(1,length(T_q2));
    tf = iscell(fluid(1));
    if tf == 1
        for i = 1:length(T_q2)
            s_q2(i) = refpropm('S','T',T_q2(i),'Q',q2,fluid{1},fluid{2},fluid{3});
        end
    else
        for i = 1:length(T_q2)
            s_q2(i) = refpropm('S','T',T_q2(i),'Q',q2,fluid);
        end
    end
    s_q2 = s_q2/1000;
end

s_qtot = [s_q2, s_q];
T_qtot = [T_q2,T_q];
plot(s_qtot,T_qtot)

% text(3,850,'9000 kPa')
% text(3,900,'12000 kPa')
% text(3,950,'15000 kPa')
% text(3,1000,'18000 kPa')


% plot cycle
[s_cycle,~,~] = getPropsTP(Tvector,pvector,fluid,mode,2);
s_cycle = s_cycle/1000;
plot(s_cycle,Tvector,'k','LineWidth',1.5)

spoints = [s_cycle(1),s_cycle(2),s_cycle(24),s_cycle(26),s_cycle(27),s_cycle(49)];
Tpoints = [Tvector(1),Tvector(2),Tvector(24),Tvector(26),Tvector(27),Tvector(49)];
scatter(spoints,Tpoints,'k','filled')

legend({'21000 kPa','18000 kPa','15000 kPa','12000 kPa','9000 kPa','6000 kPa'},'location','northwest','fontsize',14)

text(spoints(1)+0.08,Tpoints(1)-8,'1','fontsize',14)
text(spoints(2)-0.13,Tpoints(2)+10,'2','fontsize',14)
text(spoints(3)-0.13,Tpoints(3)+10,'3','fontsize',14)
text(spoints(4)-0.13,Tpoints(4)-3,'4','fontsize',14)
text(spoints(5)+0.08,Tpoints(5)-8,'5','fontsize',14)
text(spoints(6)+0.08,Tpoints(6)-8,'6','fontsize',14)
end

