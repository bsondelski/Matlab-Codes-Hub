%plots UA vs effectiveness

T_H_in=922;
T_C_in=556;
p_H_in=515;
p_H_out=506;
p_C_in=999;
p_C_out=991;
m_dot_H=1.55;
m_dot_C=1.55;
fluid_C='CO1';
fluid_H='CO2';
mode=2;



UA=300:10:15000;
for i=1:length(UA)
    %discretize HEX
    N=20;                   %number of sub HEX's
    
    %%%%%%%%%%%%%%calculate pressures for points along HEX
    %preallocate space
    p_H=zeros(1,(N+1));
    p_C=zeros(1,(N+1));
    
    %initial pressures values for inlets of HEX
    p_H(1)=p_H_in;              %hot side inlet pressure
    p_C(1)=p_C_in;              %cold side inlet pressure
    
    %find pressure change for each sub HEX
    ploss_C=(p_C_in-p_C_out)/N;
    ploss_H=(p_H_in-p_H_out)/N;
    
    %pressure values for outlet and inlet of each sub HEX
    for j=2:(N+1)
        p_H(j)=p_H(j-1)-ploss_H;            %calculate hot side pressure at outlet of sub HEX
        p_C(j)=p_C(j-1)-ploss_C;            %calculate cold side pressure at outlet of sub HEX
    end
    
    %find bounds for fzero
    [ Tmin, Tmax ] = boundFind( T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA(i),fluid_C,fluid_H,mode,N );
    
    if isnan(Tmin) || isnan(Tmax)
        %if boundFind failed to find a valid interval, end the function with
        %NaN outputs
        T_H_out=NaN;
        T_C_out=NaN;
    else
        %find zero to obtain T_H_out
        options=optimset('TolX',1E-8);              %set tolerancing on solver step size
        %     options=[];                                %sets tolerancing to defualt
        T_H_out=fzero(@errorGen,[Tmin,Tmax],options,T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA(i),fluid_C,fluid_H,mode,N);
        
        
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
        
        %preallocate space
        h_H=zeros(1,(N+1));
        h_C=zeros(1,(N+1));
        
        %initial enthalpy values for inlet of first sub HEX
        h_H(1)=h_H_in;              %hot side inlet enthalpy
        h_C(1)=h_C_out;             %cold side outlet enthalpy
        
        %enthalpy values for outlet and inlet of each sub HEX
        for j=2:(N+1)
            h_H(j)=h_H(j-1)-q_dot/(N*m_dot_H);      %calculate hot side enthalpy at outlet of sub HEX
            h_C(j)=h_C(j-1)-q_dot/(N*m_dot_C);      %calculate cold side enthalpy at outlet of sub HEX
        end
        
        %find tepmerature values for outlet and inlet of each sub HEX
        [T_H,~,~]=getPropsPH(p_H,h_H,fluid_H,mode,1);
        [T_C,~,~]=getPropsPH(p_C,h_C,fluid_C,mode,1);
        
        C_dot_H=m_dot_H.*(h_H(1:N)-h_H(2:(N+1)))./(T_H(1:N)-T_H(2:(N+1)));  %hot side capacitance rates
        %h_H1-h_H2                T_H1-T_H2
        C_dot_C=m_dot_C.*(h_C(1:N)-h_C(2:(N+1)))./(T_C(1:N)-T_C(2:(N+1)));  %cold side capacitance rates
        C_dot_min=min(C_dot_C,C_dot_H);                     %minimum capacitance rates
        C_dot_max=max(C_dot_C,C_dot_H);                     %maximum capacitance rates
        epsilon=q_dot./(N.*C_dot_min.*(T_H(1:N)-T_C(2:(N+1))));             %effectiveness of sub HEXs
        
        h3(i)=h_C_out;
        h2(i)=h_C_in;
        h5(i)=h_H_in;
    end
end



% plot(UA,epsilon)
effect=(h3-h2)./(h5-h2);
% figure
plot(UA,effect)