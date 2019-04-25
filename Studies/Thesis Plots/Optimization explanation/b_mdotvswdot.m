% plots cycle power output vs reactor heat output for various UA values

clear

p1=9000;
T4=900;
PR_c=2;
A_panel=175;
T_amb=200;
fluid='CO2';
mode=2;
UA=[1000:1000:2000, 2.9335e+03, 4000:1000:8000];
m_dot=0.35:0.05:3;

figure
for j=1:length(UA)
    UA(j)
    for i=1:length(m_dot)
        m_dot(i)
        [net_power(i),~,~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
    end
    options = [];
    [max_power(j),m_dotmax(j)] = findMaxPowerGivenUA(p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,options);
    [~,~,~,~,~,~,~,q_reactormax(j),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dotmax(j),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
    
    if j == length(UA) || UA(j) == 2000
    inds = q_reactor/1000 > 950;
    q_reactor(inds) = [];
    net_power(inds) = [];
    elseif UA(j) == 1000
    inds = q_reactor/1000 > 990;
    q_reactor(inds) = [];
    net_power(inds) = [];
    elseif j == 3
    inds = q_reactor/1000 > 900;
    q_reactor(inds) = [];
    net_power(inds) = [];        
    else
    end    
    
    plot(q_reactor/1000,net_power/1000)
    if j == 7 || j == 8
        text(q_reactor(end)/1000+10,net_power(end)/1000+1,[num2str(UA(j)/1000) ' kW/K'])
    else
    text(q_reactor(end)/1000+10,net_power(end)/1000,[num2str(UA(j)/1000) ' kW/K'])
    end
    
    hold on
end
xlabel('Reactor Heat Output [kW]')
ylabel('Cycle Power Output [kW]')
grid on

% with line
plot([0,1200],[40,40],'k')
h1 = scatter(q_reactormax/1000,max_power/1000,'k');
h2 = scatter(q_reactormax(3)/1000,max_power(3)/1000,'filled','k');
legend([h1 h2],{'Peak Power','40 kW Power Output'})
% legend([h1],{'Peak Power'})

ylim([10 58])
xlim([0 1000])

