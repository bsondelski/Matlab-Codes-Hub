

[T_H_out, T_C_out, elaptime,h_C_out] = HEX_bettersolve(1.1127e+03,261.2987,3076.4,3030.3,6000,5968.8,0.3,0.3,5000,'CO2','CO2',2,2)

[err] = errorGen(267.9632352595330,1112.7,261.2987,p_H,p_C,0.3,0.3,5000,'CO2','CO2',2,20)

1.1127e+03,261.2987,3076.4,3030.3,6000,5968.8,0.3,0.3,5000,'CO2','CO2',2,2

[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy,m_dot] = SpecifiedPower(-40000,3000,1200,2,5000,100,100,'CO2',2)

%%%%%%%%%values given to Alex%%%%%%%%%%%%%%%%%%%%%%%%%
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy,p1,T2,p2,T3,p3,T4,p4,T5,p5,T6,p6] = BraytonCycle(0.75,9000,1100,2,10000,100,100,'CO2',2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%% used code that has been replaced but kept here for reference, just
%%% incase

%%%%%%%%%%%%%%  Finding capacitance rates with loop ---- vectorized  %%%%%%%%%%

%preallocate space
% C_dot_H=zeros(1,N);
% C_dot_C=zeros(1,N);
% C_dot_min=zeros(1,N);
% C_dot_max=zeros(1,N);
% epsilon=zeros(1,N);
% C_R=zeros(1,N);
% NTU=zeros(1,N);
% UA_each=zeros(1,N);

% %capacitance rates
% for i=1:N
%     C_dot_H(i)=m_dot_H*(h_H(i)-h_H(i+1))/(T_H(i)-T_H(i+1));  %hot side capacitance rate
%     C_dot_C(i)=m_dot_C*(h_C(i)-h_C(i+1))/(T_C(i)-T_C(i+1));  %cold side capacitance rate
%     C_dot_min(i)=min(C_dot_C(i),C_dot_H(i));                 %minimum capacitance rate
%     C_dot_max(i)=max(C_dot_C(i),C_dot_H(i));                 %maximum capacitance rate
%     epsilon(i)=q_dot/(N*C_dot_min(i)*(T_H(i)-T_C(i+1)));      %effectiveness of sub HEX
%     C_R(i)=C_dot_min(i)/C_dot_max(i);                        %capacity ratio of sub HEX
%     
%     %find NTU based on counter flow effectiveness and capacity ratio of each sub
%     %HEX
%     if C_R(i)==0
%         NTU(i)=-log(1-epsilon(i));
%     elseif C_R(i)==1
%         NTU(i)=epsilon(i)/(1-epsilon(i));
%     elseif C_R<1
%         NTU(i)=log((1-epsilon(i)*C_R(i))/(1-epsilon(i)))/(1-C_R(i));
%     end
%     
%     UA_each(i)=NTU(i)*C_dot_min(i);      %conductance in sub HEX
% end
% UA_total=sum(UA_each);                   %UA calculated with temp guess
% err=UA_total-UA    
% err=abs(UA_total-UA)    %returns magnitude ofdifference between UA calculated and given



%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Using fzero or fminsearch  %%%%%%%%%%%%%%%%%%%%%%%%%%%

% %guess at outlet temperature as average of inlet temperatures
% %%%%%%%%%%%find a better way to find initial first guess
% T_ave=(T_C_in+T_H_in)/2;    %average of inlet temperatures
% T_H_out_guess=T_ave;              %guess hot outlet temp as inlet average temp

% T_H_out=fminsearch(@errorGen,T_H_out_guess,[],T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode);

%%%%%%%%%%%%%%%%%%%using fminbnd%%%%%%%%%
[T_H_out, err]=fminbnd(@errorGen,T_C_in,T_H_in,options,T_H_in,T_C_in,p_H,p_C,...
    m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);

%%%%%%%%%%%%%%%%%%%%%%%% using a script instead of a function  %%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%given values --- to become inputs later
% %%%values from 8.6.3 example to check answers
% T_H_in=500;         %[K]
% T_C_in=300;          %[K]
% p_H=2000;           %[kPa]
% p_C=1000;            %[kPa]
% m_dot_H=1.5;        %[kg/s]
% m_dot_C=1.5;        %[kg/s]
% UA=1210;     %conductance [W/K]
% fluid_C='CO2';
% fluid_H='CO2';
% mode=2;

[T_H_out, T_C_out]=HEX_bettersolve(800,300,1000,1000,1.5,1.5,120,'CO2','CO2',3)
[q_rad,T_out] = Radiator(1.5,3,100,500,2000,'CO2',2)
[p_out,T_out,D,Power,Ma,Anozzle] = Turbine(1.5,900,1500,0.75,'CO2',2,1500)
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor] = BraytonCycleBackwards(1.5,500,2000,2.6,0.75,1210,300,100,'CO2',2)
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,A_panel,q_rad] = BraytonCycle2(1.5,500,2000,805.1711,2533.3,2.6,0.75,1210,100,'CO2',2)
[net_power,cyc_efficiency,D_T,D_c,Ma_T,Ma_c,Anozzle,q_reactor,q_rad,T1,Power_T,Power_c,HEXeffect,energy] = BraytonCycle(1.5,5000,1200,2,1220,100,100,'CO2',2)
[p_out,T_out,D,N,Power,Ma] = Compressor(1.5,300,2000,2.6,'CO2',2)

%%%%%%%%%%%%%%%%%%%%%%%%% using fit without FIT_CO2 to find Temp  %%%%%%%%%%%%%%%%%
%     e=0;                    %to start while loop
%     T=T_guess;              %guess of temperature at outlet
%     er=15;                   %set error value so while loop will begin
%     while er>10
%         if e>0 && e>300
%             T=T-0.1;
%         elseif e<0 && e<-300
%             T=T+0.1;
%         elseif e>0
%             T=T-0.01;
%         elseif e<0
%             T=T+0.01;
%         end
%         [cp,rho,mu,k,Pr,h]=FIT_CO2(T,p)
%         %returns:
%         %cp=specific heat [kJ/kg-K]
%         %rho=density [kg/m^3]
%        %mu=dynamic viscosity [kg/m-s]
%         %k=conductivity [kW/m-K]
%         %Prandtl number
%         %enthalpy [kJ/kg]
%         h_approx=h*1000;     %convert to [J/kg]
%         e=h_approx-h;               %error between guessed enthalpy and actual
%         er=abs(e);               %absolute value of error for while loop progression
%         
%     end

%%%%%%%%%%%%%%%%%%%% solving for enthalpies with a for loop  %%%%%%%%%%%%%%%%%%
%%% in HEX_bettersolve
%preallocate space
T_H=zeros(1,(N+1));              
T_C=zeros(1,(N+1));             
h_H=zeros(1,(N+1));              
h_C=zeros(1,(N+1));             
x=zeros(1,(N+1));                     

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
    T_H(i)=findpropertiesT(T_H(i-1),h_H(i),p_H,fluid_H,mode); %find outlet temperature for hot side sub HEX
    h_C(i)=h_C(i-1)-q_dot/(N*m_dot_C);      %calculate cold side enthalpy at outlet of sub HEX
    T_C(i)=findpropertiesT(T_C(i-1),h_C(i),p_C,fluid_C,mode); %find outlet temperature for hot side sub HEX
end

%%% in errorGen
%preallocate space
T_H=zeros(1,(N+1));              
T_C=zeros(1,(N+1));             
h_H=zeros(1,(N+1));              
h_C=zeros(1,(N+1));

%initial temperature and enthalpy values for inlet of first sub HEX
T_H(1)=T_H_in;              %hot side inlet tempeature
T_C(1)=T_C_out;             %cold side outlet temperature
h_H(1)=h_H_in;              %hot side inlet enthalpy
h_C(1)=h_C_out;             %cold side outlet enthalpy

%temperature and enthalpy values for outlet and inlet of each sub HEX
for i=2:(N+1)
    h_H(i)=h_H(i-1)-q_dot/(N*m_dot_H);      %calculate hot side enthalpy at outlet of sub HEX
    T_H(i)=findpropertiesT(T_H(i-1),h_H(i),p_H,fluid_H,mode); %find outlet temperature for hot side sub HEX
    h_C(i)=h_C(i-1)-q_dot/(N*m_dot_C);      %calculate cold side enthalpy at outlet of sub HEX
    T_C(i)=findpropertiesT(T_C(i-1),h_C(i),p_C,fluid_C,mode); %find outlet temperature for hot side sub HEX
end

%%% in findPropertiesT
function [ T ] = findpropertiesT(T_guess,h,p,substance,mode)
%find Temperature of fluids given enthalpy and pressure

%Inputs:
%h=enthalpy[kJ/kg], p=pressure[kPa], substance=fluid in HEX
%Output array:
%T=temperature[K]



if mode==1              %constant properties ---fix these later
    c=1000;
    rho=12;
elseif mode==2          %use of FIT
    [T]=CO2_PH(p,h,'temp');          %find temp at the state [K]
elseif mode==3          %use of REFPROP
    T=refpropm('T','H',h,'P',p,substance); %returns temperature [K]
end


end






%%for plotting error!!!
T_H_in=500;
T_C_in=300;
p_H=2000;
p_C=9000;
m_dot_H=1.5;
m_dot_C=0.155;
fluid_C='CO2';
fluid_H='CO2';
UA=120;
N=10;
mode=2;

TH=331:500;

for i=1:length(TH)
    err(i)=errorGen(TH(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
end
    
for i=1:length(TH)
    h_H_in=findproperties3(T_H_in,p_H,fluid_H,mode); %hot side inlet properties
    h_H_out=findproperties3(TH(i),p_H,fluid_H,mode); %hot side outlet properties
    h_C_in=findproperties3(T_C_in,p_C,fluid_C,mode); %cold side inlet properties
    
    %calculate total heat transfer
    q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate
    
    %calculate enthalpy of cold side outlet
    h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet
    
    %find temperature of cold side
    T_C_out(i)=findpropertiesT1(h_C_out,p_C,fluid_C,mode); %find outlet temperature for cold side
end
plot(TH,T_C_out)
figure
plot(TH,err)



[T_H_out, T_C_out]=HEX_bettersolve(500,300,2000,9000,1.5,0.155,120,'CO2','CO2',3,10)


%%%%%%%%%tolerancing
,'OptimalityTolerance',1E-5,'StepTolerance',1E-5

%%% beginning attempt at finding min error value/range to search for
%%% fminbnd without using multistart
%set intervals
j=(T_H_in-T_C_in)/20;
TH=zeros(1, j);
T_H_out=zeros(1,j);
err2=zeros(1,j);
[T_H_out(1), err2(1)]=fminsearch(@errorGen,T_C_in,[],T_H_in,T_C_in,p_H,p_C,...
    m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
for l=2:j
    TH(l)=20*(l-1)+T_C_in;
    [T_H_out(l), err2(l)]=fminsearch(@errorGen,TH(l),[],T_H_in,T_C_in,p_H,p_C,...
    m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N)
end

min(err2)

%before adding presearch
HEX_bettersolve

function [T_H_out, T_C_out] = HEX_bettersolve(T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%description: discretized e-NTU method with HEX's in series
%development notes: John Dyerby's thesis and Nellis and Klein
%section 8.6.3 extension
%Inputs:
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
%Outputs:
%T_H_out=outlet temperature at hot side of HEX [K]
%T_C_out=outlet temperature at cold side of HEX [K]

tic

%find zero to find T_H_out
options=optimset('TolX',1e-3);              %set tolerancing on solver step size
% options=[];                                %sets tolerancing to defualt        
[T_H_out, err]=fminbnd(@errorGen,T_C_in,T_H_in,options,T_H_in,T_C_in,p_H,p_C,...
    m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);

%use Global Search if proves that a local minimum was found instead of a
%global minimum

if err>10
    j=(T_H_in-T_C_in)/40;
    %guess at outlet temperature as average of inlet temperatures
    T_ave=(T_C_in+T_H_in)/2;    %average of inlet temperatures
    Problem=createOptimProblem('fmincon','objective',@(T_H_out)errorGen(T_H_out,...
        T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N),'x0',...
        T_ave,'lb',T_C_in,'ub',T_H_in,'options',optimoptions(@fmincon,'algorithm','sqp','Display','none'));
    MS=MultiStart;
    [T_H_out,err]=run(MS, Problem,j);
    if err>10
        [T_H_out,err]=run(MS, Problem,2*j);
        if err>10
            if err>10
                [T_H_out,err]=run(MS, Problem,4*j);
                if err>10
                    fprintf(2, ['Did not converge - error value is ' num2str(err) '\n']);
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%% only to find T_C_out %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find enthalpies of fully specified states
h_H_in=findproperties3(T_H_in,p_H,fluid_H,mode); %hot side inlet properties
h_H_out=findproperties3(T_H_out,p_H,fluid_H,mode); %hot side outlet properties
h_C_in=findproperties3(T_C_in,p_C,fluid_C,mode); %cold side inlet properties

%calculate total heat transfer
q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate

%calculate enthalpy of cold side outlet
h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet

%find temperature of cold side
T_C_out=findpropertiesT1(h_C_out,p_C,fluid_C,mode); %find outlet temperature for cold side


%%%%%%%%%%%%%%%%%%%%% only to plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%discretize HEX
% N=10;                   %number of sub HEX's

%preallocate space
h_H=zeros(1,(N+1));              
h_C=zeros(1,(N+1));             
x=1:(N+1);                     

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

%for user display ----- likely temporary
% T_H_out
% T_C_out
plot(x,T_C,x,T_H)
toc
end



















errorGen
function [err] = errorGen(T_H_out,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N)
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
err=abs(UA_total-UA);       %returns magnitude ofdifference between UA calculated and given
end














errorGen with coding over errors
function [err] = errorGen(T_H_out,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N)
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








%%%%   constant values %%%%%%%%%%

%for T1 props

    h=h/1000;       %convert enthalpy to KJ/kg
    %available temp ranges with corresponding heat capacities
    Temps=[175 200 225 250 275 300 325 350 375 400 450 500 550 600 650 700 ...
        750 800 850 900 950 1000 1050 1100 1150 1200 1250 1300 1350 1400 1500 1600 ...
        1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3500 ...
        4000 4500 5000 5500 6000];
    %corresponding heat capacities (KJ/kg-K) from engineeringtoolbox
    c_p=[0.709 0.735 0.763 0.791 0.819 0.846 0.871 0.895 0.918 0.939 0.978 1.014 ...
        1.046 1.075 1.102 1.126 1.148 1.168 1.187 1.204 1.220 1.234 1.247 1.259 ...
        1.270 1.280 1.290 1.298 1.306 1.313 1.326 1.338 1.348 1.356 1.364 1.371 ...
        1.377 1.383 1.388 1.393 1.397 1.401 1.404 1.408 1.411 1.414 1.427 1.437 ...
        1.446 1.455 1.465 1.476];
    %corresponding enthalpy values KJ/kg
    hVals=Temps.*c_p;
    %find nearest temp value with a corresponding heat capacity value
    hrounded=interp1(hVals,hVals,h,'nearest');
    %locate the value in the temperature array
    hValsRound=ismember(hVals,hrounded);
    %locate the index of the value in the temperature array
    ind=find(hValsRound);
    %find the heat capacity rate
    c_pval=c_p(ind);
    %find the enthalpy with h0 at 0K and convert to J/kg
    T=h/c_pval;     %find enthalpy with h0 at 0K
%     c_pval=1000;    %cp value estimation [J/kg-K]
%     T=h/c_pval;     %find temp with h0 at 0K

%      h=h/1000;     
%     T=07008*h+128.49;     %find enthalpy with h0 at 0K


%for T props

 h_C=h_C/1000;       %convert enthalpy to KJ/kg
    h_H=h_H/1000;
    %available temp ranges with corresponding heat capacities
    Temps=[175 200 225 250 275 300 325 350 375 400 450 500 550 600 650 700 ...
        750 800 850 900 950 1000 1050 1100 1150 1200 1250 1300 1350 1400 1500 1600 ...
        1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3500 ...
        4000 4500 5000 5500 6000];
    %corresponding heat capacities (KJ/kg-K) from engineeringtoolbox
    c_p=[0.709 0.735 0.763 0.791 0.819 0.846 0.871 0.895 0.918 0.939 0.978 1.014 ...
        1.046 1.075 1.102 1.126 1.148 1.168 1.187 1.204 1.220 1.234 1.247 1.259 ...
        1.270 1.280 1.290 1.298 1.306 1.313 1.326 1.338 1.348 1.356 1.364 1.371 ...
        1.377 1.383 1.388 1.393 1.397 1.401 1.404 1.408 1.411 1.414 1.427 1.437 ...
        1.446 1.455 1.465 1.476];
    %corresponding enthalpy values KJ/kg
    hVals=Temps.*c_p;
    
    %cold side
    %find nearest temp value with a corresponding heat capacity value
    hrounded=interp1(hVals,hVals,h_H,'nearest');
    %preallocate
    ind=zeros(1,length(hrounded));
    for i=1:length(hrounded)
        %locate the index of the value in the enthalpy array
        ind(i)=find(hVals==hrounded(i));
    end
    %find the heat capacity rate
    c_pval=c_p(ind);
    %find the enthalpy with h0 at 0K and convert to J/kg
    T_H=h_H./c_pval;
    
    %hot side
    %find nearest temp value with a corresponding heat capacity value
    hroundedh=interp1(hVals,hVals,h_C,'nearest');
    %preallocate
    indh=zeros(1,length(hroundedh));
    for i=1:length(hroundedh)
        %locate the index of the value in the enthalpy array
        indh(i)=find(hVals==hroundedh(i));
    end
    %find the heat capacity rate
    c_pvalh=c_p(indh);
    %find the enthalpy with h0 at 0K and convert to J/kg
    T_C=h_C./c_pvalh;
%     c_pval=1000;            %cp value estimation [J/kg-K]
%     T_H=h_H./c_pval;        %find temp with h0 at 0K
%     c_pvalh=1000;           %cp value estimation [J/kg-K]
%     T_C=h_C./c_pvalh;       %find temp with h0 at 0K

%      h_H=h_H/1000;     
%       h_C=h_C/1000;     
% T_H=07008*h_H+128.49;
% T_C=07008*h_C+128.49;


    
% for 3 props

    %available temp ranges with corresponding heat capacities
    Targets=[175 200 225 250 275 300 325 350 375 400 450 500 550 600 650 700 ...
        750 800 850 900 950 1000 1050 1100 1150 1200 1250 1300 1350 1400 1500 1600 ...
        1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3500 ...
        4000 4500 5000 5500 6000];
    %corresponding heat capacities (KJ/kg-K) from engineeringtoolbox
    c_p=[0.709 0.735 0.763 0.791 0.819 0.846 0.871 0.895 0.918 0.939 0.978 1.014 ...
        1.046 1.075 1.102 1.126 1.148 1.168 1.187 1.204 1.220 1.234 1.247 1.259 ...
        1.270 1.280 1.290 1.298 1.306 1.313 1.326 1.338 1.348 1.356 1.364 1.371 ...
        1.377 1.383 1.388 1.393 1.397 1.401 1.404 1.408 1.411 1.414 1.427 1.437 ...
        1.446 1.455 1.465 1.476];
    %find nearest temp value with a corresponding heat capacity value
    Trounded=interp1(Targets,Targets,T,'nearest');
    %locate the value in the temperature array
    TargetsRound=ismember(Targets,Trounded);
    %locate the index of the value in the temperature array
    ind=find(TargetsRound);
    %find the heat capacity rate
    c_pval=c_p(ind);
    %find the enthalpy with h0 at 0K and convert to J/kg
    h=c_pval*T*1000;
%     c_pval=1000;        %cp value estimation [J/kg-K]
%     h=c_pval*T;         %find enthalpy with h0 at 0K

%     h=1.4247*T-181.64;
%     h=h*1000;           %convert enthalpy to [J/kg]
















