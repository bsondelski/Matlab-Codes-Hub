function [Tmin,Tmax] = BraytonCycleBoundFind(m_dot,p1,T4,TLowerBound,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5)
% find bounds for BraytonCycle fzero function

% Inputs:
% m_dot: the mass flow in the cycle [kg/s]
% p1: flow pressure at inlet of the compressor [kPa] 
% T4: Temp at turbine inlet [K]
% TLowerBound: lowest possible temperature value - according to fluid props
% UA: conductance of recuperator [W/K]
% A_panel: area of radiator panel [m3]
% T_amb: ambient temp for radiator [K]
% fluid: working fluid for the system
% Mode: 1(constant property model), 2(use of FIT),3(use of REFPROP), 
%       or property tables for interpolation
% all cycle pressures

% Outputs:
% Tmin & Tmax: a value where the error function is zero lies between these
%              values

% set initial max and min temp range
Tmax = T4;                % T1 must be lower than T4
Tmin = TLowerBound;       % min T1 is lowest programmed into FIT or REFPROP
stop = 0;                 % set stop value to run while loop
tempstep = 10;
loopcount = 1;
    
% while loop runs with temp range getting smaller until realistic answer is found
while stop == 0
    % set interval for for loop with 10 increments in temp range
    Q = (Tmax-Tmin)/tempstep;
    T = Tmin:Q:Tmax;
%     T = linspace(Tmin,Tmax,11);              % create an array for temps to check
    
    % generate an array of error values given the temperature increments
    err = zeros(1,length(T));                   % preallocate space
    for i = 1:length(T)
        err(i) = simpleCycleError(T(i),m_dot,p1,T4,UA,A_panel,T_amb,fluid,mode,p2,p3,p4,p6,p5,TLowerBound);
        if i > 1 && err(i) > 0
            % if error is going positive, the solution has
            % already been passed because too low temps have negative 
            % error and too high temps have positive error -no need to 
            % calculate the other values 
            err(i+1:end) = [];
            break
        end
    end

    [~,I] = min(abs(err));    % find the value in the error array with the smallest magnitude
    
    % Temp value for smallest value in error array
    B = T(I);
    % sign of the smallest magnitute error
    Bsign = sign(err(I));
    if I == 1
        % temp value to right of the one with the smallest value error
        C = T(I+1);
        % sign to right of the smallest magnitute error
        Csign = sign(err(I+1));
        if -Bsign == Csign        % if sign change between B and C
            % set B and C as Tmin and Tmax and end loop
            Tmin = B;
            Tmax = C;
            stop = 1;
        elseif isnan(Csign)     % if answer is between B and C but C is NaN
            % set B and C as Tmin and Tmax and restart loop
            Tmin = B;
            Tmax = C;
            stop = 0;
        elseif Bsign == Csign        % if no sign change between B and C
            if loopcount > 10
                % if the cycle has been run over 10 times, break the loop,
                % Tmin is not low enough 
                fprintf(2, 'BraytonCycle: cycle temperature is lower than Tmin \n');
            Tmin = NaN;
            Tmax = NaN;
            stop = 1;
            else
            % increase number of temperature values to check so there is a
            % smaller increment between them and repeat the loop
            tempstep = tempstep + 5;
            stop = 0;
            end
        end
    elseif I == length(err)       % if minimum value is at end of array, C value will not exist
        % temp value to left of the one with the smallest value error
        A = T(I-1);
        % sign to left of the smallest magnitute error
        Asign = sign(err(I-1));
        if -Bsign == Asign        % if sign change between A and B
            % set A and B as Tmin and Tmax and end loop
            Tmin = A;
            Tmax = B;
            stop = 1;
        elseif isnan(Asign)     % if answer is between A and B but A is NaN
            % set A and B as Tmin and Tmax and restart loop
            Tmin = A;
            Tmax = B;
            stop = 0;
        elseif Bsign == Asign        % if no sign change between A and B
            % increase number of temperature values to check so there is a
            % smaller increment between them and repeat the loop
            tempstep = tempstep + 5;
            stop = 0;
        end
    else
        % temp values to right and left of the one with the smallest value error
        A = T(I-1);
        C = T(I+1);
        % signs to right and left of the smallest magnitute error
        Asign = sign(err(I-1));
        Csign = sign(err(I+1));
        if -Bsign == Asign        % if sign change between A and B
            % set A and B as Tmin and Tmax and end loop
            Tmin = A;
            Tmax = B;
            stop = 1;
        elseif -Bsign == Csign    % if sign change between B and C
            % set B and C as Tmin and Tmax and end loop
            Tmin = B;
            Tmax = C;
            stop = 1;
        elseif isnan(Asign) && isnan(Csign) % if both A and C return NaN
            % set A and C as Tmin and Tmax and restart loop
            Tmin = A;
            Tmax = C;
            stop = 0;
        elseif isnan(Asign)     % if answer is between A and B but A is NaN
            % set A and B as Tmin and Tmax and restart loop
            Tmin = A;
            Tmax = B;
            stop = 0;
        elseif isnan(Csign)     % if answer is between B and C but C is NaN
            % set B and C as Tmin and Tmax and restart loop
            Tmin = B;
            Tmax = C;
            stop = 0;
        elseif Asign == Bsign && Bsign == Csign
            % increase number of temperature values to check so there is a
            % smaller increment between them and repeat the loop
            tempstep = tempstep + 5;
            stop = 0;
        end
    end
    
    % check if stuck in the loop
    if loopcount > 25 && stop ==0 || isnan(err(I))
        fprintf(2, 'BraytonCycleBoundFind unable to find boundaries \n \n');
        Tmin = NaN;
        Tmax = NaN;
        break
    end
    
    loopcount = loopcount + 1;
end
end

