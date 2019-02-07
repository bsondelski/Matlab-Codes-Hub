% plots cycle power output vs reactor heat output for various UA values
clear

set(0,'defaultAxesFontSize',14)

% set line colors so plot looks nice
co = [0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840;
    0    0.4470    0.7410;
    0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250];
set(groot,'defaultAxesColorOrder',co)


plotMode = 1;
% 1: single line
% 2: upper lines
% 3: lower lines
% 4: exact power
% 5: with 40 kW line


p1=9000;
T4=900;
PR_c=2;
A_panel=175;
T_amb=200;
fluid='CO2';
mode=2;

if plotMode == 1
    UA=[4000];
elseif plotMode == 2
    UA=[4000, 5000:1000:8000];
elseif plotMode == 3
    UA=[4000, 5000:1000:8000, 1000:1000:3000];
elseif plotMode == 4 || plotMode == 5 
    UA=[4000, 5000:1000:8000, 1000:1000:2000, 2.9335e+03];
end

m_dot=0.5:0.05:3;

figure

for j=1:length(UA)
    UA(j)
    for i=1:length(m_dot)
        m_dot(i)
        [net_power(i),~,~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
    end
    options = [];
    [max_power(j),m_dotmax(j)] = findMaxPower2(p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,options);
    [~,~,~,~,~,~,~,q_reactormax(j),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dotmax(j),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
    
    
%     if j == length(UA) || UA(j) == 2000
%         inds = q_reactor/1000 > 950;
%         q_reactor(inds) = [];
%         net_power(inds) = [];
%     elseif UA(j) == 1000
%         inds = q_reactor/1000 > 990;
%         q_reactor(inds) = [];
%         net_power(inds) = [];
%     elseif j == 3
%         inds = q_reactor/1000 > 900;
%         q_reactor(inds) = [];
%         net_power(inds) = [];
%     else
%     end

%     if plotMode == 3 && UA(j) == UA(end) || plotMode == 4 && UA(j) == UA(end) || plotMode == 5 && UA(j) == UA(end)
%         plot(q_reactor/1000,net_power/1000,'Color',[0.9290    0.6940    0.1250])
%     else
%         plot(q_reactor/1000,net_power/1000)
%     end
    
    plot(q_reactor/1000,net_power/1000)
    
    if UA(j) == 7000 || UA(j) == 8000
        text(q_reactor(end)/1000+10,net_power(end)/1000+1,[num2str(UA(j)/1000) ' kW/K'])
    else
        text(q_reactor(end)/1000+10,net_power(end)/1000,[num2str(UA(j)/1000) ' kW/K'])
    end
    
    hold on
end

if plotMode == 5
    % with line
    plot([0,1200],[40,40],'k')
end

if plotMode == 4 || plotMode == 5
    h1 = scatter(q_reactormax/1000,max_power/1000,'k');
    h2 = scatter(q_reactormax(end)/1000,max_power(end)/1000,'filled','k');
    legend([h1 h2],{'Peak Power','40 kW Power Output'})
else
    h1 = scatter(q_reactormax/1000,max_power/1000,'k');
    legend(h1,'Peak Power')
end

ylim([10 58])
xlim([0 1000])
xlabel('Reactor Heat Output [kW]')
ylabel('Cycle Power Output [kW]')
grid on
box on

