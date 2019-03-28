A_panel = 18:5:40;
UA = 10000:2000:90000;
T_amb = 200;
fluid = {'CO2','H2O','50','50'};
% mode = 2;
p1 = 25000;
T4 = 1100;
PR_c = 2;
options = [];

for i = 1:length(A_panel)
    parfor j = 1:length(UA)
        [maxPower(j),~] = findMaxPowerGivenUA(p1,T4,PR_c,UA(j),A_panel(i),T_amb,fluid,mode,options);
    end
    plot(UA,maxPower)
    hold on
    text(UA(end)+100,maxPower(end),{'A_p_a_n_e_l = ',num2str(A_panel(i))})
end

    
    