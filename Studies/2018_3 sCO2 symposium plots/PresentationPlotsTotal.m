clear
% function inputs in future
p1 = 9000;
T4 = 1100;
PR_c = 2;
A_panel = 42:2:140;
T_amb = 100;
fluid = 'CO2';
mode = 2;
desiredPower = 40000; % [W]


for i=1:length(A_panel)
    
    
    % find minimum UA which gives desired power output
    [ UA_min,m_dotcycle_max ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel(i),...
        T_amb,fluid,mode);
    
    UA = linspace(UA_min,UA_min+12000,45);
    
    options = [];
    for j = 1:length(UA)
        [net_power,cyc_efficiencyArray,D_T,D_c,Ma_T,Ma_c,q_reactor(j,i),...
            q_rad,T1,m_dot(j,i),T3(j,i),p3(j,i),T4_out(j,i),p4(j,i)] =...
            SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(j),A_panel(i),T_amb,fluid,mode,m_dotcycle_max,options);
        cyc_efficiency(j,i) = cyc_efficiencyArray(1);
        UA_output(j,i) = UA(j);
        A_panel_output(j,i) = A_panel(i)
    end
    
end
% %surface plot
% figure
% UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
% surf(A_panel_output,UA_output/1000,q_reactor/1000)
% xlabel('A_p_a_n_e_l [m^2]')
% ylabel('UA [W/K]')
% zlabel('q_r_e_a_c_t_o_r [kW]')
% 
% 
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = 0.0131*UA_output; %convert to kW/K
mass_radiator = 5.8684*A_panel_output;
mass_total_estimated = mass_reactor+mass_recuperator+mass_radiator;
% 
% %surface plot
% figure
% % UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
% % surf(A_panel_output,UA_output/1000,q_reactor/1000)
% surf(mass_reactor,mass_recuperator,mass_radiator)
% xlabel('Reactor Mass [kg]')
% ylabel('Recuperator Mass [kg]')
% zlabel('Reactor Mass [kg]')

figure
% contour(q_reactor/1000,A_panel_output,mass_total_estimated)
UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
contour(q_reactor/1000,A_panel_output,mass_total_estimated,50)
xlabel('q_r_e_a_c_t_o_r [kW]')
ylabel('A_p_a_n_e_l [m^2]')
title('Cycle Mass [kg]')
colorbar

[minMatrix,i] = min(mass_total_estimated(:));
[row,col] = find(mass_total_estimated==minMatrix);
hold on
scatter(q_reactor(i)/1000,A_panel_output(i),'r','filled')
% text(q_reactor(i)/1000+20,A_panel_output(i),['\leftarrow' 'A_p_a_n_e_l = ' num2str(A_panel_output(i)) ' m^2, Total Mass = ' num2str(mass_total_estimated(i)) ' kg']) 

[~,cyc_efficiency,~,~,~,~,~,q_dot_r_out,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA_output(i),...
    A_panel_output(i),T_amb,fluid,mode,1)
title([])
grid on
react = mass_reactor(i)
recup = mass_recuperator(i)
rad = mass_radiator(i)
tot1 = react + recup + rad;
tot = mass_total_estimated(i)



% mass_reactor_new = 3.61503312e-4*q_reactor_new+100;
% mass_total_thermal = mass_reactor_new+mass_recuperator+mass_radiator;






% if radiator less important
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = 0.0131*UA_output; %convert to kW/K
mass_radiator = 5.8684*A_panel_output*0.1;
mass_total_estimated = mass_reactor+mass_recuperator+mass_radiator;
% 
% %surface plot
% figure
% % UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
% % surf(A_panel_output,UA_output/1000,q_reactor/1000)
% surf(mass_reactor,mass_recuperator,mass_radiator)
% xlabel('Reactor Mass [kg]')
% ylabel('Recuperator Mass [kg]')
% zlabel('Reactor Mass [kg]')

figure
% contour(q_reactor/1000,A_panel_output,mass_total_estimated)
UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
mesh(q_reactor/1000,A_panel_output,mass_total_estimated)
xlabel('q_r_e_a_c_t_o_r [kW]')
ylabel('A_p_a_n_e_l [m^2]')
zlabel('Cycle Mass [kg]')
colorbar

[minMatrix,i] = min(mass_total_estimated(:));
[row,col] = find(mass_total_estimated==minMatrix);
hold on
scatter3(q_reactor(i)/1000,A_panel_output(i),mass_total_estimated(i),25,'r','filled')

[~,cyc_efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA_output(i),...
    A_panel_output(i),T_amb,fluid,mode,1)
title([])
grid on
react = mass_reactor(i)
recup = mass_recuperator(i)
rad = mass_radiator(i)
tot1 = react + recup + rad;
tot = mass_total_estimated(i)



% if reactor less important
mass_reactor = (0.00131*q_reactor+100)*0.1;
mass_recuperator = 0.0131*UA_output; %convert to kW/K
mass_radiator = 5.8684*A_panel_output;
mass_total_estimated = mass_reactor+mass_recuperator+mass_radiator;
% 
% %surface plot
% figure
% % UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
% % surf(A_panel_output,UA_output/1000,q_reactor/1000)
% surf(mass_reactor,mass_recuperator,mass_radiator)
% xlabel('Reactor Mass [kg]')
% ylabel('Recuperator Mass [kg]')
% zlabel('Reactor Mass [kg]')

figure
% contour(q_reactor/1000,A_panel_output,mass_total_estimated)
UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
mesh(q_reactor/1000,A_panel_output,mass_total_estimated)
xlabel('q_r_e_a_c_t_o_r [kW]')
ylabel('A_p_a_n_e_l [m^2]')
zlabel('Cycle Mass [kg]')
colorbar

[minMatrix,i] = min(mass_total_estimated(:));
[row,col] = find(mass_total_estimated==minMatrix);
hold on
scatter3(q_reactor(i)/1000,A_panel_output(i),mass_total_estimated(i),25,'r','filled')

[~,cyc_efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA_output(i),...
    A_panel_output(i),T_amb,fluid,mode,1)
title([])
grid on
react = mass_reactor(i)
recup = mass_recuperator(i)
rad = mass_radiator(i)
tot1 = react + recup + rad;
tot = mass_total_estimated(i)



% if recuperator less important
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = (0.0131*UA_output)*0.1; %convert to kW/K
mass_radiator = 5.8684*A_panel_output;
mass_total_estimated = mass_reactor+mass_recuperator+mass_radiator;
% 
% %surface plot
% figure
% % UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
% % surf(A_panel_output,UA_output/1000,q_reactor/1000)
% surf(mass_reactor,mass_recuperator,mass_radiator)
% xlabel('Reactor Mass [kg]')
% ylabel('Recuperator Mass [kg]')
% zlabel('Reactor Mass [kg]')

figure
% contour(q_reactor/1000,A_panel_output,mass_total_estimated)
UA_plot = linspace(min(min(UA_output)),max(max(UA_output)),length(UA));
mesh(q_reactor/1000,A_panel_output,mass_total_estimated)
xlabel('q_r_e_a_c_t_o_r [kW]')
ylabel('A_p_a_n_e_l [m^2]')
zlabel('Cycle Mass [kg]')
colorbar

[minMatrix,i] = min(mass_total_estimated(:));
[row,col] = find(mass_total_estimated==minMatrix);
hold on
scatter3(q_reactor(i)/1000,A_panel_output(i),mass_total_estimated(i),25,'r','filled')

[~,cyc_efficiency,~,~,~,~,~,~,...
    ~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
    ~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA_output(i),...
    A_panel_output(i),T_amb,fluid,mode,1)
title([])
grid on
react = mass_reactor(i)
recup = mass_recuperator(i)
rad = mass_radiator(i)
tot1 = react + recup + rad;
tot = mass_total_estimated(i)


%plot
mass_reactor = 0.00131*q_reactor+100;
mass_recuperator = 0.0131*UA_output; %convert to kW/K
mass_radiator = 5.8684*A_panel_output;
mass_total_estimated = mass_reactor+mass_recuperator+mass_radiator;


% v = VideoWriter('C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\APanel.avi');
% v.FrameRate = 1;
% open(v)
% for i = 1:15
%     plot(q_reactor(:,i)/1000,mass_total_estimated(:,i))
%     xlabel('q_r_e_a_c_t_o_r [kW]')
%     ylabel('Cycle Mass [kg]')
%     xlim([0 400])
%     ylim([725 950])
%     grid on
%     legend(['A_p_a_n_e_l= ' num2str(A_panel(1,i))])
%     frame=getframe(gcf);
%     writeVideo(v,frame)
% 
% end
% close(v)

figure
k = 1;
i = [30, 23, 19, 15, 11, 7, 4,1];
for j = 1:length(i)
    plot(q_reactor(:,i(j))/1000,mass_total_estimated(:,i(j)))
    xlabel('q_r_e_a_c_t_o_r [kW]')
    ylabel('Cycle Mass [kg]')
    xlim([50 480])
    ylim([725 1300])
    grid on
    %     legendinfo{k}=(['A_p_a_n_e_l= ' num2str(A_panel(1,i)) 'm^2']);
    if j ==7
        text(q_reactor(1,i(j))/1000+1,mass_total_estimated(1,i(j))-5,[ num2str(A_panel(1,i(j))) ' m^2'])
    elseif j == 8
        text(q_reactor(1,i(j))/1000+1,mass_total_estimated(1,i(j))+5,[ num2str(A_panel(1,i(j))) ' m^2'])
    else
        text(q_reactor(1,i(j))/1000+1,mass_total_estimated(1,i(j))+5,[ num2str(A_panel(1,i(j))) ' m^2'])
    end
    
    k = k+1;
    hold on
    pause
end

pause

for i = 1:3:6 %7:4:23
    plot(q_reactor(:,i)/1000,mass_total_estimated(:,i))
        xlabel('q_r_e_a_c_t_o_r [kW]')
    ylabel('Cycle Mass [kg]')
    xlim([50 470])
    ylim([725 1150])
    grid on
%     legendinfo{k}=(['A_p_a_n_e_l= ' num2str(A_panel(1,i)) 'm^2']);
    text(q_reactor(end,i)/1000+3,mass_total_estimated(end,i),[ num2str(A_panel(1,i)) ' m^2'])
    k = k+1;
    hold on
end
% legend(legendinfo,'location','northwest')







