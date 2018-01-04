%first paper
%LT
% T_H_in=191.95+273.15;   %K
% T_C_in=68.2+273.15;     %K
% T_H_out=78.55+273.15;   %K
% p_H_in=100*86.89;       %kPa
% p_H_out=100*85.37;      %kPa
% p_C_in=100*238.69;      %kPa
% p_C_out=100*238.51;     %kPa
% m_dot_H=100.17;         %kg/s
% m_dot_C=64.51;          %kg/s

%HT
% T_H_in=578.15+273.15;   %K
% T_C_in=181.95+273.15;   %K
% T_H_out=191.95+273.15;  %K
% p_H_in=100*89.62;       %kPa
% p_H_out=100*86.87;      %kPa
% p_C_in=100*237.48;      %kPa
% p_C_out=100*237.48;     %kPa
% m_dot_H=100.17;         %kg/s
% m_dot_C=100.17;         %kg/s

%Creare
T_H_in=989;             %K
T_C_in=376;             %K
T_H_out=418;            %K
p_H_in=205;             %kPa
p_H_out=203;            %kPa
p_C_in=326;             %kPa
p_C_out=323;            %kPa
m_dot_H=0.0323;         %kg/s
m_dot_C=0.0323;         %kg/s


fluid_C='CO2';
fluid_H='CO2';
mode=2;

%discretize HEX
N=20;                   %number of sub HEX's


%%%%%%%%%%%%%%calculate pressures for points along HEX 
%preallocate space
p_H=zeros(1,(N+1));
p_C=zeros(1,(N+1));

%initial pressures values for inlets of HEX
p_H(1)=p_H_in;              %hot side inlet pressure
p_C(1)=p_C_out;              %cold side inlet pressure

%find pressure change for each sub HEX
ploss_C=(p_C_in-p_C_out)/N;
ploss_H=(p_H_in-p_H_out)/N;

%enthalpy values for outlet and inlet of each sub HEX
for i=2:(N+1)
    p_H(i)=p_H(i-1)-ploss_H;            %calculate hot side pressure at outlet of sub HEX
    p_C(i)=p_C(i-1)+ploss_C;            %calculate cold side pressure at outlet of sub HEX    
end


%calculate enthalpies of fully specified states
[~,~,h_H_in]=getPropsTP(T_H_in,p_H(1),fluid_H,mode,1); %hot side inlet enthalpy
[~,~,h_H_out]=getPropsTP(T_H_out,p_H(N+1),fluid_H,mode,1); %hot side outlet properties
[~,~,h_C_in]=getPropsTP(T_C_in,p_C(1),fluid_C,mode,1); %cold side inlet properties

%calculate total heat transfer
q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate

%calculate enthalpy of cold side outlet
h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet
[~,~,h_C_max]=getPropsTP(T_H_in,p_C(N+1),fluid_C,mode,1);  %find max possible enthalpy for cold side

if h_C_out>(h_C_max)
    %return an error of NaN because this enthalpy will not result in a
    %realistic answer
    err=NaN;
else
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
    [T_H,~,~]=getPropsPH(p_H,h_H,fluid_H,mode,1);
    [T_C,~,~]=getPropsPH(p_C,h_C,fluid_C,mode,1);
    
    Tdiff=T_H-T_C;      %temperature value difference throughout HEX
    
    if any(Tdiff(:)<0)  %check for non-physical answers
        err=NaN;
    else
        %capacitance rates
        C_dot_H=m_dot_H.*(h_H(1:N)-h_H(2:(N+1)))./(T_H(1:N)-T_H(2:(N+1)));  %hot side capacitance rates
        %h_H1-h_H2                T_H1-T_H2
        
        C_dot_C=m_dot_C.*(h_C(1:N)-h_C(2:(N+1)))./(T_C(1:N)-T_C(2:(N+1)));  %cold side capacitance rates
%         change=find(C_dot_C==Inf);
%         C_dot_C(change)=9999;
        C_dot_min=min(C_dot_C,C_dot_H);                     %minimum capacitance rates
        C_dot_max=max(C_dot_C,C_dot_H);                     %maximum capacitance rates
        epsilon=q_dot./(N.*C_dot_min.*(T_H(1:N)-T_C(2:(N+1))));             %effectiveness of sub HEXs
        
        if any(epsilon(:)>1)    %check for non-physical answers
            err=NaN;
        else
            C_R=C_dot_min./C_dot_max;                           %capacity ratio of sub HEXs
            inds=find(C_R==1);                                  %find the indicies of the C_R members that are 1
            NTU=log((1-epsilon.*C_R)./(1-epsilon))./(1-C_R);    %NTU of sub HEXs
            NTU(inds)=epsilon(inds)./(1-epsilon(inds));         %NTU of sub HEXs where C_R is 1
            %conductance comparison
            UA_each=NTU.*C_dot_min;     %conductance in sub HEX
            UA_total=sum(UA_each)       %UA calculated with temp guess
        end
    end
end
