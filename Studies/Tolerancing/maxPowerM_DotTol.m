% accuracy as a function of m_dot tolerance for findMaxPoer2 funciton

T4 = 1100;
p1 = 9000;
PR_c = 2;
UA = 5000:2000:15000;
A_panel = 100;
T_amb = 100;
fluid = 'CO2';
mode = 2;

tolX= [eps,logspace(-14,2, 17)];
for j = 1:length(UA)
    for i = 1:length(tolX)
        tic
        options = optimset('TolX',tolX(i));
        [max_power,m_dot(j,i)] = findMaxPower2(p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,options);
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(UA)
    mdotFracError(k,:) = (abs(m_dot(k,:)-m_dot(k,1))/m_dot(k,1));
end

figure
for k = 1:length(UA)
    loglog(tolX(1,:),mdotFracError(k,:))
    xlabel('m_d_o_t Error Tolerance')
    ylabel('m_d_o_t Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(UA)
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('m_d_o_t Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end