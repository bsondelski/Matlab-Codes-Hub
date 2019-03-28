% plot recuperator vs reactor mass
clear

% set line colors so plot looks nice
co = [0.4940    0.1840    0.5560;
    0    0.4470    0.7410;
    0.4660    0.6740    0.1880;
    0    0.4470    0.7410;
    0.3010    0.7450    0.9330;
    0    0.4470    0.7410;
    0.6350    0.0780    0.1840;
    0    0.4470    0.7410;
    0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250];
set(groot,'defaultAxesColorOrder',co)

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
    [ UA_min,m_dotcycle_max ] = minimumUA(desiredPower,p1,T4,PR_c,A_panel,...
        T_amb,fluid,mode);
    UA_min = UA_min + 400;
    UA=UA_min:100 :UA_min+20000; % was 2022.3
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
    plot(q_reactor(6:end)/1000,mass_comb(5:end),'linewidth',1.3)
    hold on
    text(q_reactor(6)/1000 + 2, mass_comb(5) + 5,[num2str(A_panel) ' m^2'],'fontsize',14)
    xlabel('Reactor Heat Output [kW]','fontsize',18)
    ylabel('Combined Mass [kg]','fontsize',18)
    grid on
    xlim([90 220])
    ylim([1050 1400])
    
    [~,I] = min(mass_comb);
    
    if i == 1
       scatter(q_reactor(I+1)/1000,mass_comb(I),'k','filled') 
       text(q_reactor(I+1)/1000 + 3, mass_comb(1) - 30,'A','fontsize',14)
    else
        scatter(q_reactor(I+1)/1000,mass_comb(I),'k')
    end
    
    
    figure(2)
    if i == 1
        scatter(A_panel(1),mass_comb(I),'k','filled')
        text(A_panel(1) + 2, mass_comb(1) - 30,'A','fontsize',14)
    else
        scatter(A_panel(1),mass_comb(I),'k')
    end
    xlabel('Radiator panel area [m^2]','fontsize',18)
    ylabel('Combined Mass [kg]','fontsize',18)
    xlim([78 185])
    ylim([1050 1400])
    box on
    grid on
    hold on
    
    pause
end





