%%for plotting error vs TH guess!!!
T_H_in=1084;
T_C_in=241;
N=20;
p_H=ones(1,N+1);
p_H=p_H.*1500;
p_C=ones(1,N+1);
p_C=p_C.*3000;
m_dot_H=1;
m_dot_C=1;
fluid_C='CO2';
fluid_H='CO2';
UA=15000;

mode=2;

TH=T_C_in:0.001:250;

for i=1:length(TH)
    err(i)=errorGen(TH(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
end

for i=1:length(TH)
    [~,~,h_H_in]=getPropsTP(T_H_in,p_H(1),fluid_H,mode,1); %hot side inlet enthalpy
    [~,~,h_H_out]=getPropsTP(TH(i),p_H(N+1),fluid_H,mode,1); %hot side outlet properties
    [~,~,h_C_in]=getPropsTP(T_C_in,p_C(1),fluid_C,mode,1); %cold side inlet properties

    
    %calculate total heat transfer
    q_dot=m_dot_H*(h_H_in-h_H_out); %total heat transfer rate
    
    %calculate enthalpy of cold side outlet
    h_C_out=h_C_in+q_dot/m_dot_C;   %specific heat capacity for cold side outlet
    
    %find temperature of cold side
    try
        [T_C_out(i),~,~]=getPropsPH(p_C(N+1),h_C_out,fluid_C,mode,1); %find outlet temperature for cold side
    catch
        T_C_out(i)=100;
    end
end
err
plot(TH,T_C_out)
title('TC_out')
figure
plot(TH,err)
title('err')