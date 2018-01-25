function [T1Error] = simpleCycleError(T1guess,m_dot,p1,T4,UA,A_panel,...
    T_amb,fluid,mode,p2,p3,p4,p6,p5)
% Find error between guessed and actual temperature for compressor inlet in
% cycle 

% Inputs:
% T1guess: flow temp at inlet of the compressor [K]
% m_dot: the mass flow in the cycle [kg/s]
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% UA: conductance of recuperator
% A_panel: area of radiator panel [m3]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
% various cycle pressures

% output:
% T1Error: error between guessed and actual T1 values

% solve for state after compressor
[T2,~,N,~,~] = Compressor(m_dot,T1guess,p1,p2,fluid,mode);


% solve for state after turbine
[p5,T5,~,~,~,~,~] = Turbine(m_dot,T4,p4,p5,fluid,mode,N);

if T2 >= T5
    T1Error=NaN;
else
    % solve for recuperator outlets
    [T6, ~,~,~,~,~,~] = HEX_bettersolve(T5,T2,p5,p6,p2,p3,m_dot,m_dot,UA,fluid,fluid,mode,2);
    
    % solve for state after reactor
    [~,T1,~] = Radiator(m_dot,A_panel,T_amb,T6,p6,p1,fluid,mode);
        
    T1Error = T1guess-T1;
end
end

