function [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy,m_dotcycle,T3,p3,T4,p4] = SpecifiedPower(power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode)
%finding the mass flow rate required for the specified power output of the
%system
%Inputs:
%power=specified power for the system
%p1: flow pressure at inlet of the compressor [kPa]
%T4: Temp at turbine inlet [K]
%PR: pressure ratio of the compressor and turbine
%UA: conductance of recuperator [W/K]
%A_panel: area of radiator panel [m2]
%T_amb: ambient temp for radiator [K]
%fluid: working fluid for the system
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%outputs:
%net_power: net power output from the cycle
%cyc_efficiency: total cycle efficiency
%D_T: turbine diameter
%D_c: compressor diameter
%Ma_T: Turbine outlet Mach number
%Ma_c: compressor outlet Mach number
%Anozzle: turbine nozzle area
%q_reactor: heat input to the reactor [W]
%q_rad: heat rejected by the radiator [W]
%T1: the temperatue at the inlet of the compressor
%Power_T: power output of the turbine
%Power_c: power intake of the compressor
%HEXeffect: effectiveness of the heat exchanger
%energy: check to see if energy is conserved (should be zero)
%m_dot: the mass flow in the cycle [kg/s]

a=1;
i=1;
% if UA < 12000
    m_dot(i)=0.6;
    m_dotmin=m_dot(i);
    [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
        ~,~,~,~,~]=BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    i=2;
    m_dot(i)=0.625;
% else
%     m_dot(i)=0.01
%     m_dotmin=m_dot(i);
%     [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
%         ~,~,~,~,~]=BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
%     i=2;
%     m_dot(i)=0.025
% end

while a==1
    [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~]=BraytonCycle(m_dot(i),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    if isnan(net_power(i))
        m_dot(i+1)=m_dot(i)+0.025;
        m_dotmin=m_dot(i);
    elseif net_power(i)>power
        m_dotmax=m_dot(i);
        a=0;
    else
        if net_power(i)<net_power(i-1)
            m_dotmax=m_dot(i);
            a=2;
        else
            m_dot(i+1)=m_dot(i)+0.025;
            m_dotmin=m_dot(i);
        end
    end
    i=i+1;
end


if a==2
    incr=(m_dotmax-m_dotmin)/20;
    for t=1:20
        m_dot2(t)=m_dotmin+t*incr;
        [net_powermax(t),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,...
            ~,~,~,~,~]=BraytonCycle(m_dot2(t),p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    end
    [maxpower,I]=max(net_powermax);
    
    %     if j==1
    %         m_dotmin=m_dot(1);
    %         m_dotmax=m_dot(2);
    %     elseif j==10
    %         m_dotmin=m_dot(9);
    %         m_dotmax=m_dot(10);
    %     else
    %         m_dotmin=m_dot(j-1);
    %         m_dotmax=m_dot(j+1);
    %     end
    if maxpower == 40000
    else
        m_dotcycle=m_dot2(I);
        x=['desired power cannot be achieved, approximate max possible power is ', num2str(maxpower)];
        disp(x)
        [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
            p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dotcycle,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
    end
end

if a==0 || maxpower == 40000
    m_dotcycle=fzero(@specifiedPowerError,[m_dotmin,m_dotmax],[],power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
    [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
        p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dotcycle,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode,0);
end

% [m_dotmin,m_dotmax]=SpecifiedPowerBound(power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
%
% m_dot=fzero(@specifiedPowerError,[m_dotmin,m_dotmax],[],power,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
% [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy] = BraytonCycle(m_dot,p1,T4,PR_c,UA,A_panel,T_amb,fluid,mode);
end

