clear

p1 = 9000;
T4 = 1100;
PR_c = 2;
A_panel = 40:10:120;

T_amb = 100;
fluid = 'CO2';
mode = 2;

desiredPower = 40000;

p1=8000:500:10000;

for i = 1:length(p1)
    [ mass(i),A_pan_min(i) ] = minMass( p1(i),T4,PR_c,T_amb,fluid,mode,desiredPower,A_panel );
end

plot(p1,mass)
xlabel('Low side pressure [kPa]')
ylabel('Mass [kg]')

figure
plot(p1,A_pan_min)
xlabel('Low side pressure [kPa]')
ylabel('Panel Area at Minimum Mass [m^2]')



clear p1
clear mass
clear A_pan_min
p1=9000;
T4=950:50:1100;
clear A_panel
A_panel = 60:10:120;

for i = 1:length(T4)
    if i == length(T4)
        clear A_panel
        A_panel = 50:10:120;
    end
    [ mass(i),A_pan_min(i) ] = minMass( p1,T4(i),PR_c,T_amb,fluid,mode,desiredPower,A_panel );
end

figure
plot(T4,mass)
xlabel('Hot side temperature [K]')
ylabel('Mass [kg]')

figure
clear A_panel
A_panel = 60:10:120;
plot(T4,A_pan_min)
xlabel('Hot side temperature [K]')
ylabel('Panel Area at Minimum Mass [m^2]')


clear T4
clear mass
clear A_pan_min
T4=1100;
PR_c=1.5:0.5:3;
clear A_panel
A_panel = 50:10:90;

for i = 1:length(PR_c)
    if i == length(PR_c)
        A_panel = 50:10:90;
    elseif i == length(PR_c)-1
        A_panel = 50:10:90;
    end
    [ mass(i),A_pan_min(i) ] = minMass( p1,T4,PR_c(i),T_amb,fluid,mode,desiredPower,A_panel );
end

figure
plot(PR_c,mass)
xlabel('Pressure Ratio')
ylabel('Mass [kg]')

figure
plot(PR_c,A_pan_min)
xlabel('Pressure Ratio')
ylabel('Panel Area at Minimum Mass [m^2]')