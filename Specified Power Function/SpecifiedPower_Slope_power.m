function [ P ] = SpecifiedPower_Slope_power(power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

m_dotmin=0.3;
m_dotmax=5;
interval=(m_dotmax-m_dotmin)/15;
m_dot=m_dotmin:interval:m_dotmax;
errorP=zeros(1,length(m_dot));     %allocate a vector
net_power=zeros(1,length(m_dot));

for j=1:length(m_dot)
    try
        [errorP(j)]=specifiedPowerError(m_dot(j),power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
        [net_power(j),~,~,~,~,~,~,~,~,~,~,~,~,~]=BraytonCycle(m_dot(j),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    catch
        errorP(j)=NaN;
        net_power(j)=NaN;
    end
end

P=polyfit(m_dot,errorP,2);
Test=polyval(P,m_dot);
answers=roots(P)
slope=polyder(P);
limits=roots(slope)
zer=min(limits)
slopeVals=polyval(slope,m_dot);

Gre=slopeVals.*net_power;

plot(m_dot,errorP,m_dot,Test)
figure 
plot(m_dot,slopeVals);
figure
plot(m_dot,Gre)
end

