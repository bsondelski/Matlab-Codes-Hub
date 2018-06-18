function [ A_panel_min,A_panel_max,A_panel_guess ] = PanelBoundFind(desiredPower,p1,T4,PR_c,T_amb,fluid,mode)

% Inputs:
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)

% guesses may need to change if decide on a new power level
A_panel_min = 40;
A_panel_max = 54;
steps = 4;

% preallocate space
minMass = zeros(1,steps);
stop = 0;

while stop == 0
    A_panel_testvals = linspace(A_panel_min,A_panel_max,steps);
    
    for i = 1:length(A_panel_testvals)
        try
            [minMass(i),~,~,~,~,~,~] = minRadRecMass( A_panel_testvals(i),desiredPower,p1,T4,PR_c,T_amb,fluid,mode,1,2 );
        catch
            minMass(i) = NaN;
        end
        filename='C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\minmassexcel';
        A = [A_panel_testvals; minMass];
        xlswrite(filename,A)
    end
    [~,inde] = min(minMass);
    
    if inde == 1
        % create search range that contains smaller panels
        A_panel_min = A_panel_min*0.5;
        A_panel_max = A_panel_testvals(inde+1);
        
    elseif inde == steps
        % create search range that contains smaller panels
        A_panel_max = A_panel_max*1.5;
        A_panel_min = A_panel_testvals(inde-1);
        
    else
        if isnan(A_panel_testvals(inde-1)) || isnan(A_panel_testvals(inde+1))
            % modify search range if value to either side is not a valid
            % entry
            A_panel_min = A_panel_testvals(inde-1);
            A_panel_max = A_panel_testvals(inde+1);
        else
            % if values to either side of minimum value are valid entries,
            % set those values as search range and end while loop
            A_panel_min = A_panel_testvals(inde-1);
            A_panel_max = A_panel_testvals(inde+1);
            A_panel_guess = A_panel_testvals(inde);
            stop = 1;
        end
    end
    
    
    
end


end

