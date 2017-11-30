function [ h ] = findproperties3(T,p,substance,mode)
%find specific heat and density of fluids
%
%Inputs: 
%T=Temperature[K], p=pressure[kPa], substance=fluid in HEX
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%
%Output: 
%h=enthalpy [J/kg]

if mode==1    
    c_pval=1000;        %cp value estimation [J/kg-K]
    h=c_pval*T;         %find enthalpy with h0 at 0K
elseif mode==2           %use of FIT 
%     [~,~,~,~,~,h]=FIT_CO2(T,p);
%     %returns:
%     %cp=specific heat [kJ/kg-K] 
%     %rho=density [kg/m^3]
%     %mu=dynamic viscosity [kg/m-s]
%     %k=conductivity [kW/m-K]
%     %Prandtl number 
%     %enthalpy [kJ/kg]
    h=CO2_TP(T,p,'enth');   %returns enthlapy [kJ/kg]
    h=h*1000;           %convert enthalpy to [J/kg]
elseif mode==3          %use of REFPROP
    h=refpropm('H','T',T,'P',p,substance); %returns enthalpy [J/kg]
end
end