function [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,A_panel,q_rad,p2,T2,p3,T3,p5,T5,p6,T6] = BraytonCycle2(m_dot,T1,p1,T4,PR,UA,T_amb,fluid,mode)
%entire Brayton Cycle found by setting states 1 and 4 and solving for the
%radiator panel area

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

p4=p1*PR;
[p2,T2,D_c,N,Power_c,Ma_c] = Compressor(m_dot,T1,p1,PR,fluid,mode);
[p5,T5,D_T,Power_T,Ma_T,Anozzle] = Turbine(m_dot,T4,p4,PR,fluid,mode,N);

[T6, T3,~] = HEX_bettersolve(T5,T2,p5,p2,m_dot,m_dot,UA,fluid,fluid,mode);
p3=p2;
p6=p5;
[A_panel,q_rad] = radiator2(m_dot,T_amb,T1,p1,T6,p6,fluid,mode);

[~,~,h4]=getPropsTP(T4,p4,fluid,mode,1);
[~,~,h3]=getPropsTP(T3,p3,fluid,mode,1);
q_reactor=m_dot*(h3-h4);

net_power=Power_T-Power_c;
cyc_efficiency=(Power_c+q_reactor)/Power_T;



end

