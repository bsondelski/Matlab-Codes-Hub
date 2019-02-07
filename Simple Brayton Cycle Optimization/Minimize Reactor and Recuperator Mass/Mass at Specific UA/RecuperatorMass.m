function [ mass ] = RecuperatorMass( p2,T5,p5,Material,UA,fluid,mode )
% Inputs:
% T5: hot side inlet temperature (used for allowable stress scaling) [K]
% RecupMatl: 'IN' for Inconel, 'SS' for stainless steel,
%   for recuperator far term exploration, use 'U#' -
%   uninsulated, # of units, 'I#' -insulated, # of units
%   (all units are Inconel for these cases)
% UA: Recuperator conductance [W/K]
% fluid: working fluid of cycle

% Output:
% mass: total unit mass [kg]


[~,rhoHot,~] = getPropsTP(T5,p5,fluid,mode,2);
[~,rhoCold,~] = getPropsTP(T5,p2,fluid,mode,2);

tf = iscell(fluid(1));
if tf == 1
    %     comp = cell2mat(fluid(3));
    %     if strcmp(fluid{1},'WATER') == 1
    %         fluid{1} = 'H2O';
    %     elseif strcmp(fluid{2},'WATER') == 1
    %         fluid{2} = 'H2O';
    %     end
    %     fluidin = py.dict(pyargs(fluid{1},comp(1),fluid{2},comp(2)));
    
elseif strcmp(fluid,'CO2') == 1
    % set original pressure, temperature, and density valuesosn email 
    ORIGINAL_T5 = 823.15; % K
    ORIGINAL_P2 = 18000; % kPa
    ORIGINAL_P5 = 9229.3; % kPa
    [~,rhoColdDesign,~] = getPropsTP(ORIGINAL_T5,ORIGINAL_P2,fluid,mode,2);
    [~,rhoHotDesign,~] = getPropsTP(ORIGINAL_T5,ORIGINAL_P5,fluid,mode,2);
    
    % temp values [K]
    Temp = [204, 316, 426, 482, 538, 648, 760, 815];
    Temp = Temp + 273.15;
    
%     %%%%%%%%%%%%%%%%
%     % set pressure values
%     designPressure = 13500*0.145038;
%     operatingPressure = 13500*0.145038;
    
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
        
%         % get actual mass
% %         mass5 = (Stress_allow_550C + 0.6*designPressure)/(Stress_allow_T + 0.6*operatingPressure)*Mass_550C;
%         mass5 = Stress_allow_550C/Stress_allow_T*Mass_550C;
%         %     mass6 = Stress_allow_650C/Stress_allow_T*Mass_650C;
%         %     massvec = [mass5,mass6];
%         %     mass = mean(massvec);
%         mass = mass5;
        
tubeFrac = 0.2272;
        
        
    elseif Material == 'IN'
        Stress_allow = [42600, 40300, 40000, 40000, 40000, 33100, 10700, 3200];
        
        % baseline values 550
        Slope_550C = 0.002034545455;
        Intercept_550C = 8.481818182;
        Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
        
        % it was decided to only extrapolate from 550C
%         % baseline values 650
%         Slope_650C = 0.002890909091;
%         Intercept_650C = 13.13636364;
%         Stress_allow_650C = spline(Temp, Stress_allow, 650+273.15);
%         
%         % baseline values 750
%         Slope_750C = 0.005772727273;
%         Intercept_750C = 32.00909091;
%         Stress_allow_750C = spline(Temp, Stress_allow, 750+273.15);
        
        % get baseline masses
        Mass_550C = Slope_550C*UA + Intercept_550C;
%         Mass_650C = Slope_650C*UA + Intercept_650C;
%         Mass_750C = Slope_750C*UA + Intercept_750C;

        % get allowable stress at T5
        Stress_allow_T = spline(Temp, Stress_allow, T5);
%         
%         % get actual mass
% %         mass5 = (Stress_allow_550C + 0.6*designPressure)/(Stress_allow_T + 0.6*operatingPressure)*Mass_550C;
%         mass5 = Stress_allow_550C/Stress_allow_T*Mass_550C;
% %         mass6 = Stress_allow_650C/Stress_allow_T*Mass_650C;
% %         mass7 = Stress_allow_750C/Stress_allow_T*Mass_750C;
% %         massvec = [mass5,mass6,mass7];
% %         mass = mean(massvec);
%         mass = mass5;
tubeFrac = 0.5716;
    elseif Material == 'U1'
        mass = 0.005963636363636*UA + 29.145454545454552;
    elseif Material == 'U2'
        mass = 0.004981818181818*UA + 17.872727272727278;
    elseif Material == 'U4'
        mass = 0.004578181818182*UA + 13.887272727272734;
    elseif Material == 'I1'
        mass = 0.003022727272727*UA + 13.859090909090911;
    elseif Material == 'I2'
        mass = 0.002521818181818*UA + 9.372727272727278;
    elseif Material == 'I4'
        mass = 0.002530909090909*UA + 7.436363636363637;
    end
    
    massTubes = tubeFrac*Mass_550C;
        massTubesNew = massTubes*(Stress_allow_550C/Stress_allow_T)*(p2/ORIGINAL_P2)*(rhoColdDesign/rhoCold);
        
        massShell = Mass_550C - massTubes;
        massShellNew = massShell*(Stress_allow_550C/Stress_allow_T)*(p5/ORIGINAL_P5)*(rhoHotDesign/rhoHot);
        
        mass = massShellNew + massTubesNew;
elseif strcmp(fluid,'WATER') == 1
    fluidin = 'H2O';
    
    % temp values [K]
    Temp = [204, 316, 426, 482, 538, 648, 760, 815];
    Temp = Temp + 273.15;
    
    if Material == 'SS'
        % maximum allowable stress corresponding with Temp array [PSI]
        Stress_allow = [18300, 16600, 15200, 14600, 14000, 6100, 2300, 1400];
        
        % baseline values 550
        Slope_550C = 0.000413636363636364;
        Intercept_550C = 1.605454545454547;
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
        Slope_550C = 0.000147272727272727;
        Intercept_550C = 2.560909090909092;
        Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
        
        % baseline values 650
        Slope_650C = 0.000264545454545455;
        Intercept_650C = 4.611818181818183;
        Stress_allow_650C = spline(Temp, Stress_allow, 650+273.15);
        
        % get baseline masses
        Mass_550C = Slope_550C*UA + Intercept_550C;
        Mass_650C = Slope_650C*UA + Intercept_650C;
        % get allowable stress at T5
        Stress_allow_T = spline(Temp, Stress_allow, T5);
        % get actual mass
        mass5 = Stress_allow_550C/Stress_allow_T*Mass_550C;
        mass6 = Stress_allow_650C/Stress_allow_T*Mass_650C;
        massvec = [mass5,mass6];
        mass = mean(massvec);
    end
    
    
end

