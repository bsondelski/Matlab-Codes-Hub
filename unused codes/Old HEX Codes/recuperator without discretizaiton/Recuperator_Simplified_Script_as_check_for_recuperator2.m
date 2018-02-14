clear
clc
%simplified version with e_NTU Method - ANALYTICAL
%no descritization
%counter flow HEX, one pass

%%%%%%given (constant?) values - may become inputs later
V_dot_H=0.03;%          %volumetric flow of hot side [m^3/s]
V_dot_C=0.06;%          %volumetric flow of cold side [m^3/s]
p_H=7500;%               %pressure in system [kPa]
p_C=100;
UA=1210;%%%                %conductance [W/K]
T_C_in=90;%%%       %cold side inlet temp [K]
T_H_in=300;%%%       %hot side inlet temp [K]
substance_C='air.mix';%%%%%    %fluid in HEX cold side
substance_H='air.mix';%%%%%%     %fluid in HEX hot side

%create arrays of properties [specific heat[J/kg-K], density [kg/m^3]]
%with inlet temperatures
props_H=findproperties(T_H_in,p_H,substance_H); %hot side properties at inlet
props_C=findproperties(T_C_in,p_C,substance_C); %cold side properties at inlet

%density from properties array and calculation of mass flow rate
rho_C=props_C(2);       %density of cold side fluid [kg/m^3]
rho_H=props_H(2);       %density of hot side fluid [kg/m^3]
m_dot_C=1.5;%rho_C*V_dot_C;  %mass flow of cold side fluid [kg/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%% needs to be changed %%%%%%%%%%%%%%%%%%%%%
m_dot_H=1.5; %rho_H*V_dot_H;  %mass flow of hot side fluid [kg/s]

%guess at outlet temperatures as average of inlet temperatures
T_ave=(T_C_in+T_H_in)/2;    %average of inlet temperatures
T_C_out(1)=T_ave;              %guess cold outlet temp as inlet average temp
T_H_out(1)=T_ave;              %guess hot outlet temp as inlet average temp


T_H_error(1)=1;    %set arbitrary error value to begin while loop
i=2;            %begin counter for solving
while T_H_error(i-1)>0.0001 || T_C_error(i-1)>0.001
    
    %create arrays of properties with average temperature of inlet and outlet
    T_C_ave=(T_C_in+T_C_out(i-1))/2;     %average cold temp
    T_H_ave=(T_H_in+T_H_out(i-1))/2;     %average hot temp
    props_H_ave=findproperties(T_H_ave,p_H,substance_H); %hot side properties as average
    props_C_ave=findproperties(T_C_ave,p_C,substance_C); %cold side properties as average
    
    %specific heat capacity for fluids from properties array
    c_C=props_C_ave(1);      %specific heat capacity for cold side
    c_H=props_H_ave(1);      %specific heat capacity for hot side
    
    %capicatance rates
    C_dot_C=c_C*m_dot_C;    %capacitance rate of cold side
    C_dot_H=c_H*m_dot_H;    %capicatnace rate of hot side
    
    %calculation of NTU and capacity ratio
    C_dot_min=min(C_dot_C,C_dot_H); %minimum capacitance rate
    C_dot_max=max(C_dot_C,C_dot_H); %maximum capacitance rate
    
    NTU=UA/C_dot_min;               %number of transfer units
    C_R=C_dot_min/C_dot_max;        %capacity ratio
    
    %find counter flow effectiveness based on NTU and capacity ratio
    %if C_R==0
    %    epsilon=1-exp(-NTU);
    %elseif C_R==1
    %    epsilon=NTU/(1+NTU);
    %elseif C_R<1
    %    epsilon=(1-exp(-NTU*(1-C_R)))/(1-C_R*exp(-NTU*(1-C_R)));
    %end
    %for example with cross flow ---- must be changed for actual program use
    epsilon=1-exp(NTU^0.22/C_R*(exp(-C_R*NTU^0.78)-1));
    
    %heat transfer rates and exit temperatures
    q_dot_max=C_dot_min*(T_H_in-T_C_in);    %max heat transfer rate
    q_dot=q_dot_max*epsilon;                %actual heat transfer rate
    T_H_out(i)=T_H_in-q_dot/C_dot_H;           %hot side exit temp
    T_C_out(i)=T_C_in+q_dot/C_dot_C;           %cold side exit temp
   
    T_H_error(i)=T_H_out(i)-T_H_out(i-1);  %calculate outlet temp errors
    T_C_error(i)=T_C_out(i)-T_C_out(i-1);
    
    i=i+1;          %increase counter value
end

T_H_out=T_H_out(i-1)
T_C_out=T_C_out(i-1)



