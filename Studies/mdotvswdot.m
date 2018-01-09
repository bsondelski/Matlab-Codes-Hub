
p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=40;
T_amb=100;
fluid='CO2';
mode=2;
UA=5000;
m_dot=0.05:0.25:3.75;

figure
hold on
for j=1:length(UA)
    UA(j)
    for i=1:length(m_dot)
        m_dot(i)
        [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
    end
    plot(m_dot,net_power)
    
end

