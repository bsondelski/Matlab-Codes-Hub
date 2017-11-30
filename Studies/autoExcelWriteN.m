
for i=1:50
    [T_H_out(i), T_C_out(i), elaptime(i)]=HEX_bettersolve(600,290,7390,7390,1.5,0.5,1210,'CO2','CO2',2,i);
end
[T_H_out(51), T_C_out(51), elaptime(51)]=HEX_bettersolve(600,290,7390,7390,1.5,0.5,1210,'CO2','CO2',2,100);
i=[1:50 100];
filename='C:\Users\sondelski\Documents\MATLAB\exceldoc';
A=[elaptime; T_H_out; T_C_out];
xlswrite(filename,A)