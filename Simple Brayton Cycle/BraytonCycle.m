function [net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,...
    q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,...
    p5,T6,p6,A_panel,Vratio] = BraytonCycle(m_dot,p1,T4,PR_c,UA,...
    A_panel,T_amb,fluid,mode,plot)

% Inputs:
% m_dot: the mass flow in the cycle [kg/s]
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor 
% UA: conductance of recuperator [W/K]
% A_panel: area of radiator panel [m2]
% T_amb: temperature of surrounding space for radiator heat sink [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% plot: 1(on), 0 (off)

% outputs:
% net_power: net power output from the cycle [W]
% cyc_efficiency: total cycle efficiency [1st law efficiency, 2nd law
%                 efficiency]
% D_T: turbine diameter [m]
% D_c: compressor diameter [m]
% Ma_T: Turbine outlet Mach number
% Ma_c: compressor outlet Mach number
% Anozzle: turbine nozzle area [m^2]
% q_reactor: heat input to the reactor [W]
% q_rad: heat rejected by the radiator [W]
% T1: the temperatue at the inlet of the compressor
% Power_T: power output of the turbine [W]
% Power_c: power intake of the compressor [W]
% HEXeffect: approximate effectiveness of the heat exchanger
% energy: check to see if energy is conserved (should be zero) - does not
%         account for pressure drops
% temperatures and pressures at all state points
% A_panel: area of radiator panel [m2]
% Vratio: velocity ratio of turbine

[p2,p3,p4,p6,p5,~] = findPressures(p1,PR_c);
    
    
tf = iscell(fluid(1));
if tf == 1
    TLowerBound = mode(1);
else
    names = ["CO2", "HELIUM", "CO", "OXYGEN", "H2S", "AMMONIA", "WATER"];
    minT = [304.25, 2.18, 68.2, 54.4, 200, 240, 280];
    TLowerBound = minT(names == fluid);
end
    
    % find bounds for fzero
    [Tmin,Tmax] = BraytonCycleBoundFind(m_dot,p1,T4,TLowerBound,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5);
    if isnan(Tmin) && isnan(Tmax)
        % T1 is below minimum fluid temperature for this cycle 
        net_power = NaN;
        cyc_efficiency = NaN;
        D_T = NaN;
        D_c = NaN;
        Ma_T = NaN;
        Ma_c = NaN;
        Anozzle = NaN;
        q_reactor = NaN;
        q_rad = NaN;
        T1 = NaN;
        Power_T = NaN;
        Power_c = NaN;
        HEXeffect = NaN;
        energy = NaN;
        p1 = NaN;
        T2 = NaN;
        p2 = NaN;
        T3 = NaN;
        p3 = NaN;
        T4 = NaN;
        p4 = NaN;
        T5 = NaN;
        p5 = NaN;
        T6 = NaN;
        p6 = NaN;
        A_panel = NaN;
        Vratio = NaN;
    else
        
        % iterate to solve for compressor inlet temp
        T1 = fzero(@simpleCycleError,[Tmin,Tmax],[],m_dot,p1,T4,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5,TLowerBound);
        
        % solve for state after compressor
        [T2,D_c,N,Power_c,Ma_c,h2] = Compressor(m_dot,T1,p1,p2,fluid,mode);
        
        % solve for state after turbine
        [p5,T5,D_T,Power_T,Ma_T,Anozzle,h5,Vratio] = Turbine(m_dot,T4,p4,p5,fluid,mode,N);
        
        % solve for recuperator outlets
        [T6, T3,~,p_H,p_C,T_H,T_C] = HEX_bettersolve(T5,T2,p5,p6,p2,p3,m_dot,m_dot,UA,fluid,fluid,mode,1);
        
        if isnan(T6)
            % The recuperator is too small
            net_power = NaN;
            cyc_efficiency = NaN;
            D_T = NaN;
            D_c = NaN;
            Ma_T = NaN;
            Ma_c = NaN;
            Anozzle = NaN;
            q_reactor = NaN;
            q_rad = NaN;
            T1 = NaN;
            Power_T = NaN;
            Power_c = NaN;
            HEXeffect = NaN;
            energy = NaN;
            p1 = NaN;
            T2 = NaN;
            p2 = NaN;
            T3 = NaN;
            p3 = NaN;
            T4 = NaN;
            p4 = NaN;
            T5 = NaN;
            p5 = NaN;
            T6 = NaN;
            p6 = NaN;
            A_panel = NaN;
            Vratio = NaN;
        else
            
            % radiator
            [q_rad,~,A_panel] = Radiator(m_dot,A_panel,T_amb,T6,TLowerBound,p6,p1,fluid,mode);
            
            % solve for state after reactor
            [~,~,h4] = getPropsTP(T4,p4,fluid,mode,1);
            [~,~,h3] = getPropsTP(T3,p3,fluid,mode,1);
            q_reactor = m_dot*(h4-h3);
            
            % power and efficiency of cycle
            net_power = Power_T-Power_c;
            cyc_efficiency(1) = net_power/q_reactor;
            cyc_efficiency(2) = cyc_efficiency(1)/(1-(T1/T4));
            
            % Approximate heat exchanger effectiveness - assuming the pinch
            % point is at one of the endpoints of the HEX
            [~, ~, h_H_min] = getPropsTP(T2,p6,fluid,mode,1);
            q_max_H = m_dot*(h5-h_H_min);
            [~, ~, h_C_max] = getPropsTP(T5,p3,fluid,mode,1);
            q_max_C = m_dot*(h_C_max-h2);
            q_max = min(q_max_H,q_max_C);
            HEXeffect = m_dot*(h3-h2)/q_max;
            
            % energy balance to check for conservation
            energy = -Power_T+Power_c+q_reactor+q_rad;
            
            if plot == 1
                % extra points for reactor and radiator
                
                %%%% minimum temperature for CO2 %%%%
                % change if using a different fluid
                Tminplot = 240; 
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % midpoints for reactor and radiator so curve is more
                % smooth
                T_reactmid = (T3 + T4)/2;
                T_radmid = (T6 + T1)/2;
                p_reactmid = (p3 + p4)/2;
                p_radmid = (p6 + p1)/2;
                
                Tvector = [T1, T2, fliplr(T_C), T3, T_reactmid, T4, T5, T_H, T6, T_radmid, T1];
                pvector = [p1, p2, fliplr(p_C), p3, p_reactmid, p4, p5, p_H, p6, p_radmid, p1];
                
                [ ~ ] = TSDiagram( Tvector,pvector,fluid,mode,Tminplot );
                ylim([Tminplot, T4+50])
            else
            end
        end
    end
    
end

