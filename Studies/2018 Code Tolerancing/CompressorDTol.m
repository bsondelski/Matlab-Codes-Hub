% accuracy as a function of diameter tolerance for compressor funciton
% add tolX as a function input for Compressor funciton and for compressorPsiError
% add options = optimset('TolX',tolX); to compressorPsiError function

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
            [T_out,D(j,i),N,Power,Ma,h2a] = Compressor(m_dot,T_in,p_in(j),p_out,fluid,mode,tolX(i));
        end
        t(j,i) = toc;
    end
end
t=t./10;

for k = 1:length(p_in)
    DFracError(k,:) = (abs(D(k,:)-D(k,1))/D(k,1));
end

figure
for k = 1:length(p_in)
    loglog(tolX(1,:),DFracError(k,:))
    xlabel('Diameter Error Tolerance')
    ylabel('Diameter Fractional Error')
    grid on
    hold on
end

figure
for k = 1:length(p_in)
    plot(tolX(1,:),t(k,:))
    set(gca, 'XScale', 'log')
    xlabel('Diameter Error Tolerance')
    ylabel('Average Time to Run Function')
    grid on
    hold on
end