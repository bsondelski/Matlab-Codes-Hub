function [ A_panel_min,A_panel_max,A_panel_guess ] = PanelBoundFind(desiredPower,p1,T4,PR_c,T_amb,fluid,mode,NucFuel,RecupMatl)

% Inputs:
% desiredpower: specified power for the system
% p1: flow pressure at inlet of the compressor [kPa]
% T4: Temp at turbine inlet [K]
% PR_c: pressure ratio of the compressor
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% NucFuel: 'UO2' for uranium oxide (near term), 'UW' for uranium tunsten
% (exotic)
% RecupMatl: 'IN' for Inconel, 'SS' for stainless steel, 
%   for recuperator far term exploration, use 'U#' -
%   uninsulated, # of units, 'I#' -insulated, # of units
%   (all units are Inconel for these cases)

% guesses may need to change if decide on a new power level
A_panel_min = 49;
A_panel_max = 100;
steps = 8;


stop = 0;
loopcount = 1;

while stop == 0
    A_panel_testvals = linspace(A_panel_min,A_panel_max,steps);
    % preallocate space
    minMass = zeros(1,steps);
    
    parfor i = 1:length(A_panel_testvals)
%         try
[minMass(i),~,~,~,~,~,~] = minRadRecMass( A_panel_testvals(i),desiredPower,p1,T4,PR_c,T_amb,fluid,mode,1,2,NucFuel,RecupMatl );
%         catch
%             minMass(i) = NaN;
%         end
%         if i > 1 && minMass(i) > minMass(i-1)
%             % if mass is getting larger with larger Apanel, the solution has
%             % already been passed -no need to calculate the other values 
%             minMass(i+1:end) = [];
%             break
%         end
%         filename='C:\Users\sondelski\OneDrive - UW-Madison\nuclear project\Matlab Codes\Studies\minmassexcel';
%         A = [A_panel_testvals; minMass];
%         xlswrite(filename,A)
    end
    
    if isnan(minMass)
        % no cycles worked
        fprintf(2, 'PanelBoundFind: all panel test values returned an error change search range and rerun \n');
        A_panel_min = NaN;
        A_panel_max = NaN;
        A_panel_guess = NaN;
        break
    end
    
    [~,inde] = min(minMass);
    
    if inde == 1
        % create search range that contains smaller panels
        A_panel_min = A_panel_min*0.75;
        A_panel_max = A_panel_testvals(inde+1);
        
    elseif inde == steps
        % create search range that contains smaller panels
        A_panel_max = A_panel_max*1.5;
        A_panel_min = A_panel_testvals(inde-1);
        
    else
        if isnan(minMass(inde-1)) || isnan(minMass(inde+1))
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
    
    % check if stuck in the loop
    if loopcount > 10 && stop == 0
        fprintf(2, 'PanelBoundFind: unable to find boundaries \n \n');
        A_panel_min = NaN;
        A_panel_max = NaN;
        A_panel_guess = NaN;
        break
    end
    
    loopcount = loopcount + 1;
    
end


end

