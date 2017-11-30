function [err] = errorGenOldRevB(T_H_out,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N)
%Description: finds the difference between given conductance and the conductnace 
%of the heat exchanger defined by the given inlet and outlet conditions 
%
%Inputs:
%T_H_out=guessed value for outlet temperature at hot side of HEX [K]
%T_H_in=inlet temperature at hot side of HEX [K]
%T_C_in=inlet temperature at cold side of HEX [K]
%p_H=hot side pressure [kPa]
%p_C=cold side pressure [kPa]
%m_dot_H=hot side mass flow rate [kg/s]
%m_dot_C=cold side mass flow rate [kg/s]
%UA=conductance [W/K]
%fluidC=cold side fluid
%fluidH=hot side fluid
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%Output:
%err=magnitude of the difference between the HEX conductance defined by
%T_H_out, T_H_in, and T_C_in and the actual, given HEX conductance

%calculate enthalpies of fully specified states
h_H_in=findproperties3(T_H_in,p_H,fluid_H,mode); %hot side inlet properties
h_H_out=findproperties3(T_H_out,p_H,fluid_H,mode); %hot side outlet properties
h_C_in=findproperties3(T_C_in,p_C,fluid_C,mode); %cold side inlet properties

%calculate total heat transfer
q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate

%calculate enthalpy of cold side outlet
h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet
try
    %find temperature of cold side outlet
    T_C_out=findpropertiesT1(h_C_out,p_C,fluid_C,mode); %find outlet temperature for cold side
    
    %discretize HEX
    % N=10;                   %number of sub HEX's
    
    %preallocate space
    h_H=zeros(1,(N+1));
    h_C=zeros(1,(N+1));
    
    %initial enthalpy values for inlet of first sub HEX
    h_H(1)=h_H_in;              %hot side inlet enthalpy
    h_C(1)=h_C_out;             %cold side outlet enthalpy
    
    %enthalpy values for outlet and inlet of each sub HEX
    for i=2:(N+1)
        h_H(i)=h_H(i-1)-q_dot/(N*m_dot_H);      %calculate hot side enthalpy at outlet of sub HEX
        h_C(i)=h_C(i-1)-q_dot/(N*m_dot_C);      %calculate cold side enthalpy at outlet of sub HEX
    end
    
    %find tepmerature values for outlet and inlet of each sub HEX
    [T_H,T_C]=findpropertiesT(T_H_in,p_H,p_C,fluid_C,fluid_H,mode,N,T_C_out,h_H,h_C);
    
    %capacitance rates
    C_dot_H=m_dot_H.*(h_H(1:N)-h_H(2:(N+1)))./(T_H(1:N)-T_H(2:(N+1)));  %hot side capacitance rates
    %h_H1-h_H2                T_H1-T_H2
    C_dot_C=m_dot_C.*(h_C(1:N)-h_C(2:(N+1)))./(T_C(1:N)-T_C(2:(N+1)));  %cold side capacitance rates
    C_dot_min=min(C_dot_C,C_dot_H);                     %minimum capacitance rates
    C_dot_max=max(C_dot_C,C_dot_H);                     %maximum capacitance rates
    epsilon=q_dot./(N.*C_dot_min.*(T_H(1:N)-T_C(2:(N+1))));             %effectiveness of sub HEXs
    C_R=C_dot_min./C_dot_max;                           %capacity ratio of sub HEXs
    NTU=log((1-epsilon.*C_R)./(1-epsilon))./(1-C_R);    %NTU of sub HEXs
    
    %conductance comparison
    UA_each=NTU.*C_dot_min;     %conductance in sub HEX
    UA_total=sum(UA_each);      %UA calculated with temp guess
    err=UA_total-UA;       %returns magnitude ofdifference between UA calculated and given
    if imag(err)>0
        err=NaN;
    end
catch
    err=NaN;
end
end