
%case 1&2
UA = 15000;
fluid = 'CO2';
fluid_C = fluid;
fluid_H = fluid;
T_H_in = 1006.1;
T_C_in = 522.5297;
p_H_in = 9229.3;
p_C_in = 18000;
% dp_c = 0.0052;
% dp_H = 0.015;
dp_c = 0.01;
dp_H = 0.03;
p_C_out = p_C_in - dp_c*p_C_in;
p_H_out = p_H_in - dp_H*p_H_in;
m_dot_C = 0.7922;
m_dot_H = 0.7922;
mode = 2;
ploton = 0;

[T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)


[~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
[~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
[~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);

HEXeffect = (h_C_out-h_C_in)/(h_H_in-h_C_in)

%case3,4,5
UA = 15000;
% fluid = 'CO2';
% fluid = 'WATER';
fluid = 'AMMONIA';
fluid_C = fluid;
fluid_H = fluid;
T_H_in = 1006.1;
T_C_in = 522.5297;
p_H_in = 25637;
p_C_in = 50000;
dp_c = 0.0052;
dp_H = 0.015;
p_C_out = p_C_in - dp_c*p_C_in;
p_H_out = p_H_in - dp_H*p_H_in;
m_dot_C = 0.7922;
m_dot_H = 0.7922;
mode = 3;
ploton = 0;

[T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)


[~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
[~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
[~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);

HEXeffect = (h_C_out-h_C_in)/(h_H_in-h_C_in)


%case 6
UA = 15000;
fluid = 'WATER';
fluid_C = fluid;
fluid_H = fluid;
T_H_in = 969.3553;
T_C_in = 675.6799;
p_H_in = 25637;
p_C_in = 50000;
dp_c = 0.0052;
dp_H = 0.015;
p_C_out = p_C_in - dp_c*p_C_in;
p_H_out = p_H_in - dp_H*p_H_in;
m_dot_C = 0.1855;
m_dot_H = 0.1855;
mode = 3;
ploton = 0;

[T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)


[~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
[~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
[~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);

HEXeffect = (h_C_out-h_C_in)/(h_H_in-h_C_in)




