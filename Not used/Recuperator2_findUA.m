%%%function [T_H_out,T_C_out] = Recuperator2(T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,substance,Mode)
%
%description: discretized e-NTU method with HES's in series
%development inspiration from John Dyerby's thesis and Nellis and Klein
%section 8.6.3 extension
%Inputs:
%T_H_in=inlet temperature at hot side of HEX [K]
%T_C_in=inlet temperature at cold side of HEX [K]
%p_H=hot side pressure [kPa]
%p_C=cold side pressure [kPa]
%m_dot_H=hot side mass flow rate [kg/s]
%m_dot_C=cold side mass flow rate [kg/s]
%UA=conductance [W/K]
%substance=fluid in HEX
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%Outputs:
%T_H_out=outlet temperature at hot side of HEX [K]
%T_C_out=outlet temperature at cold side of HEX [K]

clear
clc
%%%%%%given values --- to become inputs later
%%%values from 8.6.3 example to check answers
T_H_in=300;         %[K]
T_C_in=90;          %[K]
p_H=7500;           %[kPa]
p_C=100;            %[kPa]
m_dot_H=1.5;        %[kg/s]
m_dot_C=0.15;        %[kg/s]
UA_actual=1210;
substance='air.mix';
mode=3;

%guess at outlet temperature as average of inlet temperatures
T_ave=(T_C_in+T_H_in)/2;    %average of inlet temperatures
T_H_out(1)=T_ave;              %guess hot outlet temp as inlet average temp


%calculate enthalpies of hot side
props_H_in=findproperties2(T_H_in,p_H,substance,mode); %hot side inlet properties
props_H_out=findproperties2(T_H_out,p_H,substance,mode); %hot side outlet properties
h_H_in=props_H_in(3);      %specific heat capacity for hot side inlet
h_H_out=props_H_out(3);      %specific heat capacity for hot side outlet

%calculate total heat transfer
q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate

%calculate enthalpies of cold side
props_C_in=findproperties2(T_C_in,p_C,substance,mode); %cold side inlet properties
h_C_in=props_C_in(3);           %specific heat capacity for cold side inlet
h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet

%find temperature of cold side
T_C_out=findpropertiesT(T_H_in,h_C_out,p_C,substance,mode); %find outlet temperature for cold side

%discretize HEX
N=10;                   %number of sub HEX's
for i=1:N
    q_dot_each(i)=i*q_dot/N;     %total heat transfer at each sub HEX
end

%initial temperature and enthalpy values for inlet of first sub HEX
T_H(1)=T_H_in;              %hot side inlet tempeature
T_C(1)=T_C_out;             %cold side outlet temperature
h_H(1)=h_H_in;              %hot side inlet enthalpy
h_C(1)=h_C_out;             %cold side outlet enthalpy
x(1)=1;                     %start recording x values for plot

%temperature and enthalpy values for outlet and inlet of each sub HEX
for i=2:(N+1)
    x(i)=i;                    %record x values for plot
    h_H(i)=h_H(i-1)-q_dot/(N*m_dot_H);      %calculate hot side enthalpy at outlet of sub HEX
    T_H(i)=findpropertiesT(T_H(i-1),h_H(i),p_H,substance,mode); %find outlet temperature for hot side sub HEX
    h_C(i)=h_C(i-1)-q_dot/(N*m_dot_C);      %calculate cold side enthalpy at outlet of sub HEX
    T_C(i)=findpropertiesT(T_C(i-1),h_C(i),p_C,substance,mode); %find outlet temperature for hot side sub HEX
end

%capacitance rates
for i=1:N
    C_dot_H(i)=m_dot_H*(h_H(i)-h_H(i+1))/(T_H(i)-T_H(i+1));  %hot side capacitance rate
    C_dot_C(i)=m_dot_C*(h_C(i)-h_C(i+1))/(T_C(i)-T_C(i+1));  %cold side capacitance rate
    C_dot_min(i)=min(C_dot_C(i),C_dot_H(i));                 %minimum capacitance rate
    C_dot_max(i)=max(C_dot_C(i),C_dot_H(i));                 %maximum capacitance rate
    epsilon(i)=q_dot/(N*C_dot_min(i)*(T_H(i)-T_C(i+1)));      %effectiveness of sub HEX
    C_R(i)=C_dot_min(i)/C_dot_max(i);                        %capacity ratio of sub HEX
    
    %find NTU based on counter flow effectiveness and capacity ratio of each sub
    %HEX
    if C_R(i)==0
        NTU(i)=-log(1-epsilon(i));
    elseif C_R(i)==1
        NTU(i)=epsilon(i)/(1-epsilon(i));
    elseif C_R<1
        NTU(i)=log((1-epsilon(i)*C_R(i))/(1-epsilon(i)))/(1-C_R(i));
    end
    
    UA(i)=NTU(i)*C_dot_min(i);      %conductance in sub HEX
end
UA_total=sum(UA);                   %UA calculated with temp guess

plot(x,T_C,x,T_H)
%end









