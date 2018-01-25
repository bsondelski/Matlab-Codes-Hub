function [ minimumMass,Apanel_min ] = minMass( p1,T4,PR_c,T_amb,fluid,...
    mode,desiredPower,A_panel )
% finding minimum mass for a given set of cycle parameters

% Inputs:
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor 
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% desiredPower: desired system power [w]
% A_panel: area of radiator panel [m2]

% Outputs:
% minimumMass: lowest possible mass for a given cycle [kg]
% Apanel_min: A_panel corresponding to the minimum mass [m2]

for j = 1:2
    parfor i = 1:length(A_panel)
        try
            [ UA(i),m_dot(i) ] = maxPowerMatch(desiredPower,p1,T4,PR_c,A_panel(i),T_amb,fluid,mode)
        catch
            fprintf('A_panel = ')
            fprintf(num2str(A_panel(i)))
            fprintf(' is not supported for p1 = ')
            fprintf(num2str(p1))
            fprintf(', T4 = ')
            fprintf(num2str(T4))
            fprintf(', PR_c =')
            disp(PR_c)
        end
    end
    clear recup_mass
    clear Rad_mass
    recup_mass = 0.0131*UA;
    
    Rad_mass = 5.8684*A_panel;
    clear total_mass
    total_mass = Rad_mass+recup_mass;
    
    [minimumMass,inde]=min(total_mass);
    
    if j == 1
        clear UA
        if inde == 1
            A_pan_min=A_panel(inde);
            A_pan_max=A_panel(inde+1);
        elseif inde == length(A_panel)
            A_pan_min=A_panel(inde-1);
            A_pan_max=A_panel(inde);
        else
            
            A_pan_min=A_panel(inde-1);
            A_pan_max=A_panel(inde+1);           
        end
        A_panel=linspace(A_pan_min,A_pan_max,10);
    else
    end
    Apanel_min=A_panel(inde);
end

end



