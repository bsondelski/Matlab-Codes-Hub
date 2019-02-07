clear
%%for plotting error!!!
T4=1000;
p1=9000;
m_dot=1.5;
fluid='CO2';
UA=1220;
mode=2;
PR=2;
A_panel=12;
T_amb=100;


T=240:T4;

for i=1:length(T)
    try
        err(i) = simpleCycleError(T(i),m_dot,p1,T4,PR,UA,A_panel,T_amb,fluid,mode);
    catch
        err(i)=100;
    end
end


plot(T,err)
title('err')