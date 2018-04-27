function [ Tmin, Tmax ] = boundFind( T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N )
% Description: Finds a temperature range for the hot side outlet temp that
% will can be used with fzero

% Inputs:
% T_H_in: inlet temperature at hot side of HEX [K]
% T_C_in: inlet temperature at cold side of HEX [K]
% p_H: hot side pressure [kPa]
% p_C: cold side pressure [kPa]
% m_dot_H: hot side mass flow rate [kg/s]
% m_dot_C: cold side mass flow rate [kg/s]
% UA: conductance [W/K]
% fluidC: cold side fluid
% fluidH: hot side fluid
% Mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
% N: number of sub heat exchangers

% Outputs:
% Tmin: minimum outlet temperature at hot side of HEX [K]
% Tmax: maximum outlet temperature at cold side of HEX [K]

% set initial max and min temp range
Tmax = T_H_in-0.001*(T_H_in-T_C_in);     % max outlet hot temp as 0.1% of temp difference
Tmin = T_C_in;%+0.001*(T_H_in-T_C_in);   % min outlet hot temp as cold temp
stop = 0;                                % set stop value to run while loop

% while loop runs with temp range getting smaller until realistic answer is found
while stop == 0
% for p=1:6
    % set interval for for loop with 10 increments in temp range
    Q = (Tmax-Tmin)/10;
    TH = Tmin:Q:Tmax;         % create an array for temps to check
    err = zeros(1, length(TH));   % preallocate space
    
    % generate an array of error values given the temperature increments
    for i = 1:length(TH)
        err(i) = errorGen(TH(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
    end
    [~,I] = min(abs(err));        % find the value in the error array with the smallest magnitude
    % Temp value for smallest value in error array
    B = TH(I);
    % sign of the smallest magnitute error
    Bsign = sign(err(I));
    
    if I == 1                 % if minimum value is at beginning of array, A value will not exist
        % Temp value left of smallest value in error array
        C = TH(I+1);
        % sign to left of the smallest magnitute error
        Csign = sign(err(I+1));
        if -Bsign == Csign        % if sign change between B and C
            % set B and C as Tmin and Tmax and end loop
            Tmin = B;
            Tmax = C;
            stop = 1;
%             a = 5
        elseif isnan(Csign)     % if answer is between B and C but C is NaN
            % set B and C as Tmin and Tmax and restart loop
%             a = 0
            Tmin = B;
            Tmax = C;
            stop = 0;
        elseif Bsign == Csign        % if no sign change between B and C
            % set A and B as Tmin and Tmax and end loop
            fprintf(2, 'This HEX is not supported \n');
            Tmin = NaN;
            Tmax = NaN;
            stop = 1;
%             a = 6
        end
    elseif I == length(err)       % if minimum value is at end of array, C value will not exist
        % Temp value right of smallest value in error array
        A = TH(I-1);
        % sign to right of the smallest magnitute error
        Asign = sign(err(I-1));
        if -Bsign == Asign        % if sign change between A and B
            % set A and B as Tmin and Tmax and end loop
            Tmin = A;
            Tmax = B;
            stop = 1;
%             a = 7
        elseif isnan(Asign)     % if answer is between A and B but A is NaN
            % set A and B as Tmin and Tmax and restart loop
%             a = 1
            Tmin = A;
            Tmax = B;
            stop = 0;
        elseif Bsign == Asign        % if sign change between A and B
            % set A and B as Tmin and Tmax and end loop
            fprintf(2, 'This HEX is not supported \n');
            Tmin = NaN;
            Tmax = NaN;
            stop = 1;
%             a = 8
        end
    else
        % Temp values right and left of smallest value in error array
        A = TH(I-1);
        C = TH(I+1);
        % signs to right and left of the smallest magnitute error
        Asign = sign(err(I-1));
        Csign = sign(err(I+1));
        if -Bsign == Asign        % if sign change between A and B
            % set A and B as Tmin and Tmax and end loop
            Tmin = A;
            Tmax = B;
            stop = 1;
%             a = 9
        elseif -Bsign == Csign    % if sign change between B and C
            % set B and C as Tmin and Tmax and end loop
            Tmin = B;
            Tmax = C;
            stop = 1;
%             a = 10
        elseif isnan(Asign) && isnan(Csign) % if both A and C return NaN
            % set A and C as Tmin and Tmax and restart loop
%             a = 2
            Tmin = A;
            Tmax = C;
            stop = 0;
        elseif isnan(Asign)     % if answer is between A and B but A is NaN
            % set A and B as Tmin and Tmax and restart loop
%             x = round(A,5);
%             y = round(B,5);
%             if x == y
%                 a = 107
%                 Tmin = NaN;
%                 Tmax = NaN;
%                 stop = 1;
%             else
%                 a = 3
                Tmin = A;
                Tmax = B;
                stop = 0;
%             end
        elseif isnan(Csign)     % if answer is between B and C but C is NaN
            % set B and C as Tmin and Tmax and restart loop
%             a = 4
            Tmin = B;
            Tmax = C;
            stop = 0;
        end
    end
end
end

