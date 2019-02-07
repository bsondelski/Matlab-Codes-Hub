% accuracy as a function of enthalpy tolerance for radiator funciton
% add tolX as a function input for radiator funciton 
% add options = optimset('TolX',tolX); to radiator function
% add h_out as an output

m_dot = 0.75;
A_panel = 60:10:120;
T_amb = 100;
T_in = 476;
p_in = 9090.909090;
p_out = 9000;
fluid = 'CO2';
mode = 2;

tolX= [eps,logspace(-14,2, 17)];
for j = 1:length(A_panel)
    for i = 1:length(tolX)
        tic
        for g = 1:10
            [q_rad,T_out,~,h_out(j,i)] = Radiator(m_dot,A_panel(j),T_amb,T_in,p_in,p_out,fluid,mode,tolX(i));
        end
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(A_panel)
    houtFracError(k,:) = (abs(h_out(k,:)-h_out(k,1))/h_out(k,1));
end

figure
for k = 1:length(A_panel)
    loglog(tolX(1,:),houtFracError(k,:))
    xlabel('Outlet Enthalpy Error Tolerance')
    ylabel('Outlet Enthalpy Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(A_panel)
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('Outlet Enthalpy Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end