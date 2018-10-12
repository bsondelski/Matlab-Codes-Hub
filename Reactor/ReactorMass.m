function [ mass ] = ReactorMass( power_thermal,m_dot,p_in,p_out,T_in,T_out,fluid )
% find reactor mass using python code written by Alex Swenson

mycomputer = getenv('computername');

if strcmp(mycomputer,'SEL-24') == 1
    insert(py.sys.path,int32(0),'C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Reactor\sCO2_reactor\optimization')
end

tf = iscell(fluid(1));
if tf == 1
    comp = cell2mat(fluid(3));
    if strcmp(fluid{1},'WATER') == 1
        fluid{1} = 'H2O';
    elseif strcmp(fluid{2},'WATER') == 1
        fluid{2} = 'H2O';
    end
    fluidin = py.dict(pyargs(fluid{1},comp(1),fluid{2},comp(2)));
elseif strcmp(fluid,'WATER') == 1
    fluidin = 'H2O';
elseif strcmp(fluid,'CO2') == 1
    fluidin = 'CO2';
end

% fluidin = 'CO2';

 mass = py.reactor_mass.calc_mass('UW', fluidin, power_thermal, m_dot, [T_in, T_out], [p_in, p_out]);

end

