function [h_outmin,h_outmax] = RadiatorBoundFind(m_dot,A_panel,T_amb,fluid,mode,eps,T12_pp,sigma,h_in,p_out)
%Radiator model
%inputs:
%m_dot: mass flow through radiator
%A_panel: area of the radiator panel that is transferring heat
%T_amb: temperature of surrounding space
%fluid: fluid in HEX
%mode: 1(constant property model),2(use of FIT),3(use of REFPROP)
%eps: emissivity
%T12_pp: change in temp at the pinch point
%sigma: Stefan-Boltzmann constant
%h_in: inlet enthalpy to radiator
%p_out: pressure at radiator outlet
%output:
%h_outmin & h_outmax: the range where h_out is between

stop=0;             %set stop value to run while loop
h_outmax=h_in;      %set max outlet enthalpy
h_outmin=0;         %set min outlet enthalpy

while stop==0
    Q=(h_outmax-h_outmin)/10;   %set interval for for loop with 10 increments in enthalpy range
    h_outarray=h_outmin:Q:h_outmax;         %create array for enthalpy values to check
    h_error=zeros(1,length(h_outarray));    %preallocate space

    %generate an array of error values given the enthalpy increments
    for i=1:length(h_outarray)
        try
            h_error(i)=radiatorError(h_outarray(i),h_in,m_dot,eps,T12_pp,p_out,sigma,A_panel,T_amb,fluid,mode);
        catch
            %errors typically occur if T_C_in>=T_H_in
            h_error(i)=NaN;
        end
    end
    [~,I]=min(abs(h_error));        %find the value in the error array with the smallest magnitude
    
    %Temp value for smallest value in error array
    B=h_outarray(I);
    %sign of the smallest magnitute error
    Bsign=sign(h_error(I));
    if I==1                     % if minimum value is at start of array, A value will not exist
        %Temp value to the right of the one with the smallest error value
        C=h_outarray(I+1);
        %sign of error value to right of the smallest magnitute error
        Csign=sign(h_error(I+1));
        if -Bsign==Csign        %if sign change between B and C
            %set B and C as Tmin and Tmax and end loop
            h_outmin=B;
            h_outmax=C;
            stop=1;
        elseif isnan(Csign)     %if answer is between B and C but C is NaN
            %set B and C as Tmin and Tmax and restart loop
            h_outmin=B;
            h_outmax=C;
            stop=0;
        elseif Bsign==Csign        %if no sign change between B and C
            %set A and B as Tmin and Tmax and end loop
            fprintf(2, 'This cycle is not supported \n');
            h_outmin=NaN;
            h_outmax=NaN;
            stop=1;
        end
    elseif I==length(h_error)       % if minimum value is at end of array, C value will not exist
        %Temp value to the left of the one with the smallest error value
        A=h_outarray(I-1);
        %sign of error value to left of the smallest magnitute error
        Asign=sign(h_error(I-1));
        if -Bsign==Asign        %if sign change between A and B
            %set A and B as Tmin and Tmax and end loop
            h_outmin=A;
            h_outmax=B;
            stop=1;
        elseif isnan(Asign)     %if answer is between A and B but A is NaN
            %set A and B as Tmin and Tmax and restart loop
            h_outmin=A;
            h_outmax=B;
            stop=0;
        elseif Bsign==Asign        %if sign change between A and B
            %set A and B as Tmin and Tmax and end loop
            fprintf(2, 'This cycle is not supported \n');
            h_outmin=NaN;
            h_outmax=NaN;
            stop=1;
        end
    else
        %Temp values to the right and left of the one with the smallest error value
        A=h_outarray(I-1);
        C=h_outarray(I+1);
        %signs to right and left of the smallest magnitute error
        Asign=sign(h_error(I-1));
        Csign=sign(h_error(I+1));
        if -Bsign==Asign        %if sign change between A and B
            %set A and B as Tmin and Tmax and end loop
            h_outmin=A;
            h_outmax=B;
            stop=1;
        elseif -Bsign==Csign    %if sign change between B and C
            %set B and C as Tmin and Tmax and end loop
            h_outmin=B;
            h_outmax=C;
            stop=1;
        elseif isnan(Asign) && isnan(Csign) %if both A and C return NaN
            %set A and C as Tmin and Tmax and restart loop
            h_outmin=A;
            h_outmax=C;
            stop=0;
        elseif isnan(Asign)     %if answer is between A and B but A is NaN
            %set A and B as Tmin and Tmax and restart loop
            h_outmin=A;
            h_outmax=B;
            stop=0;
        elseif isnan(Csign)     %if answer is between B and C but C is NaN
            %set B and C as Tmin and Tmax and restart loop
            h_outmin=B;
            h_outmax=C;
            stop=0;
        end
    end
end
end

