% 
% %case 1&2
% UA = 9600;
% fluid = 'CO2';
% fluid_C = fluid;
% fluid_H = fluid;
% T_H_in = 1006.1;
% T_C_in = 522.5297;
% p_H_in = 9229.3;
% p_C_in = 18000;
% dp_c = 0.0052;
% dp_H = 0.015;
% % dp_c = 0.01;
% % dp_H = 0.03;
% p_C_out = p_C_in - dp_c*p_C_in;
% p_H_out = p_H_in - dp_H*p_H_in;
% m_dot_C = 0.7922;
% m_dot_H = 0.7922;
% mode = 3;
% ploton = 0;
% 
% [T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,0)
% 
% 
% [~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
% [~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
% [~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);
% 
% 
% %case3,4,5
% UA = 15000;
% % fluid = 'CO2';
% % fluid = 'WATER';
% fluid = 'AMMONIA';
% fluid_C = fluid;
% fluid_H = fluid;
% T_H_in = 1006.1;
% T_C_in = 522.5297;
% p_H_in = 25637;
% p_C_in = 50000;
% dp_c = 0.0052;
% dp_H = 0.015;
% p_C_out = p_C_in - dp_c*p_C_in;
% p_H_out = p_H_in - dp_H*p_H_in;
% m_dot_C = 0.7922;
% m_dot_H = 0.7922;
% mode = 3;
% ploton = 0;
% 
% [T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)
% 
% 
% [~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
% [~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
% [~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);
% 
% 
% %case 6
% UA = 6570;
% fluid = 'WATER';
% fluid_C = fluid;
% fluid_H = fluid;
% T_H_in = 1006.1; 
% T_C_in = 522.5297;
% p_H_in = 25637;
% p_C_in = 50000;
% dp_c = 0.0052;
% dp_H = 0.015;
% p_C_out = p_C_in - dp_c*p_C_in;
% p_H_out = p_H_in - dp_H*p_H_in;
% m_dot_C = 0.7922;
% m_dot_H = 0.7922;
% mode = 3;
% ploton = 2;
% 
% [T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)
% 
% 
% [~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
% [~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
% [~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);
% 
% HEXeffect = (h_C_out-h_C_in)/(h_H_in-h_C_in)
% 
% 
% 
% % checking code
% 
% %case 1&2
% UA = 58.4;
% fluid = 'CO2';
% fluid_C = fluid;
% fluid_H = fluid;
% T_H_in = 1006.1;
% T_C_in = 522.5297;
% p_H_in = 9229.3;
% p_C_in = 18000;
% dp_c = 0.0052;
% dp_H = 0.015;
% % dp_c = 0.01;
% % dp_H = 0.03;
% p_C_out = p_C_in - dp_c*p_C_in;
% p_H_out = p_H_in - dp_H*p_H_in;
% m_dot_C = 0.7922;
% m_dot_H = 0.7922;
% mode = 3;
% ploton = 0;
% 
% [T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)
% 
% 
% [~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
% [~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
% [~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);
% 
% HEXeffect = (h_C_out-h_C_in)/(h_H_in-h_C_in)

UA = linspace(500,40000,200);
for i = 1:length(UA)
%case 6
UA = 6761;
fluid = 'WATER';
fluid_C = fluid;
fluid_H = fluid;
T_H_in = 1006.1; 
T_C_in = 650;
p_H_in = 25637;
p_C_in = 50000;
dp_c = 0.0052;
dp_H = 0.015;
p_C_out = p_C_in - dp_c*p_C_in;
p_H_out = p_H_in - dp_H*p_H_in;
m_dot_C = 0.7922;
m_dot_H = 0.7922;
mode = 3;
ploton = 1;

[T_H_out, T_C_out,h_C_out,p_H,p_C,T_H,T_C] = HEX_bettersolve(T_H_in,T_C_in,p_H_in,p_H_out,p_C_in,p_C_out,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,ploton)
end
plot(UA/1000,T_C_out)
xlabel('UA [kW/K]')
ylabel('T_C_,_o_u_t [K]')
grid on

hold on
plot([0 40],[768.3, 768.3],'k')
plot([0 40],[805.7, 805.7],'k')
text(30,763,'T_C_,_o_u_t = 768 [K]')
text(30,800,'T_C_,_o_u_t = 806 [K]')

% [~,~,h_C_out] = getPropsTP(T_C_out,p_C_out,fluid,mode,1);
% [~,~,h_C_in] = getPropsTP(T_C_in,p_C_in,fluid,mode,1);
% [~,~,h_H_in] = getPropsTP(T_H_in,p_H_in,fluid,mode,1);



