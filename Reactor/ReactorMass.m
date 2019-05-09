function [ mass ] = ReactorMass( power_thermal,m_dot,p_in,p_out,T_in,T_out,fluid,NucFuel )
% find reactor mass using python code written by Alex Swenson

% Inputs:
% power_thermal: required reactor thermal power [W]
% m_dot: mass flow rate [kg/s]
% p_in: Inlet pressure [kPa]
% p_out: Outlet pressure [kPa]
% T_in: Inlet Temperature [K]
% T_out: Outlet Temperature [K]
% fluid: working fluid - "WATER", "CO2", or a mixture -> mixtures should
%        have the format of {'CO2','WATER','50','50'} for 50% water and 
%        50% CO2
% NucFuel: type of nuclear fuel - "UO2" or "UW"

% Output:
% mass: reactor mass [kg]


mycomputer = getenv('computername');

if strcmp(mycomputer,'SEL-24') == 1
    insert(py.sys.path,int32(0),'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Reactor\sCO2_reactor\optimization')
end

if p_in == p_out
    % reactor mass code will not solve if there is zero pressure drop, so a
    % 2.7% pressure drop is assumed for the mass calculation when pressure
    % drops are neglected
    ploss_reactor = 0.0270;   % pressure drop in reactor
    p_out = p_in-p_in*ploss_reactor; % pressure at reactor outlet
end


% put fluid type into proper format
tf = iscell(fluid(1));
if tf == 1
    if strcmp(fluid{1},'WATER') == 1
        comp1 = string(fluid(4));
        comp2 = string(fluid(3));
    elseif strcmp(fluid{2},'WATER') == 1
        comp1 = string(fluid(3));
        comp2 = string(fluid(4));
    end
    fluidin = strcat('CO2H2O',comp1,comp2);
elseif strcmp(fluid,'WATER') == 1
    fluidin = 'H2O';
elseif strcmp(fluid,'CO2') == 1
    fluidin = 'CO2';
end

p_in = p_in*1000;   % convert to Pa
p_out = p_out*1000; % convert to Pa

rxtr = py.reactor_mass.reactor_mass(NucFuel, fluidin, power_thermal, m_dot, [T_in, T_out], [p_in, p_out]);
mass = rxtr.mass;

% check if reactor power output matches thermal power desired - fuel
% fraction bounds in reactor model may need to be altered if the results do
% not match
q = rxtr.gen_Q;
diff = abs(power_thermal - q);
if diff > 1
    error('reactor output does not match desired thermal output')
end

end

