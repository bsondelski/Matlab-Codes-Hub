function [T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% description: discretized e-NTU method with HEX's in series
% development notes: John Dyerby's thesis and Nellis and Klein
% section 8.6.3 extension

% Inputs:
% T_H_in: inlet temperature at hot side of HEX [K]
% T_C_in: inlet temperature at cold side of HEX [K]
% p_H_in: hot side inlet pressure [kPa]
% p_H_out: hot side outlet pressure [kPa]
% p_C_in: cold side inlet pressure [kPa]
% p_C_out: cold side outlet pressure [kPa]
% m_dot_H: hot side mass flow rate [kg/s]
% m_dot_C: cold side mass flow rate [kg/s]
% UA: conductance [W/K]
% fluid_C: cold side fluid
% fluid_H: hot side fluid
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% ploton: 1(keep info for other part of script),2(plot temp points)

% Outputs:
% T_H_out: outlet temperature at hot side of HEX [K]
% T_C_out: outlet temperature at cold side of HEX [K]
% p_H: hotside pressure vector
% p_C: cold side pressure vector
% T_H: hotside temperature vector
% T_C: cold side temperature vector


% discretize HEX
N = 20;                   % number of sub HEX's


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
% find bounds for fzero
[ Tmin, Tmax ] = boundFind( T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N );

if isnan(Tmin) || isnan(Tmax)
    % if boundFind failed to find a valid interval, end the function with
    % NaN outputs
    T_H_out = NaN;
    T_C_out = NaN;
    h_C_out = NaN;
    p_H = NaN;
    p_C = NaN;
    T_H = NaN;
    T_C = NaN;
else
    % find zero to obtain T_H_out
    options = optimset('TolX',1E-8);              % set tolerancing on solver step size
%     options=[];                                % sets tolerancing to defualt
    T_H_out = fzero(@errorGen,[Tmin,Tmax],options,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
    
    %%%%%%%%%%%%%%%%%%%%% only to find T_C_out %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % find enthalpies of fully specified states
    [~,~,h_H_in] = getPropsTP(T_H_in,p_H(1),fluid_H,mode,1);     % hot side inlet properties
    [~,~,h_H_out] = getPropsTP(T_H_out,p_H(N+1),fluid_H,mode,1);   % hot side outlet properties
    [~,~,h_C_in] = getPropsTP(T_C_in,p_C(N+1),fluid_C,mode,1);     % cold side inlet properties
    
    % calculate total heat transfer
    q_dot = m_dot_H*(h_H_in-h_H_out); % total heat transfer rate
    
    % calculate enthalpy of cold side outlet
    h_C_out = h_C_in+q_dot/m_dot_C;   % specific heat capacity for cold side outlet

    % find temperature of cold side
    [T_C_out,~,~] = getPropsPH(p_C(N+1),h_C_out,fluid_C,mode,1); % find outlet temperature for cold side
    
    if ploton == 1 || ploton == 2 || ploton == 0
        %%%%%%%%%%%%%%%%%%%%% only to plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % preallocate space
        h_H = zeros(1,(N+1));
        h_C = zeros(1,(N+1)); 

        % initial enthalpy values for inlet of first sub HEX
        h_H(1) = h_H_in;              % hot side inlet enthalpy
        h_C(1) = h_C_out;             % cold side outlet enthalpy
        
        % enthalpy values for outlet and inlet of each sub HEX
        for i = 2:(N+1)
            h_H(i) = h_H(i-1)-q_dot/(N*m_dot_H);      % calculate hot side enthalpy at outlet of sub HEX
            h_C(i) = h_C(i-1)-q_dot/(N*m_dot_C);      % calculate cold side enthalpy at outlet of sub HEX
        end
        
        % find tepmerature values for outlet and inlet of each sub HEX
        [T_H,~,~] = getPropsPH(p_H,h_H,fluid_H,mode,1);
        [T_C,~,~] = getPropsPH(p_C,h_C,fluid_C,mode,1);
        
        if ploton == 2
            figure
%             x = 1:(N+1);
            [~,UA_each] = errorGen(T_H_out,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
            UA_plot = zeros(1,length(UA_each));
            for z = 1:length(UA_each)
                UA_plot(z) = sum(UA_each(1:z));
            end
            UA_plot = [0, UA_plot]/1000;
            plot(UA_plot,T_C,UA_plot,T_H,'--*')
            legend('T_C','T_H')
            ylabel('Temperature [K]')
            xlabel('UA [W/K]')
        end
        
        
    else
        T_H = inf;
        T_C = inf;
    end
    
end

% % HEXeffect = (h_C_out-h_C_in)/(h_H_in-h_C_in);
% 
%         % capacitance rates
%         C_dot_H = m_dot_H.*(h_H(1:N)-h_H(2:(N+1)))./(T_H(1:N)-T_H(2:(N+1)));  %hot side capacitance rates
%         %                           h_H1-h_H2                T_H1-T_H2
%         
%         C_dot_C = m_dot_C.*(h_C(1:N)-h_C(2:(N+1)))./(T_C(1:N)-T_C(2:(N+1)));  % cold side capacitance rates
% %         change = find(C_dot_C==Inf);
% %         C_dot_C(change) = 9999;
% % 
% 
%         C_dot_min = min(C_dot_C,C_dot_H);                     % minimum capacitance rates
%         C_dot_max = max(C_dot_C,C_dot_H);                     % maximum capacitance rates
%         epsilon = q_dot./(N.*C_dot_min.*(T_H(1:N)-T_C(2:(N+1))));     
% C_R = C_dot_min./C_dot_max;     
% 
% inds = find(C_R == 1);                                % find the indicies of the C_R members that are 1
%             NTU = log((1-epsilon.*C_R)./(1-epsilon))./(1-C_R);    % NTU of sub HEXs
%             NTU(inds) = epsilon(inds)./(1-epsilon(inds));   
%             
%             UA_each = NTU.*C_dot_min; % conductance in sub HEX
%             UA_total = sum(UA_each); 

% T_H_avgs = (T_H(1:N)+T_H(2:(N+1)))./2;
% T_C_avgs = (T_C(1:N)+T_C(2:(N+1)))./2;
% % plot(T_H_avgs,C_dot_H)
% q_max_H = trapz(flip(T_H_avgs),flip(C_dot_H));
% q_max_C = trapz(flip(T_C_avgs),flip(C_dot_C));
% q_max = min(q_max_H,q_max_C);
% 
% C_dot_H = m_dot_H.*h_H(1:(N+1))./T_H(1:(N+1))
% C_dot_C = m_dot_C.*h_C(1:(N+1))./T_C(1:(N+1));
% q_max_H = trapz(flip(T_H),flip(C_dot_H))
% q_max_C = trapz(flip(T_C),flip(C_dot_C))
% q_max = min(q_max_H,q_max_C);
% 
% C_dot_C = m_dot_C*(h_C_in-h_C_out)/(T_C_in-T_C_out);
% C_dot_H = m_dot_H*(h_H_in-h_H_out)/(T_H_in-T_H_out);
% C_dot_min = min(C_dot_C,C_dot_H)
% C_dot_max = max(C_dot_C,C_dot_H)
% C_R = C_dot_min/C_dot_max
%  q_max = C_dot_min*(T_H_in-T_C_in)
% [~, ~, h_H_min] = getPropsTP(T_C_in,p_H_out,fluid_H,mode,1);
% q_max_H = m_dot_H*(h_H_in-h_H_min)
% [~, ~, h_C_max] = getPropsTP(T_H_in,p_C_out,fluid_C,mode,1);
% q_max_C = m_dot_C*(h_C_max-h_C_in)
% q_max = min(q_max_H,q_max_C)
% 
% q_dot = m_dot_C*(h_C_out-h_C_in);
% HEXeffect = q_dot/q_max
% NTU = log((1-HEXeffect.*C_R)./(1-HEXeffect))./(1-C_R)
% % 
% % %%% close!!!!!




% [~, ~, h_H_min] = getPropsTP(T_C_in,p_H_out,fluid_H,mode,1);
% q_max_H = m_dot_H*(h_H_in-h_H_min);
% [~, ~, h_C_max] = getPropsTP(T_H_in,p_C_out,fluid_C,mode,1);
% q_max_C = m_dot_C*(h_C_max-h_C_in);
% q_max = min(q_max_H,q_max_C);
% q_dot = m_dot_C*(h_C_out-h_C_in);
% HEXeffect = q_dot/q_max

% 
% 
% 
% 
% 
% 
% % capacitance rates
%         C_dot_H = m_dot_H.*(h_H(1:N+1))./(T_H(1:(N+1)))  %hot side capacitance rates
%         %                           h_H1-h_H2                T_H1-T_H2
%         
%         C_dot_C = m_dot_C.*(h_C(1:(N+1)))./(T_C(1:(N+1)))  % cold side capacitance rates
%         
%         q_dot = m_dot_C*(h_C_out-h_C_in);
%         
%     T_vec = linspace(T_C_in,T_H_in,N+1);
%     qMaxC = trapz(T_vec,C_dot_C);
%     qMaxH = trapz(T_vec,C_dot_H);
%     q_max = min(qMaxC,qMaxH);
%     HEXeffect = q_dot/q_max
    
end
