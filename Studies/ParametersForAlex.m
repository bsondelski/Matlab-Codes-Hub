







% function inputs in future
p1 = 9000;
T4 = 1100;
PR_c = 2;
A_panel = 50:10:150;
T_amb = 100;
fluid = 'CO2';
mode = 2;
desiredPower = 40000; % [W]


for i=1:length(A_panel)
    
    
    % find minimum UA which gives desired power output
    [ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel(i),...
        T_amb,fluid,mode);
    
    UA = linspace(UA_min,UA_min+4000,11);
    
    options = [];
    for j = 1:length(UA)
        [net_power,cyc_efficiency(j,i),D_T,D_c,Ma_T,Ma_c,q_reactor(j,i),...
            q_rad,T1,m_dot(j,i),T3(j,i),p3(j,i),T4_out(j,i),p4(j,i)] =...
            SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j),A_panel(i),T_amb,fluid,mode,m_dotcycle_max,options);
        UA_output(j,i) = UA(j);
        A_panel_output(j,i) = A_panel(i)
    end
    
end
%surface plot
figure
UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
surf(A_panel_output,UA_output/1000,q_reactor/1000)
xlabel('A_p_a_n_e_l [m^2]')
ylabel('UA [W/K]')
zlabel('q_r_e_a_c_t_o_r [kW]')

% for Alex
T3_new = T3(:);
T4_new = T4_out(:);
p3_new = p3(:);
p4_new = p4(:);
m_dot_new = m_dot(:);
cyc_efficiency_new = cyc_efficiency(:);
q_reactor_new = q_reactor(:);
UA_new = UA_output(:);
A_panel_new = A_panel_output(:);

mass_reactor = 0.00131*q_reactor_new+100;
mass_recuperator = 0.0131*UA_new; %convert to kW/K
mass_radiator = 5.8684*A_panel_new;
mass_total_estimated = mass_reactor+mass_recuperator+mass_radiator;

mass_reactor_new = 3.61503312e-4*q_reactor_new+100;
mass_total_thermal = mass_reactor_new+mass_recuperator+mass_radiator;

T = table(T3_new,T4_new,p3_new,p4_new,m_dot_new,cyc_efficiency_new,q_reactor_new,UA_new,A_panel_new,mass_total_estimated,mass_total_thermal);


% T3_new = transpose(T3);
% T4_new = transpose(T4_out);
% p3_new = transpose(p3);
% p4_new = transpose(p4);
% m_dot_new = transpose(m_dot);
% cyc_efficiency_new = transpose(cyc_efficiency);
% q_reactor_new = transpose(q_reactor);
% T = table(T3_new,T4_new,p3_new,p4_new,m_dot_new,cyc_efficiency_new,q_reactor_new);

writetable(T,'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Simple Brayton Cycle\CycleParameters.txt','Delimiter','\t')




