function [ m_dotmin,m_dotmax ] = SpecifiedPowerBound(power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)
%UNTITLED4 Summary of this function goes here
%Detailed explanation goes here

m_dotmin = 0.6;
m_dotmax = 2;
errorP = zeros(1,16);

interval=(m_dotmax-m_dotmin)/60;
m_dot=m_dotmin:interval:m_dotmax;

for j=1:length(m_dot)
    try
        [errorP(j)]=specifiedPowerError(m_dot(j),power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    catch
        errorP(j)=NaN;
    end
end
m_dot
errorP
P=polyfit(m_dot,errorP,5);
slope=polyder(P);
zers=roots(slope);
m_dotmax=min(zers);
slopeVals=polyval(slope,m_dot);


% [~,I]=max(errorP);
% m_dotmax=m_dot(I);
end

