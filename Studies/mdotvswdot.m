
p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=100;
T_amb=100;
fluid='CO2';
mode=2;
UA=4000:2000:19000;
m_dot=0.15:0.25:4;

hold on
for j=1:length(UA)
    UA(j)
    for i=1:length(m_dot)
        [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
    end
    plot(m_dot,net_power)
    
end

