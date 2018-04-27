function [ s_cycle ] = TSDiagram( Tvector,pvector,fluid,mode )
% plots a TS diagram 

% Inputs: 
% Tvector: vector of temperatures around cycle [K]
% pvector: vector of pressures around cycle [kPa]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% s_cycle: vector of enthalpies around the cycle [kJ/kg-K]

figure

% plot isobars
p = [6000,9000,12000,15000,18000,21000];

tf = strcmp('CO2',fluid);
if tf == 1
    Tmin = 240;
elseif tf == 0
    tf = strcmp('OXYGEN',fluid);
    if tf == 1
        Tmin = 60;
    else
    end
end
    
T = linspace(Tmin,1100,1000);

for i = 1:length(p)
    [s,~,~] = getPropsTP(T,p(i),fluid,mode,2);
    s = s/1000;    
    plot(s,T)
    xlabel('s[kJ/kg-K]')
    ylabel('T[K]')
    hold on
end

Tcrit = refpropm('T','C',0,' ',0,fluid);
Tcrit = floor(Tcrit);
% plot vapor dome
T_q = linspace(Tcrit,Tmin);
q = 1;
if mode == 2
    s_q = CO2_TQ(T_q,q,'entr');
elseif mode ==3
    s_q = zeros(1,length(T_q));
    for i = 1:length(T_q)
        s_q(i) = refpropm('S','T',T_q(i),'Q',q,fluid);
    end
    s_q = s_q/1000;
end

T_q2 = linspace(Tmin,Tcrit);
q2 = 0;
if mode == 2
    s_q2 = CO2_TQ(T_q2,q2,'entr');
elseif mode == 3
    s_q2 = zeros(1,length(T_q2));
    for i = 1:length(T_q2)
        s_q2(i) = refpropm('S','T',T_q2(i),'Q',q2,fluid);
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
plot(s_cycle,Tvector,'k')

spoints = [s_cycle(1),s_cycle(2),s_cycle(24),s_cycle(26),s_cycle(27),s_cycle(49)];
Tpoints = [Tvector(1),Tvector(2),Tvector(24),Tvector(26),Tvector(27),Tvector(49)];
scatter(spoints,Tpoints)

legend('6000 kPa','9000 kPa','12000 kPa','15000 kPa','18000 kPa','21000 kPa','location','northwest')

text(spoints(1)+0.03,Tpoints(1)-5,'1')
text(spoints(2)-0.1,Tpoints(2)+5,'2')
text(spoints(3)-0.1,Tpoints(3)+5,'3')
text(spoints(4)-0.1,Tpoints(4)-5,'4')
text(spoints(5)+0.03,Tpoints(5)-5,'5')
text(spoints(6)+0.03,Tpoints(6)-5,'6')
end

