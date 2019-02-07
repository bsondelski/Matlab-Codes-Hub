% plot recuperator vs reactor mass
clear

set(0,'defaultAxesFontSize',14)

p1=9000;
T4=900;
PR_c=2;
A_panel=175;
T_amb=200;
fluid='CO2';
mode=2;
desiredPower = 40000;
NucFuel = 'UO2';

% A_panelArray = [175 150 125 100 86 83 80];

A_panelArray = [175 160 150 140];

for i = 1:length(A_panelArray)
    A_panel = A_panelArray(i)
    [ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
        T_amb,fluid,mode);
    UA_min = UA_min + 400;
    UA=UA_min:500 :UA_min+20000; % was 2022.3
    m_dotlast(1) = m_dotcycle_max;
    
    [net_power,~,~,~,~,~,~,q_reactor(1),...
        ~,~,~,~,~,~,~,~,~,~,~,~,~,T5(1),...
        ~,~,~,~,~] = BraytonCycle(m_dotcycle_max,p1,T4,PR_c,UA_min,...
        A_panel,T_amb,fluid,mode,0);
    
    options = [];
    for j=1:(length(UA)-1)
        UA(j)
        [~,~,~,~,~,~,q_reactor(j+1),...
            ~,~,m_dotlast(j+1),T3(j+1),p3,T4out(j+1),p4,T5(j+1),p5,~,p2,~,~] =...
            SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j+1),A_panel,T_amb,fluid,mode,m_dotlast(j),options);
        
        mass_reactor(j) = ReactorMass(q_reactor(j+1),m_dotlast(j+1),p3,p4,T3(j+1),T4out(j+1),fluid,NucFuel);
        mass_recuperator(j) = RecuperatorMass( p2,T5(j),p5,'IN',UA(j),fluid,mode );
    end
    A_panel_i = ones(1,length(mass_reactor))*A_panel;
    mass_radiator = A_panel_i*6.75;
    mass_comb = mass_reactor + mass_recuperator + mass_radiator;
    
    figure(1)
    plot(q_reactor(2:end)/1000,mass_comb,'linewidth',1.3)
    hold on
    text(q_reactor(2)/1000 + 2, mass_comb(1) + 5,[num2str(A_panel) ' m^2'],'fontsize',14)
    xlabel('Reactor Heat Output [kW]','fontsize',18)
    ylabel('Combined Mass [kg]','fontsize',18)
    grid on
    xlim([90 220])
    ylim([1050 1400])
    
    [~,I] = min(mass_comb);
    figure(2)
    scatter(A_panel(1),mass_comb(I),'k')
    xlabel('Radiator panel area [m^2]')
    ylabel('Combined Mass [kg]')
    xlim([78 185])
    ylim([1050 1400])
    box on
    grid on
    hold on
    
%     pause
end





