function [ minimumMass,Apanel_min ] = minMass( p1,T4,PR_c,T_amb,fluid,mode,desiredPower,A_panel )


for j=1:2
    
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
    
    recup_mass = 0.0131*UA;
    
    Rad_mass = 5.8684*A_panel;
    clear total_mass
    total_mass = Rad_mass+recup_mass;
    
    [minimumMass,inde]=min(total_mass);
    
    if j == 1
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



