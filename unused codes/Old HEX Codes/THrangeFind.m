function [ T_H_min, T_H_max ] = THrangeFind(T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% 
N=(T_H_in-T_C_in)/10-1;       %decide number of loops

T_H_out=zeros(1,N);         %Create T_H_out array
err_find=zeros(1,N);

for i=1:N
    T_H_out(i)=T_C_in+10*i;
end

T_H_out=[T_C_in+1 T_H_out T_H_in-1];

for i=1:N+2
    err_find(i)=errorGen(T_H_out(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode)
end


% N=(T_H_in-T_C_in)/5-1;       %decide number of loops
% 
% T_H_out=zeros(1,N);         %Create T_H_out array
% err_find=zeros(1,N);
% 
% for i=1:N
%     T_H_out(i)=T_C_in+5*i;
% end
% 
% T_H_out=[T_C_in+1 T_H_out T_H_in-1];
% 
% for i=1:N+2
%     err_find(i)=errorGen(T_H_out(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode)
% end



end

