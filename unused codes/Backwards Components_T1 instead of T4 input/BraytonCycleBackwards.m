function [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,T4] = BraytonCycleBackwards(m_dot,T1,p1,PR,UA,A_panel,T_amb,fluid,mode)
%entire Brayton Cycle
%Inputs:
%m_dot: the mass flow into the compressor [kg/s]
%T_in: flow temp at inlet of the compressor [K]
%p_in: flow pressure at inlet of the compressor [kPa]
%phi: dimensionless flow coefficient
%psi: dimensionless head coefficient
%n_c: isentropic compressor efficiency
%PR: pressure ratio of the compressor
%fluid: working fluid for the system
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)

% m_dot=1.5;
% T1=500;
% p1=4000;
% PR_c=2.6;
% fluid='CO2';
% mode=2;
% UA=1210;
% A_panel=3;
% T_amb=100;
% PR_T=0.5;

[p2,T2,D_c,N,Power_c,Ma_c] = Compressor(m_dot,T1,p1,PR,fluid,mode);
[T6,p6] = radiatorBackwards(m_dot,A_panel,T_amb,T1,p1,fluid,mode);
[T5,T3,h3,~] = HEXbackwards(T6,T2,p6,p2,m_dot,m_dot,UA,fluid,fluid,mode);
p5=p6;
[T4,p4,h4,D_T,Power_T,Ma_T,Anozzle]=TurbineBackwards(m_dot,T5,p5,PR,fluid,mode,N)

q_reactor=m_dot*(h3-h4);

net_power=Power_T-Power_c;
cyc_efficiency=(Power_c+q_reactor)/Power_T;


end

