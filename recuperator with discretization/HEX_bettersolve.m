function [T_H_out, T_C_out, elaptime,h_C_out] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,plot)
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
%fluid_C=cold side fluid
%fluid_H=hot side fluid
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%plot=1(plot on),2(plot off)
%Outputs:
%T_H_out=outlet temperature at hot side of HEX [K]
%T_C_out=outlet temperature at cold side of HEX [K]
%elaptime=time elapsed during running of the process

tic
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
%find bounds for fzero
[ Tmin, Tmax ] = boundFind( T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N );

if isnan(Tmin) || isnan(Tmax)
    %if boundFind failed to find a valid interval, end the function with
    %NaN outputs
    T_H_out=NaN;
    T_C_out=NaN;
    h_C_out=NaN;
else
    %find zero to obtain T_H_out
    options=optimset('TolX',1E-8);              %set tolerancing on solver step size
%     options=[];                                %sets tolerancing to defualt
    T_H_out=fzero(@errorGen,[Tmin,Tmax],options,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
    
    
    %%%%%%%%%%%%%%%%%%%%% only to find T_C_out %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %find enthalpies of fully specified states
    [~,~,h_H_in]=getPropsTP(T_H_in,p_H(1),fluid_H,mode,1);     %hot side inlet properties
    [~,~,h_H_out]=getPropsTP(T_H_out,p_H(N+1),fluid_H,mode,1);   %hot side outlet properties
    [~,~,h_C_in]=getPropsTP(T_C_in,p_C(1),fluid_C,mode,1);     %cold side inlet properties
    
    %calculate total heat transfer
    q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate
    
    %calculate enthalpy of cold side outlet
    h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet
    
    %find temperature of cold side
    [T_C_out,~,~]=getPropsPH(p_C(N+1),h_C_out,fluid_C,mode,1); %find outlet temperature for cold side
    
    if plot==1
        %%%%%%%%%%%%%%%%%%%%% only to plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        [T_H,~,~]=getPropsPH(p_H,h_H,fluid_H,mode,1);
        [T_C,~,~]=getPropsPH(p_C,h_C,fluid_C,mode,1);
        plot(x,T_C,x,T_H)
    end
    
end
elaptime=toc;
end
