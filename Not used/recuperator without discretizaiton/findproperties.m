function [ props ] = findproperties(T,p,substance)
%find specific heat and density of fluids

%Inputs: 
%T=Temperature[K], p=pressure[kPa], substance=fluid in HEX
%Output array: 
%c=specific heat capacity[J/kg-K], rho=density[kg/m^3]

str=string(substance);
if str=='SCO2'  %use of FIT 
    [cp,rho,mu,k,Pr,h] = FIT_CO2(T,p);
    %returns specific heat (cp) [kJ/kg-K] and density [kg/m^3]
    c=cp*1000;  %convert to [J/kg-K]
else            %use of REFPROP
    c=refpropm('C','T',T,'P',p,substance); %returns specific heat (cp) [J/kg-K]
    rho=refpropm('D','T',T,'P',p,substance); %returns density [kg/m^3]
end


%provide output array of useful properties
props=[c rho];

end

