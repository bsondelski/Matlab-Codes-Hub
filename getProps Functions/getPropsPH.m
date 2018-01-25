function [ T, a, rho ] = getPropsPH( p,h,fluid,mode,check )
% find properties of fluids given enthalpy and pressure
%
% Inputs:
% h: enthalpy [J/kg] - array or scalar value
% p: pressure [kPa]
% fluid: fluid in HEX
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%
% Output array:
% T: temperature [K] - array or scalar value - size matches h input size
% a: speed of sound [m/s]
% rho: density [kg/m^3]

leng = length(h);

if check == 1
    % find temperature
    
    if mode == 1
        c_pval = 1000;              % cp value estimation [J/kg-K]
        T = h./c_pval;              % find temps with h0 at 0K
    elseif mode == 2
        h_fit = h./1000;            % convert to [kJ/kg]
        T = CO2_PH(p,h_fit,'temp');
    elseif mode == 3
        T = zeros(1,leng);
        for i = 1:leng
            T(i) = refpropm('T','H',h(i),'P',p(i),fluid);
        end
    end
    a = zeros(1,leng);
    rho = zeros(1,leng);
    
elseif check == 2
    % find Temperature and speed of sound
    
    if mode == 1
        c_pval = 1000;    % cp value estimation [J/kg-K]
        T = h./c_pval;    % find temps with h0 at 0K
        % Find speed of sound: Cp/Cv=1.28, R=188.9 [J/kg-K]
        a = sqrt(1.28*188.9*T);
    elseif mode == 2
        h_fit = h/1000;           % convert to [kJ/kg]
        [T, a] = CO2_PH(p,h_fit,'temp','ssnd');
    elseif mode == 3
        T = zeros(1,leng);
        a = zeros(1,leng);
        for i = 1:leng
            T(i) = refpropm('T','H',h(i),'P',p(i),fluid);
            a(i) = refpropm('A','H',h(i),'P',p(i),fluid);
        end
    end
    rho = zeros(1,leng);
    
elseif check == 3
    % find temperature, speed of sound, and density
    
    if mode == 1
        c_pval = 1000;     	% cp value estimation [J/kg-K]
        T = h./c_pval;     	% find temps with h0 at 0K
        % Find speed of sound: Cp/Cv=1.28, R=188.9 [J/kg-K]
        a = sqrt(1.28*188.9*T);       
        R = 188.9;          % specific gas constant for CO2 [J/kg-K]
        rho = p/(R*T);      % Ideal gas law
    elseif mode == 2
        h_fit = h/1000;     % convert to [kJ/kg]
        [T, a, rho] = CO2_PH(p,h_fit,'temp','ssnd','dens');   
    elseif mode == 3
        T = zeros(1,leng);
        a = zeros(1,leng);
        rho = zeros(1,leng);
        for i = 1:leng                
            T(i) = refpropm('T','H',h(i),'P',p(i),fluid);    
            rho(i) = refpropm('D','T',T(i),'P',p(i),fluid); 
            a(i) = refpropm('A','H',h(i),'P',p(i),fluid);   
        end
    end
end
end

