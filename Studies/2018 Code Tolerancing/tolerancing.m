% function inputs in future
p1 = 9000;
T4 = 1100;
PR_c = 2;
A_panel = 70:10:110; % 40:2:120;
T_amb = 100;
fluid = 'CO2';
mode = 2;
desiredPower = 40000; % [W]

% % for UA in max power match change tolerance to tol_UA, add tol_UA as an
% % input to maxPowerMatch, the call in minRadRecMass2, and an input to
% % minRadRecMass2, add UA_min and m_dotcycle_max to outputs of
% % minRadRecMass2. also add options = 
% tol_UA= [eps,logspace(-14,-2, 13)];
% for j = 1:length(A_panel)
%     A = A_panel(j);
%     parfor i = 1:length(tol_UA)
%         [ minMass(j,i),UA_min(j,i),m_dotcycle_max(j,i) ] = minRadRecMass2( A,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,tol_UA(i) );
%     end
% end
% 
% for k = 1:length(A_panel)
%     minMassFracError(k,:) = (abs(minMass(k,:)-minMass(k,1))/minMass(k,1));
%     UA_minFracError(k,:) = (abs(UA_min(k,:)-UA_min(k,1))/UA_min(k,1));
%     m_dotcycle_maxFracError(k,:) = (abs(m_dotcycle_max(k,:)-m_dotcycle_max(k,1))/m_dotcycle_max(k,1));
% end
% 
% figure
% for k = 1:length(A_panel)
%     loglog(tol_UA(1,:),minMassFracError(k,:))
%     xlabel('UA tolerance')
%     ylabel('Minimum Mass Fractional Error')
% %     set(gca, 'XScale', 'log')
%     grid on
%     hold on
% end
% legend('A_P_a_n_e_l = 70', 'A_P_a_n_e_l = 80', 'A_P_a_n_e_l = 90', 'A_P_a_n_e_l = 100', 'A_P_a_n_e_l = 110','location','northwest')
% 
% figure
% for k = 1:length(A_panel)
%     loglog(tol_UA(1,:),UA_minFracError(k,:))
%     xlabel('UA tolerance')
%     ylabel('Minimum UA Fractional Error')
%     grid on
%     hold on
% end
% legend('A_P_a_n_e_l = 70', 'A_P_a_n_e_l = 80', 'A_P_a_n_e_l = 90', 'A_P_a_n_e_l = 100', 'A_P_a_n_e_l = 110','location','northwest')
% 
% figure
% for k = 1:length(A_panel)
%     loglog(tol_UA(1,:),m_dotcycle_maxFracError(k,:))
%     xlabel('UA tolerance')
%     ylabel('maximum m_d_o_t Fractional Error')
%     grid on
%     hold on
% end
% legend('A_P_a_n_e_l = 70', 'A_P_a_n_e_l = 80', 'A_P_a_n_e_l = 90', 'A_P_a_n_e_l = 100', 'A_P_a_n_e_l = 110','location','northwest')


% for minimum search in minRadRecMass2, add tol_min as input, make tolx for
% fminbnd be tol_min
tol_min= [eps,logspace(-14,-2, 13)];
for j = 1:length(A_panel)
    A = A_panel(j)
    parfor i = 1:length(tol_min)
        [ minMass(j,i),UA(j,i),t(j,i) ] = minRadRecMass2( A,desiredPower,p1,T4,PR_c,T_amb,fluid,mode,tol_min(i) );
    end
end

for k = 1:length(A_panel)
    minMassFracError(k,:) = (abs(minMass(k,:)-minMass(k,1))/minMass(k,1));
    UAFracError(k,:) = (abs(UA(k,:)-UA(k,1))/UA(k,1));
end

figure
for k = 1:length(A_panel)
    loglog(tol_min(1,:),minMassFracError(k,:))
    xlabel('Minimum mass tolerance')
    ylabel('Minimum Mass Fractional Error')
%     set(gca, 'XScale', 'log')
    grid on
    hold on
end
legend('A_P_a_n_e_l = 70', 'A_P_a_n_e_l = 80', 'A_P_a_n_e_l = 90', 'A_P_a_n_e_l = 100', 'A_P_a_n_e_l = 110','location','northwest')

figure
for k = 1:length(A_panel)
    loglog(tol_min(1,:),UAFracError(k,:))
    xlabel('Minimum mass tolerance')
    ylabel('UA Fractional Error')
    grid on
    hold on
end
legend('A_P_a_n_e_l = 70', 'A_P_a_n_e_l = 80', 'A_P_a_n_e_l = 90', 'A_P_a_n_e_l = 100', 'A_P_a_n_e_l = 110','location','northwest')


