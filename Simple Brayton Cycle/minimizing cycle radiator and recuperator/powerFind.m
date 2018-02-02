function [ net_power ] = powerFind( m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)

[net_power,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] =...
    BraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);

net_power = -net_power;

end

