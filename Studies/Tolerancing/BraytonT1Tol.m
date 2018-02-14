% accuracy as a function of T1 tolerance for BraytonCycle funciton
% add tolX as a function input for BraytonCycle funciton 
% add options = optimset('TolX',tolX); to BraytonCycle function

m_dot = 0.75;
T4 = 1100;
p1 = 9000;
PR_c = 2;
UA = 5000:1000:15000;
A_panel = 100;
T_amb = 100;
fluid = 'CO2';
mode = 2;

tolX= [eps,logspace(-14,2, 17)];
for j = 1:length(UA)
    for i = 1:length(tolX)
        tic
        for g = 1:10
            [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1(j,i),Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA(j),...
    A_panel,T_amb,fluid,mode,0,tolX(i));
        end
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(UA)
    T1FracError(k,:) = (abs(T1(k,:)-T1(k,1))/T1(k,1));
end

figure
for k = 1:length(UA)
    loglog(tolX(1,:),T1FracError(k,:))
    xlabel('T1 Error Tolerance')
    ylabel('T1 Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(UA)
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('T1 Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end