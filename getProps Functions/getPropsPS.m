function [h] = getPropsPS(s,p,substance,mode)
%find enthalpy of fluids

%Inputs: 
%s=entropy[J/kg-K], p=pressure[kPa], substance=fluid in HEX
%Output array: 
%h=enthalpy[J/kg]


if mode==1              %constant properties ---fix these later
    c_p=1000;           %cp value estimation [J/kg-K]
    Tref=273.15;        %Reference Temperature [K]
    R=188.9;            %specific gas constant for CO2 [J/kg-K]
    pref=100;           %Reference Pressure [kPa]
    T=Tref*exp((s+R*log(p/pref))/c_p);  %find temp [K]
    h=c_p*T;         %find enthalpy with h0 at 0K
elseif mode==2           %use of FIT 
    s=s/1000;           %convert entropy to [kJ/kg-K]
    h=CO2_PS(p,s,'enth');   
    %enthlapy [kJ/kg]    
    h=h*1000;           %convert enthalpy to [J/kg]
elseif mode==3          %use of REFPROP
    h=refpropm('H','P',p,'S',s,substance); %returns enthalpy [J/kg]
end

end

