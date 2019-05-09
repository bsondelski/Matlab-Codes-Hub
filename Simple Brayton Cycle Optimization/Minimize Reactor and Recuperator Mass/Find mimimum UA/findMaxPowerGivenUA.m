function [max_power,m_dot] = findMaxPowerGivenUA(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options)
% find maximum power output and corresponding mass flow rate for a given
% conductance and other system parameters

% inputs:
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% UA: conductance of recuperator [W/K]
% A_panel: area of radiator panel [m2]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% options: optimization tolerance 

% Outputs:
% max_power: maximum output power from a given cycle found by varying m_dot
%            [W]
% m_dot: the mass flow in the cycle with the max power [kg/s]

%%%%%%%%%%%%%%%%%%%%%%%%%% bound finding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m_dot_min = 0.7;
m_dot_max = 1.5;
steps = 10;

stop = 0;
loopcount = 1;

while stop == 0
    m_dot_testvals = linspace(m_dot_min,m_dot_max,steps);
    power = zeros(1,steps);
    
    for i = 1:length(m_dot_testvals)
        [net_power,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] =...
            BraytonCycle(m_dot_testvals(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
                power(i) = -net_power;

        if i > 1 && abs(power(i)) < abs(power(i-1))
            % if the power level is decreasing, the solution has
            % already been passed -no need to calculate the other values 
            power(i+1:end) = [];
            break
        end
    end
    [~,inde] = min(power);
    
    if inde == 1
        m_dot_min = 0.5*m_dot_min;
        m_dot_max = m_dot_testvals(inde+1);
    elseif inde == length(m_dot_testvals)
        m_dot_min = m_dot_testvals(inde-1);
        m_dot_max = m_dot_max*1.5;
    else
        mdot_diff = m_dot_max - m_dot_min;
        if isnan(power(inde-1)) && mdot_diff < 1e-7
            m_dot_min = m_dot_testvals(inde);
            m_dot_max = m_dot_testvals(inde+1);
            stop = 1;
        elseif isnan(power(inde-1))
            m_dot_min = m_dot_testvals(inde-1);
            m_dot_max = m_dot_testvals(inde+1);
        else
            m_dot_min = m_dot_testvals(inde-1);
            m_dot_max = m_dot_testvals(inde+1);
            stop = 1;
        end
    end
    
    % check if stuck in the loop
    if loopcount > 100 && stop ==0
        fprintf(2, 'findMaxPower2: unable to find m_dot boundaries \n \n');
        m_dot_min = NaN;
        m_dot_max = NaN;
        break
    end
    
    loopcount = loopcount + 1;
end  

%%%%%%%%%%%%%%%%%%%%%%% bound finding end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

[m_dot,net_power] = fminbnd(@negativeBraytonCycle,m_dot_min,m_dot_max,options,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
max_power = -net_power;



    function negativeNetPower = negativeBraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)
        [netPower,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] =...
            BraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
        negativeNetPower = -netPower;
    end

end

