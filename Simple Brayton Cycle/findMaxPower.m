function [max_power,m_dot] = findMaxPower(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)
%find maximum power output and corresponding mass flow rate for a given
%conductance and other system parameters


m_dot=[0.5, 2, 3.5];
err=1;
%use quadratic approximation method to find max w_dot 
while err>0.001
    for i=1:length(m_dot)
        [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    end
    
    p=polyfit(m_dot,net_power,2);
    d=[2*p(1), p(2)];                   %derivative of polynomial
    m_middle=-d(2)/d(1);                %set derivative = 0
    [net_power_middle,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_middle,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    m_dot_new=[m_dot, m_middle];                    %m_dot vector including new point
    net_power_new=[net_power, net_power_middle];    %net power vector including new point
    
    [~,inde]=min(net_power_new);        %find location of minimum power                
    m_dot_new(inde)=[];                 %new m_dot vector excluding m_dot with lowest power
    m_dot=m_dot_new;
    err=max(m_dot)-min(m_dot);          %difference between end points
end

%exclude minimum m_dot from vector
[~,inde_min]=min(m_dot);
m_dot(inde_min)=[];
%exclude maximum m_dot from vector
[~,inde_max]=max(m_dot);
m_dot(inde_max)=[];
%find max net power
[max_power,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);


end

