function [ ApanelMin ] = minApanelFind(desiredPower,p1,T4,PR_c,T_amb,fluid,mode)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


% find minimum A_panel that will give 40 kW output power with a very large
% recuperator (90 kW/K)


%%%%%%%%%%%%%%%%%%%%%%%%%%%% bound finding %%%%%%%%%%%%%%%%%%%%%%%%%%%

% mixtures
if strcmp(fluid,'WATER')
    UA = 12000;
    A_panel_min = 20; 
    A_panel_max = 40;
    stepsize = 2;
    stop = 0;
    loopcount = 1;
elseif mode == 2
    UA = 50000;
    A_panel_min = 40;
    A_panel_max = 100;
    stepsize = 10;
    stop = 0;
    loopcount = 1;
else
    UA = 35000; 
    A_panel_min = 20; 
    A_panel_max = 40;
    stepsize = 2;
    stop = 0;
    loopcount = 1;
end


while stop == 0 % && stepsize > 0.25
    A_panel = A_panel_min:stepsize:A_panel_max;
    powerDifference = zeros(1,length(A_panel));
    for i=1:length(A_panel)
        [ powerDifference(i) ] = minimumApanelError( A_panel(i),UA,desiredPower,p1,T4,PR_c,...
            T_amb,fluid,mode,[]); 
        
        if i > 1 && powerDifference(i) > 0
            % if mass is getting larger with larger Apanel, the solution has
            % already been passed -no need to calculate the other values
            powerDifference(i+1:end) = [];
            break
        end
    end
    [~,inde] = min(abs(powerDifference));
    
    if inde == 1
        % check if solution is between 1 and 2
        if powerDifference(inde) < 0 && powerDifference(inde+1) > 0
            A_panel_min = A_panel(inde);
            A_panel_max = A_panel(inde + 1);
%             stepsize = stepsize/2;
            break
        elseif powerDifference(inde) > 0
            A_panel_min = A_panel_min*0.95;
            A_panel_max = A_panel(inde+1);
        end
        
    elseif inde == length(powerDifference)
        % check if solution is between last and second to last
        if powerDifference(inde) > 0 && powerDifference(inde-1) < 0
            A_panel_min = A_panel(inde - 1);
            A_panel_max = A_panel(inde);
%             stepsize = stepsize/2;
break
        elseif powerDifference(inde) < 0
            A_panel_max = A_panel_max*1.5;
            A_panel_min = A_panel(inde-1);
        end
        
    elseif powerDifference(inde) < 0 && powerDifference(inde+1) > 0
        A_panel_min = A_panel(inde);
        A_panel_max = A_panel(inde + 1);
%         stepsize = stepsize/2;
break
    elseif powerDifference(inde) > 0 && powerDifference(inde-1) < 0
        A_panel_min = A_panel(inde - 1);
        A_panel_max = A_panel(inde);
%         stepsize = stepsize/2;
break
    elseif isnan(powerDifference(inde-1)) || isnan(powerDifference(inde+1))
        % modify search range if value to either side is not a valid
        % entry
        A_panel_min = A_panel(inde-1);
        A_panel_max = A_panel(inde+1);
    end
    
    % check if stuck in the loop
    if loopcount > 15 && stop == 0
        fprintf(2, 'PanelBoundFind: unable to find boundaries \n \n');
        A_panel_min = NaN;
        A_panel_max = NaN;
        break
    end
    
    loopcount = loopcount + 1;
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% bound finding %%%%%%%%%%%%%%%%%%%%%%%%%%%

% exact option
options = optimset('TolX', 1e-5);
ApanelMin = fzero(@minimumApanelError,[A_panel_min,A_panel_max],options,UA,...
    desiredPower,p1,T4,PR_c,T_amb,fluid,mode,[] );

ApanelMin = ApanelMin + 1e-4;

% approximate option
% ApanelMin = A_panel_max;






end

