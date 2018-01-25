function [h,T] = getPropsPS(s,p,substance,mode,check)
% find properties from entropy and pressure
%
% Inputs:
% s: entropy[J/kg-K]
% p: pressure[kPa]
% substance: fluid in HEX
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%
% Output array:
% h: enthalpy[J/kg]
% T: temperature[K]

if check == 1
    % find enthalpy
    
    if mode == 1          
        c_p = 1000;         % cp value estimation [J/kg-K]
        Tref = 273.15;      % Reference Temperature [K]
        R = 188.9;          % specific gas constant for CO2 [J/kg-K]
        pref = 100;         % Reference Pressure [kPa]
        T = Tref*exp((s+R*log(p/pref))/c_p);    % find temp [K]
        h = c_p*T;          % find enthalpy with h0 at 0K
    elseif mode == 2        
        s = s/1000;         % convert entropy to [kJ/kg-K]
        h = CO2_PS(p,s,'enth');     % enthlapy [kJ/kg]
        h = h*1000;         % convert enthalpy to [J/kg]
    elseif mode == 3        % use of REFPROP
        h = refpropm('H','P',p,'S',s,substance); % returns enthalpy [J/kg]
    end
    T=inf;
    
elseif check ==2
    % find temperature
    
    if mode == 2
        s = s/1000;     % convert entropy to [kJ/kg]
        T = CO2_PS(p,s,'temp');
    elseif mode == 3
        T = zeros(1,length(s));
        for i = 1:length(s)
            T(i) = refpropm('T','P',p(i),'S',s(i),fluid);
        end
    end
    h=inf;
    
end
end

