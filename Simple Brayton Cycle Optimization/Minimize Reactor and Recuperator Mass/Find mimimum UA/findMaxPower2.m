function [max_power,m_dot] = findMaxPower2(p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,options)
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
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% Outputs:
% max_power: maximum output power from a given cycle found by varying m_dot
% [W]
% m_dot: the mass flow in the cycle with the max power [kg/s]

%%%%%%%%%%%%%%%%%%%%%%%%%% bound finding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% m_dot_min = 0.5;
% m_dot_max = 3.5;
% steps = 10;
% 
% power = zeros(1,steps);
% stop = 0;
% 
% while stop == 0
%     m_dot_testvals = linspace(m_dot_min,m_dot_max,steps);
%     
%     for i = 1:length(steps)
%         try
%             power(i) = powerFind(m_dot_testvals(i),options,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
%         catch
%             power(i) = NaN;
%         end
%     end
%     
%     [~,inde] = min(power);
%     
%     if inde == 1
%         m_dot_min = 0.5*m_dot_min;
%         m_dot_max = m_dot_testvals(inde+1);
%     elseif inde == length(m_dot_testvals)
%         m_dot_min = m_dot_testvals(inde-1);
%         m_dot_max = m_dot_max*1.5;
%     else
%         m_dot_min = m_dot_testvals(inde-1);
%         m_dot_max = m_dot_testvals(inde+1);
%         stop = 1;
%     end
%         
%     
% end    
%%%%%%%%%%%%%%%%%%%%%%%%%% bound finding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
[m_dot,net_power] = fminbnd(@powerFind,m_dot_min,m_dot_max,options,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);

max_power = -net_power;
end

