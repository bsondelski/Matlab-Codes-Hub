% % run all studies for stainless steel and UO2
% 
clear
T4 = [850:10:1150];
parfor i = 1:length(T4)
   T4(i)
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,T4(i),2,200,'CO2',2,'UO2','SS' );

end
save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSTemp.mat'
[~,I] = min(TotalMinMass);
Tmin = T4(I);

clearvars -except Tmin

p1 = [9000:500:20000];
parfor i = 1:length(p1)
    
    p1(i)
    [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),900,2,200,'CO2',2,'UO2','SS' );
end
save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSp1Near.mat'
clearvars -except Tmin

p1 = [9000:500:20000];
parfor i = 1:length(p1)
    
    p1(i)
    [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,2,200,'CO2',2,'UO2','SS' );
end
save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSp1Far.mat'
clearvars -except Tmin


PR = [2:0.1:3];
parfor i = 1:length(PR)
    p1(i) = 18000/PR(i);
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),900,PR(i),200,'CO2',2,'UO2','SS' );

end
save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSPRNear.mat'
clearvars -except Tmin


PR = [2:0.1:3];
% p1 = 18000/PR
parfor i = 1:length(PR)
    p1(i) = 18000/PR(i);
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,PR(i),200,'CO2',2,'UO2','SS' );

end
save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_SSPRFar.mat'











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run all studies for Inconel and UO2
clear

T4 = [850:10:1150];
parfor i = 1:length(T4)
    T4(i)
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,T4(i),2,200,'CO2',2,'UO2','IN' );

end

save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INTemp.mat'
[~,I] = min(TotalMinMass);
Tmin = T4(I);
clearvars -except Tmin

p1 = [5000:500:20000];
parfor i = 1:length(p1)
    
    p1(i)
    [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,2,200,'CO2',2,'UO2','IN' );
end

save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INp1.mat'
clearvars -except Tmin

PR = [2:0.1:3];
% p1 = 18000/PR
parfor i = 1:length(PR)
    p1(i) = 18000/PR(i);
[ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,PR(i),200,'CO2',2,'UO2','IN' );

end

save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UO2_INPR.mat'











% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % run all studies for stainless steel and UW
% 
% clear
% T4 = [850:10:1150];
% parfor i = 1:length(T4)
%    T4(i)
% [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,T4(i),2,200,'CO2',2,'UW','SS' );
% 
% end
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSTemp.mat'
% [~,I] = min(TotalMinMass);
% Tmin = T4(I);
% clearvars -except Tmin
% 
% p1 = [8000:500:15000];
% parfor i = 1:length(p1)
%     
%     p1(i)
%     [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),900,2,200,'CO2',2,'UW','SS' );
% end
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSp1Near.mat'
% clearvars -except Tmin
% 
% p1 = [4000:500:11000];
% parfor i = 1:length(p1)
%     
%     p1(i)
%     [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,2,200,'CO2',2,'UW','SS' );
% end
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSp1Far.mat'
% clearvars -except Tmin
% 
% 
% PR = [2:0.1:3];
% parfor i = 1:length(PR)
%     p1(i) = 18000/PR(i);
% [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),900,PR(i),200,'CO2',2,'UW','SS' );
% 
% end
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSPRNear.mat'
% clearvars -except Tmin
% 
% 
% PR = [2:0.1:3];
% % p1 = 18000/PR
% parfor i = 1:length(PR)
%     p1(i) = 18000/PR(i);
% [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,PR(i),200,'CO2',2,'UW','SS' );
% 
% end
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_SSPRFar.mat'
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % run all studies for Inconel and UW
% clear
% 
% T4 = [850:10:1150];
% parfor i = 1:length(T4)
%     T4(i)
% [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,9000,T4(i),2,200,'CO2',2,'UW','IN' );
% 
% end
% 
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INTemp.mat'
% [~,I] = min(TotalMinMass);
% Tmin = T4(I);
% clearvars -except Tmin
% 
% p1 = [2000:500:10000];
% parfor i = 16:length(p1)
%     
%     p1(i)
%     [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,2,200,'CO2',2,'UW','IN' );
% end
% 
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INp1.mat'
% clearvars -except Tmin
% 
% PR = [2:0.1:3];
% % p1 = 18000/PR
% parfor i = 1:length(PR)
%     p1(i) = 18000/PR(i);
% [ TotalMinMass(i),UA(i),UA_min,A_panel(i),mass_reactor(i),mass_recuperator(i),mass_radiator(i),m_dot(i) ] = minimizeTotalMass( 40000,p1(i),Tmin,PR(i),200,'CO2',2,'UW','IN' );
% 
% end
% 
% save 'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\Parametric Studies\Results\UW_INPR.mat'
