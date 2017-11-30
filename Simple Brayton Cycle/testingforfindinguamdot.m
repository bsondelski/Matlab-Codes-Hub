
p1=9000;
T4=1100;
PR_c=2;
A_panel=50:20:150;
T_amb=100;
fluid='CO2';
mode=2;

desiredPower=40000;
for i=1:length(A_panel)
UA(i)=fzero(@maxPowerMatch,10000,[],desiredPower,p1,T4,PR_c,A_panel(i),T_amb,fluid,mode);
[~,m_dot(i)] = findMaxPower(p1,T4,PR_c,UA(i),A_panel(i),T_amb,fluid,mode);
end

