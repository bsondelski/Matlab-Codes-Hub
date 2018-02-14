function [ Tmin, Tmax ] = boundFindBackwards( T_C_in,T_H_out,UpperTBound,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N )
%Description: Finds a temperature range for the hot side outlet temp that
%will can be used with fzero
%Inputs:
%T_H_in=inlet temperature at hot side of HEX [K]
%T_C_in=inlet temperature at cold side of HEX [K]
%p_H=hot side pressure [kPa]
%p_C=cold side pressure [kPa]
%m_dot_H=hot side mass flow rate [kg/s]
%m_dot_C=cold side mass flow rate [kg/s]
%UA=conductance [W/K]
%fluidC=cold side fluid
%fluidH=hot side fluid
%Mode=1(constant property model),2(use of FIT),3(use of REFPROP)
%N=number of sub heat exchangers
%Outputs:
%Tmin=minimum outlet temperature at hot side of HEX [K]
%Tmax=maximum outlet temperature at cold side of HEX [K]

%set initial max and min temp range
Tmax=UpperTBound;     %max outlet hot temp as 0.1% of temp difference
Tmin=T_H_out;                           %min outlet hot temp as cold temp
stop=0;                     %set stop value to run while loop

%while loop runs with temp range getting smaller until realistic answer is found
while stop==0
    %     for j=1:2
    %set interval for for loop with 10 increments in temp range
    Q=(Tmax-Tmin)/10;
    TH=Tmin:Q:Tmax;         %create an array for temps to check
    err=zeros(1, length(TH));   %preallocate space
    
    %generate an array of error values given the temperature increments
    for i=1:length(TH)
        err(i)=errorGenBackwards(TH(i),T_H_out,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
    end
    err
    [~,I]=min(abs(err));        %find the value in the error array with the smallest magnitude
    
    B=TH(I);
    %signs to right and left of the smallest magnitute error
    Bsign=sign(err(I));
    if I==1
        C=TH(I+1);
        %signs to right and left of the smallest magnitute error
        Csign=sign(err(I+1));
        if -Bsign==Csign        %if sign change between B and C
            %set B and C as Tmin and Tmax and end loop
            Tmin=B;
            Tmax=C;
            stop=1;
        elseif isnan(Csign)     %if answer is between B and C but C is NaN
            %set B and C as Tmin and Tmax and restart loop
            Tmin=B;
            Tmax=C;
            stop=0;
        elseif Bsign==Csign        %if no sign change between B and C
            %set A and B as Tmin and Tmax and end loop
            fprintf(2, 'This HEX is not supported \n');
            Tmin=NaN;
            Tmax=NaN;
            stop=1;
        end
    elseif I==length(err)       % if minimum value is at end of array, C value will not exist
        A=TH(I-1);
        Asign=sign(err(I-1));
        if -Bsign==Asign        %if sign change between A and B
            %set A and B as Tmin and Tmax and end loop
            Tmin=A;
            Tmax=B;
            stop=1;
        elseif isnan(Asign)     %if answer is between A and B but A is NaN
            %set A and B as Tmin and Tmax and restart loop
            Tmin=A;
            Tmax=B;
            stop=0;
        elseif Bsign==Asign        %if sign change between A and B
            %set A and B as Tmin and Tmax and end loop
            fprintf(2, 'This HEX is not supported \n');
            Tmin=NaN;
            Tmax=NaN;
            stop=1;
        end
    else
        A=TH(I-1);
        Asign=sign(err(I-1));
        C=TH(I+1);
        %signs to right and left of the smallest magnitute error
        Csign=sign(err(I+1));
        
        if -Bsign==Asign        %if sign change between A and B
            %set A and B as Tmin and Tmax and end loop
            Tmin=A;
            Tmax=B;
            stop=1;
        elseif -Bsign==Csign    %if sign change between B and C
            %set B and C as Tmin and Tmax and end loop
            Tmin=B;
            Tmax=C;
            stop=1;
        elseif isnan(Asign) && isnan(Csign) %if both A and C return NaN
            %set A and C as Tmin and Tmax and restart loop
            Tmin=A;
            Tmax=C;
            stop=0;
        elseif isnan(Asign)     %if answer is between A and B but A is NaN
            %set A and B as Tmin and Tmax and restart loop
            Tmin=A;
            Tmax=B;
            stop=0;
        elseif isnan(Csign)     %if answer is between B and C but C is NaN
            %set B and C as Tmin and Tmax and restart loop
            Tmin=B;
            Tmax=C;
            stop=0;
        end
    end
end
end

