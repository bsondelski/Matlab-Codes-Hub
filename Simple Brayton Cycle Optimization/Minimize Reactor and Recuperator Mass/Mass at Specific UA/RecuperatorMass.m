function [ mass ] = RecuperatorMass( T5,Material,UA )
% temp values [K]
Temp = [204, 316, 426, 482, 538, 648, 760, 815];
Temp = Temp + 273.15;

if Material == 'SS'
    % maximum allowable stress corresponding with Temp array [PSI]
    Stress_allow = [18300, 16600, 15200, 14600, 14000, 6100, 2300, 1400];
    
    % baseline values 550
    Slope_550C = 0.004827272727;
    Intercept_550C = 23.59090909;
    Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
    
    % it was decided that recuperator mass at 650 is inaccurate
    %     % baseline values 650
    %     Slope_650C = 0.007236363636;
    %     Intercept_650C = 20.55454545;
    %     Stress_allow_650C = spline(Temp, Stress_allow, 650+273.15);
    
    % get baseline masses
    Mass_550C = Slope_550C*UA + Intercept_550C;
    %     Mass_650C = Slope_650C*UA + Intercept_650C;
    % get allowable stress at T5
    Stress_allow_T = spline(Temp, Stress_allow, T5);
    % get actual mass
    mass5 = Stress_allow_550C/Stress_allow_T*Mass_550C;
    %     mass6 = Stress_allow_650C/Stress_allow_T*Mass_650C;
    %     massvec = [mass5,mass6];
    %     mass = mean(massvec);
    mass = mass5;

elseif Material == 'IN'
    Stress_allow = [42600, 40300, 40000, 40000, 40000, 33100, 10700, 3200];
    
    % baseline values 550
    Slope_550C = 0.002034545455;
    Intercept_550C = 8.481818182;
    Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
    
    % baseline values 650
    Slope_650C = 0.002890909091;
    Intercept_650C = 13.13636364;
    Stress_allow_650C = spline(Temp, Stress_allow, 650+273.15);
    
    % baseline values 750
    Slope_750C = 0.005772727273;
    Intercept_750C = 32.00909091;
    Stress_allow_750C = spline(Temp, Stress_allow, 750+273.15);
    
    % get baseline masses
    Mass_550C = Slope_550C*UA + Intercept_550C;
    Mass_650C = Slope_650C*UA + Intercept_650C;
    Mass_750C = Slope_750C*UA + Intercept_750C;
    % get allowable stress at T5
    Stress_allow_T = spline(Temp, Stress_allow, T5);
    % get actual mass
    mass5 = Stress_allow_550C/Stress_allow_T*Mass_550C;
    mass6 = Stress_allow_650C/Stress_allow_T*Mass_650C;
    mass7 = Stress_allow_750C/Stress_allow_T*Mass_750C;
    massvec = [mass5,mass6,mass7];
    mass = mean(massvec);
end

end

