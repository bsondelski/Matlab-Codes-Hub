function [ mass ] = RecuperatorMass( p2,T5,p5,Material,UA,fluid,mode,m_dotNew )
% provides mass of recuperator considering material and flow conditions

% Inputs:
% p2: high pressure side
% T5: hot side inlet temperature (used for allowable stress scaling) [K]
% p5: low pressure side
% RecupMatl: 'IN' for Inconel, 'SN' for near term stainless steel, 'SF' for
%            far term stainless steel
% UA: Recuperator conductance [W/K]
% fluid: working fluid of cycle
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% m_dotNew: mass flow rate [kg/s]

% Output:
% mass: total unit mass [kg]


% state values used to alter mass
[~,rhoCold,~] = getPropsTP(T5,p2,fluid,mode,2);
KPA2PSI = 0.145038;
p2_psi = p2*KPA2PSI;
p5_psi = p5*KPA2PSI;

    
    % set original pressure, temperature, and density values of design
    ORIGINAL_T5 = 823.15; % K
    ORIGINAL_P2 = 18000; % kPa
    ORIGINAL_P2_PSI = ORIGINAL_P2*KPA2PSI; % kPa
    ORIGINAL_P5 = 9229.3; % kPa
    ORIGINAL_P5_PSI = ORIGINAL_P5*KPA2PSI; % kPa
    rhoColdDesign = 112.4303;
    m_dotOriginal = 0.7922;

    % temp values [K]
    Temp = [204, 316, 426, 482, 538, 648, 760, 815];
    Temp = Temp + 273.15;
    
    if Material == 'SN'
        % stainless steel near term
        % maximum allowable stress corresponding with Temp array [PSI]
        Stress_allow = [18300, 16600, 15200, 14600, 14000, 6100, 2300, 1400];
        
        % baseline values 550
        Slope_550C = 0.002112727;
        Intercept_550C = 16.53909091;
        Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
        
        % get baseline masses
        Mass_550C = Slope_550C*UA + Intercept_550C;
        
        % get allowable stress at T5
        Stress_allow_T = spline(Temp, Stress_allow, T5);
        
        % separately scaling mass for shell and tubes
        tubeFrac = 0.2776;

        massTubes = tubeFrac*Mass_550C;
        massTubesNew = massTubes*((Stress_allow_550C + 0.6*ORIGINAL_P2_PSI)/(Stress_allow_T + 0.6*p2_psi))*(p2/ORIGINAL_P2)*(rhoColdDesign/rhoCold)*m_dotNew/m_dotOriginal;
        
        massShell = Mass_550C - massTubes;
        massShellNew = massShell*((Stress_allow_550C + 0.6*ORIGINAL_P5_PSI)/(Stress_allow_T + 0.6*p5_psi))*(p5/ORIGINAL_P5)*(rhoColdDesign/rhoCold)*m_dotNew/m_dotOriginal;
        
        mass = massShellNew + massTubesNew;
        
    elseif Material == 'SF'
        % stainless steel far term
                % maximum allowable stress corresponding with Temp array [PSI]
        Stress_allow = [18300, 16600, 15200, 14600, 14000, 6100, 2300, 1400];
        
        % baseline values 550
        Slope_550C = 0.000908182;
        Intercept_550C = 2.177272727;
        Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
        
        % get baseline masses
        Mass_550C = Slope_550C*UA + Intercept_550C;
        
        % get allowable stress at T5
        Stress_allow_T = spline(Temp, Stress_allow, T5);
        
        % separately scaling mass for shell and tubes
        tubeFrac = 0.2225;
        
        massTubes = tubeFrac*Mass_550C;
        massTubesNew = massTubes*((Stress_allow_550C + 0.6*ORIGINAL_P2_PSI)/(Stress_allow_T + 0.6*p2_psi))*(p2/ORIGINAL_P2)*(rhoColdDesign/rhoCold)*m_dotNew/m_dotOriginal;
        
        massShell = Mass_550C - massTubes;
        massShellNew = massShell*((Stress_allow_550C + 0.6*ORIGINAL_P5_PSI)/(Stress_allow_T + 0.6*p5_psi))*(p5/ORIGINAL_P5)*(rhoColdDesign/rhoCold)*m_dotNew/m_dotOriginal;
        
        mass = massShellNew + massTubesNew;
        
    elseif Material == 'IN'
        Stress_allow = [42600, 40300, 40000, 40000, 40000, 33100, 10700, 3200];
        
        % baseline values 550
        Slope_550C = 0.00027;
        Intercept_550C = 0.94;
        Stress_allow_550C = spline(Temp, Stress_allow, 550+273.15);
        
        % get baseline masses
        Mass_550C = Slope_550C*UA + Intercept_550C;
        
        % get allowable stress at T5
        Stress_allow_T = spline(Temp, Stress_allow, T5);
        
        % separately scaling mass for shell and tubes
        tubeFrac = 0.5436;
        
        massTubes = tubeFrac*Mass_550C;
        massTubesNew = massTubes*((Stress_allow_550C + 0.6*ORIGINAL_P2_PSI)/(Stress_allow_T + 0.6*p2_psi))*(p2/ORIGINAL_P2)*(rhoColdDesign/rhoCold)*m_dotNew/m_dotOriginal;
        
        massShell = Mass_550C - massTubes;
        massShellNew = massShell*((Stress_allow_550C + 0.6*ORIGINAL_P5_PSI)/(Stress_allow_T + 0.6*p5_psi))*(p5/ORIGINAL_P5)*(rhoColdDesign/rhoCold)*m_dotNew/m_dotOriginal;
        
        mass = massShellNew + massTubesNew;
    end
    
    
end

