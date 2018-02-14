% accuracy as a function of UA tolerance for maxPowerMatch funciton
% add tolX as a function input for maxPowerMatch funciton 
% add options2 = optimset('TolX',tolX); to maxPowerMatch function


A_panel = 60:10:110;
T_amb = 100;
desiredPower = 40000;
p1 = 9000;
T4 = 1100;
PR_c = 2;
fluid = 'CO2';
mode = 2;

tolX= [eps,logspace(-14,2, 17)];
for j = 1:length(A_panel)
    for i = 1:length(tolX)
        tic
        [ UA(j,i),m_dot ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel(j),...
    T_amb,fluid,mode,tolX(i));
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(A_panel)-1
    UAFracError(k,:) = (abs(UA(k,:)-UA(k,1))/UA(k,1));
end

figure
for k = 1:length(A_panel)-1
    loglog(tolX(1,:),UAFracError(k,:))
    xlabel('UA Error Tolerance')
    ylabel('UA Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(A_panel)-1
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('UA Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end