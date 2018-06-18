% % function inputs in future
% p1 = 9000;
% T4 = 950;
% PR_c = 2;
% A_panel = 100; % 40:2:120;
% T_amb = 100;
% fluid = 'CO2';
% mode = 2;
% desiredPower = 40000; % [W]
% 
% m_dot = 1.0431;
% UA = 2.2692e4;
% A_panel = 70.5573;
% 
% TLowerBound = 240;
% 
% 
% Tmax = T4;                % T1 must be lower than T4
% Tmin = TLowerBound;       % min T1 is lowest programmed into FIT or REFPROP
% 
% T = linspace(TLowerBound,T4);
% 
% err = zeros(1, length(T));    % preallocate space
% for i = 1:length(T)
%     err(i) = simpleCycleError(T(i),m_dot,p1,T4,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5);
% end
% 
% plot(T,err)





% % function inputs in future
% p1 = 9000;
% T4 = 900;
% PR_c = 2;
% A_panel = 100; % 40:2:120;
% T_amb = 100;
% fluid = 'CO2';
% mode = 2;
% desiredPower = 40000; % [W]
% 
% m_dot = 1.3364;
% UA = 8.3747e4;
% A_panel = 70.5573;
% 
% TLowerBound = 240;
% 
% 
% Tmax = T4;                % T1 must be lower than T4
% Tmin = TLowerBound;       % min T1 is lowest programmed into FIT or REFPROP
% 
% T = linspace(TLowerBound,T4);
% 
% err = zeros(1, length(T));    % preallocate space
% for i = 1:length(T)
%     err(i) = simpleCycleError(T(i),m_dot,p1,T4,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5);
% end
% 
% plot(T,err)




% 
% % function inputs in future
% p1 = 9000;
% T4 = 1100;
% PR_c = 2;
% A_panel = 850; % 40:2:120;
% T_amb = 100;
% fluid = 'CO2';
% mode = 2;
% desiredPower = 40000; % [W]
% 
% m_dot = 1.1402;
% UA = 13500;
% A_panel = 70.5573;
% 
% TLowerBound = 240;
% 
% 
% Tmax = T4;                % T1 must be lower than T4
% Tmin = TLowerBound;       % min T1 is lowest programmed into FIT or REFPROP
% 
% T = linspace(TLowerBound,T4);
% 
% err = zeros(1, length(T));    % preallocate space
% for i = 1:length(T)
%     err(i) = simpleCycleError(T(i),m_dot,p1,T4,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5);
% end
% figure
% plot(T,err)




T_H_in = T5;
T_C_in = T2;
p_H_in = p5;
p_H_out = p6;
p_C_in = 18000;
p_C_out = 1.79064e4;
m_dot_H = 1.1402;
m_dot_C = m_dot_H;
UA = 135000;
fluid_C = 'CO2';
fluid_H = fluid_C;
mode = 2;

N = 20;

% calculate pressures for points along HEX 
% preallocate space
p_H = zeros(1,(N+1));
p_C = zeros(1,(N+1));

% initial pressures values for inlets of HEX
p_H(1) = p_H_in;               % hot side inlet pressure
p_C(1) = p_C_out;              % cold side inlet pressure

% find pressure change for each sub HEX
ploss_C = (p_C_in-p_C_out)/N;
ploss_H = (p_H_in-p_H_out)/N;

% enthalpy values for outlet and inlet of each sub HEX
for i = 2:(N+1)
    p_H(i) = p_H(i-1)-ploss_H;            % calculate hot side pressure at outlet of sub HEX
    p_C(i) = p_C(i-1)+ploss_C;            % calculate cold side pressure at outlet of sub HEX    
end

Tmax = 371.72;
Tmin = 371.71;
% Tmax = T_H_in-0.001*(T_H_in-T_C_in);     % max outlet hot temp as 0.1% of temp difference
% Tmin = T_C_in;%+0.001*(T_H_in-T_C_in);   % min outlet hot temp as cold temp
nstep = 10000;
Q = (Tmax-Tmin)/nstep;
TH = Tmin:Q:Tmax;         % create an array for temps to check
err = zeros(1, length(TH));   % preallocate space
% TH = [3.717198004921307e2, 3.7171980049213074e2, 3.717198004921307e2, 3.717198004921303e2, 450];

% generate an array of error values given the temperature increments
    for i = 1:length(TH)
        err(i) = errorGen(TH(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
    end

    plot(TH,err)









