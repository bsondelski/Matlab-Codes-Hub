function [ errorP ] = ErrorPlot_PowerSpecification(power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

m_dotmin=0.3;
m_dotmax=5;



interval=(m_dotmax-m_dotmin)/15;
m_dot=m_dotmin:interval:m_dotmax;
errorP=zeros(1,length(m_dot));     %allocate a vector
for j=1:length(m_dot)
    try
        m_dot(j)
        [errorP(j)]=specifiedPowerError(m_dot(j),power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    catch
        errorP(j)=NaN;
    end
end



plot(m_dot,errorP)
% figure
% plot(m_dot,net_power)
% m=error.*net_power;
% figure
% plot(m_dot,m)


end

