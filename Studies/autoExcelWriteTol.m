
clear
for i=1:16
    Tol(i)=1*10^-i;
    [T_H_out(i), T_C_out(i), elaptime(i)]=HEX_bettersolve(600,290,7390,7390,1.5,0.5,1210,'CO2','CO2',3,Tol(i));
end
[T_H_out(17), T_C_out(17), elaptime(17)]=HEX_bettersolve(600,290,7390,7390,1.5,0.5,1210,'CO2','CO2',3,eps);
filename='C:\Users\sondelski\Documents\MATLAB\exceldoc';
A=[elaptime; T_H_out; T_C_out];
xlswrite(filename,A)