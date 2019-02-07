% accuracy as a function of volumetric flow tolerance for turbine funciton
% add tolX as a function input for turbine funciton 
% add options = optimset('TolX',tolX); to turbine function
% add V_dot as an output to turbine function

m_dot = 0.75;
T_in = 1100;
p_in = 12000:1000:18000;
p_out = 9.22934933e3;
fluid = 'CO2';
mode = 2;
N = 2.8668254798e4;

tolX= [eps,logspace(-14,2, 17)];
for j = 1:length(p_in)
    for i = 1:length(tolX)
        tic
        for g = 1:10
            [p_out,T_out,D,Power,Ma,Anozzle,h2a,Vratio,V_dot(j,i)] = Turbine(m_dot,T_in,p_in(j),p_out,fluid,mode,N,tolX(i));
        end
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(p_in)
    VdotFracError(k,:) = (abs(V_dot(k,:)-V_dot(k,1))/V_dot(k,1));
end

figure
for k = 1:length(p_in)
    loglog(tolX(1,:),VdotFracError(k,:))
    xlabel('Volumetric Flow Error Tolerance')
    ylabel('Volumetric Flow Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(p_in)
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('Volumetric Flow Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end