function [ T, a, rho ] = getPropsPH( p,h,fluid,mode,check )
%find Temperature of fluids given enthalpy and pressure
%
%Inputs:
%h=enthalpy[kJ/kg] - array or scalar value
%p=pressure[kPa]
%fluid=fluid in HEX
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%
%Output array:
%T=temperature[K] - array or scalar value - size matches h input size

if check==1
    leng=length(h);             %size the input enthalpy vector
    if mode==1                  %constant properties model
        c_pval=1000;                %cp value estimation [J/kg-K]
        T=h./c_pval;                %find temps with h0 at 0K
    elseif mode==2              %use of FIT
        h_fit=h./1000;               %convert to [kJ/kg]
        T=CO2_PH(p,h_fit,'temp');   %find temp values for each enthalpy value
    elseif mode==3              %use of REFPROP
        T=zeros(1,leng);        %preallocate space
        for i=1:leng                %temp values for outlet and inlet of each sub HEX
            T(i)=refpropm('T','H',h(i),'P',p(i),fluid);     %find outlet temperature for each enthalpy value [K]
        end
    end
    a=zeros(1,leng);
    rho=zeros(1,leng);
elseif check==2
    leng=length(h);             %size the input enthalpy vector
    if mode==1                  %constant properties model
        c_pval=1000;                %cp value estimation [J/kg-K]
        T=h./c_pval;                %find temps with h0 at 0K
        a=sqrt(1.28*188.9*T);       %Find speed of sound: Cp/Cv=1.28, R=188.9 [J/kg-K]
    elseif mode==2              %use of FIT
        h_fit=h/1000;               %convert to [kJ/kg]
        [T, a]=CO2_PH(p,h_fit,'temp','ssnd');   %find temp values for each enthalpy value [K] and speed of sound [m/s]
    elseif mode==3              %use of REFPROP
        T=zeros(1,leng);        %preallocate space
        a=zeros(1,leng);        %preallocate space
        for i=1:leng                %temp values for outlet and inlet of each sub HEX
            T(i)=refpropm('T','H',h(i),'P',p(i),fluid);     %find outlet temperature for each enthalpy value [K]
            a(i)=refpropm('A','H',h(i),'P',p(i),fluid);     %find outlet speed of sound for each enthalpy value [m/s]
        end
    end
    rho=zeros(1,leng);
elseif check==3
    leng=length(h);             %size the input enthalpy vector
    if mode==1                  %constant properties model
        c_pval=1000;                %cp value estimation [J/kg-K]
        T=h./c_pval;                %find temps with h0 at 0K
        a=sqrt(1.28*188.9*T);       %Find speed of sound: Cp/Cv=1.28, R=188.9 [J/kg-K]
        R=188.9;            %specific gas constant for CO2 [J/kg-K]
        rho=p/(R*T);        %Ideal gas law  
    elseif mode==2              %use of FIT
        h_fit=h/1000;               %convert to [kJ/kg]
        [T, a, rho]=CO2_PH(p,h_fit,'temp','ssnd','dens');   %find temp values for each enthalpy value [K] and speed of sound [m/s]
    elseif mode==3              %use of REFPROP
        T=zeros(1,leng);        %preallocate space
        a=zeros(1,leng);        %preallocate space
        rho=zeros(1,leng);      %preallocate space
        for i=1:leng                %temp values for outlet and inlet of each sub HEX
            T(i)=refpropm('T','H',h(i),'P',p(i),fluid);     %find outlet temperature for each enthalpy value [K]
            rho(i)=refpropm('D','T',T(i),'P',p(i),fluid); %returns density [kg/m^3]
            a(i)=refpropm('A','H',h(i),'P',p(i),fluid);     %find outlet speed of sound for each enthalpy value [m/s]
        end
    end
end
end

