function [ minMass ] = minRadRecMass( desiredPower,p1,T4,PR_c,A_panel,T_amb,fluid,mode )




% find minimum UA which gives desired power output
[ UA_min,m_dotcycle(1) ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel,...
    T_amb,fluid,mode);

% UA = [UA_min, UA_min+10000, UA_min+20000];
UA = linspace(UA_min,(UA_min+20000),10);

% preallocate space
net_power = zeros(1,length(UA));
cyc_efficiency = zeros(1,length(UA));
q_reactor = zeros(1,length(UA));
T3 = zeros(1,length(UA));
p3 = zeros(1,length(UA));
p4 = zeros(1,length(UA));

% first data point found from known values
[net_power(1),cyc_efficiency(1),D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor(1),...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3(1),p3(1),~,p4(1),T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dotcycle(1),p1,T4,PR_c,UA_min,...
    A_panel,T_amb,fluid,mode,0);

% use specified power function to find data points for higher UA's
for i = 2:length(UA)
    UA(i)
    [net_power(i),cyc_efficiency(i),D_T,D_c,Ma_T,Ma_c,q_reactor(i),...
        q_rad,T1,m_dotcycle(i),T3(i),p3(i),...
        ~,p4(i)] = SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(i),A_panel,...
        T_amb,fluid,mode,m_dotcycle(i-1));
end


a = 0;
count = 1;

while a == 0
    % mass correlations
    mass_reactor = 0.002*q_reactor+100;
    mass_recuperator = 0.0131*UA; %convert to kW/K
    mass_radiator = 5.8684*A_panel;
    mass_total = mass_reactor+mass_recuperator+mass_radiator;
    
    [~,inde] = min(mass_total);
    g = length(UA);
    
    if inde == 1
        if count > 4
            minMass = UA(1);
            a = 2;
        else
            UA = linspace(UA(1),UA(2), 10);
            for i = 2:length(UA)
                UA(i)
                [net_power(i),cyc_efficiency(i),D_T,D_c,Ma_T,Ma_c,q_reactor(i),...
                    q_rad,T1,m_dotcycle(i),T3(i),p3(i),...
                    ~,p4(i)] = SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(i),A_panel,...
                    T_amb,fluid,mode,m_dotcycle(i-1));
            end
        end
    elseif inde == g
        UA = [ UA, linspace((UA(g)+2000),(UA(g)+20000),10)];
        
        for i = g+1:length(UA)
            UA(i)
            [net_power(i),cyc_efficiency(i),D_T,D_c,Ma_T,Ma_c,q_reactor(i),...
                q_rad,T1,m_dotcycle(i),T3(i),p3(i),...
                ~,p4(i)] = SpecifiedPower2(desiredPower,p1,T4,PR_c,UA(i),A_panel,...
                T_amb,fluid,mode,m_dotcycle(i-1));
        end
    else
        a = 1;
    end
    count = count + 1;
end

% quadratic approximitation to minimize mass
if a == 1
    UA_quad = [UA(inde-1),UA(inde),UA(inde+1)];
    q_reactor_quad = [q_reactor(inde-1),q_reactor(inde),q_reactor(inde+1)];
    mass_reactor_quad = 0.002*q_reactor_quad+100;
    mass_recuperator_quad = 0.0131*UA_quad; %convert to kW/K
    mass_total_quad = mass_reactor_quad+mass_recuperator_quad;
    
    while err > 0.01
        
        p = polyfit(UA_quad,mass_total_quad,2);
        d = [2*p(1), p(2)];                   % derivative of polynomial
        UA_middle = -d(2)/d(1);                % set derivative = 0
        
        [net_power_middle,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_middle,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
        
        [~,~,~,~,~,~,q_reactor_middle,~,~,~,~,~,~,~] = ...
            SpecifiedPower2(desiredPower,p1,T4,PR_c,UA_middle,A_panel,...
            T_amb,fluid,mode,m_dotcycle(1));
        mass_reactor_middle = 0.002*q_reactor_middle+100;
    mass_recuperator_middle = 0.0131*UA_middle; %convert to kW/K
    mass_total_middle = mass_reactor_middle+mass_recuperator_middle;
        
        UA_new = [UA_quad, UA_middle];                    % m_dot vector including new point
        q_reactor_new = [q_reactor_quad, q_reactor_new]:
        mass_total_new = [mass_total_quad, mass_total_middle];    % net power vector including new point
        
        [~,inde] = max(mass_total_new);        % find location of minimum power
        
        UA_new(inde) = [];                 % new m_dot vector excluding m_dot with lowest power
       UA_quad = UA_new;
        
        net_power_new(inde) = [];
        net_power = net_power_new;
        
        err = max(m_dot)-min(m_dot);          % difference between end points
    end
    
    max_power = net_power_middle;
    
    % exclude minimum m_dot from vector
    [~,inde_min] = min(m_dot);
    m_dot(inde_min) = [];
    % exclude maximum m_dot from vector
    [~,inde_max] = max(m_dot);
    m_dot(inde_max) = [];
    
    % find max net power
    % [max_power,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
end




end

