function [s, rho, h] = getPropsTP(T,p,substance,mode,check)
%find entropy, enthalpy, and density of fluids

%Inputs: 
%T=Temperature[K], p=pressure[kPa], substance=fluid in HEX
%Output array: 
%s=entropy[J/kg-K], rho=density[kg/m^3], h=enthalpy[J/kg]

if check==1
    if mode==1
        c_p=1000;        %cp value estimation [J/kg-K]
        h=c_p*T;         %find enthalpy with h0 at 0K
    elseif mode==2           %use of FIT
        h=CO2_TP(T,p,'enth');   %returns enthlapy [kJ/kg]
        h=h*1000;           %convert enthalpy to [J/kg]
    elseif mode==3          %use of REFPROP
        h=refpropm('H','T',T,'P',p,substance); %returns enthalpy [J/kg]
    end
    s=NaN;
    rho=NaN;
elseif check==2
    if mode==1              %constant properties ---fix these later
        c_p=1000;           %cp value estimation [J/kg-K]
        h=c_p*T;            %find enthalpy with h0 at 0K
        R=188.9;            %specific gas constant for CO2 [J/kg-K]
        rho=p/(R*T);        %Ideal gas law    
        Tref=273.15;        %Reference Temperature [K]
        pref=100;           %Reference Pressure [kPa]
        s=c_p*log(T/Tref)-R*log(p/pref);     %find entropy [J/kg-K]
    elseif mode==2           %use of FIT
        [s, rho, h]=CO2_TP(T,p,'entr','dens','enth');
        %returns entropy [kJ/kg-K], density [kg/m3], enthlapy [kJ/kg]
        s=s*1000;           %convert entropy to [J/kg-K]
        h=h*1000;           %convert enthalpy to [J/kg]
    elseif mode==3          %use of REFPROP
        s=refpropm('S','T',T,'P',p,substance); %returns entropy [J/kg-K]
        rho=refpropm('D','T',T,'P',p,substance); %returns density [kg/m^3]
        h=refpropm('H','T',T,'P',p,substance); %returns enthalpy [J/kg]
    end
end
end