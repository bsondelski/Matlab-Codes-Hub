tic
p1=9000;
T4=1100;
PR_c=2;
A_panel=40;
T_amb=100;
fluid='CO2';
mode=2;

desiredPower=40000;

UA=fzero(@maxPowerMatch,10000,[],desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode);
[~,m_dot] = findMaxPower(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);




