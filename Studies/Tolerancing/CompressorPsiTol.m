% accuracy as a function of psi tolerance for compressor funciton
% add tolX as a function input for Compressor funciton 
% add options = optimset('TolX',tolX); to compressor function
% add psi as an output

m_dot = 0.75;
T_in = 350;
p_in = 7500:500:12000;
p_out = 18000;
fluid = 'CO2';
mode = 2;

tolX= [eps,logspace(-14,2, 17)];
for j = 1:length(p_in)
    for i = 1:length(tolX)
        tic
        for g = 1:10
            [T_out,psi(j,i),N,Power,Ma,h2a] = Compressor(m_dot,T_in,p_in(j),p_out,fluid,mode,tolX(i));
        end
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(p_in)
    PsiFracError(k,:) = (abs(psi(k,:)-psi(k,1))/psi(k,1));
end

figure
for k = 1:length(p_in)
    loglog(tolX(1,:),PsiFracError(k,:))
    xlabel('Psi Error Tolerance')
    ylabel('Psi Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(p_in)
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('Psi Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end