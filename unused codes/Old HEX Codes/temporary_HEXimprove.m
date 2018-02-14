tic

T_H_in=500;
T_C_in=300;
p_H=2000;
p_C=9000;
m_dot_H=1.5;
m_dot_C=0.155;
fluid_C='CO2';
fluid_H='CO2';
UA=120;
N=10;
mode=2;


%set initial max and min temp range
deltaMaxTH=0.001*(T_H_in-T_C_in);

Tmax=T_H_in-deltaMaxTH;
Tmin=T_C_in;

%set interval for foor loop with 10 increments in temp range

stop=0;                     %set stop value to run while loop

while stop==0
    Q=(Tmax-Tmin)/10;
    TH=Tmin:Q:Tmax;         %create an array for temps to check
    err=zeros(1, length(TH));   %preallocate space

    %generate a
    for i=1:length(TH)
        err(i)=errorGen(TH(i),T_H_in,T_C_in,p_H,p_C,m_dot_H,m_dot_C,UA,fluid_C,fluid_H,mode,N);
    end
    [M,I]=min(abs(err));
    
    %signs of right and left of min
    Asign=sign(err(I-1));
    Bsign=sign(err(I));
    Csign=sign(err(I+1));
    
    %Temp values for min and right and left of min
    A=TH(I-1);
    B=TH(I);
    C=TH(I+1);
    
    
    if -Bsign==Asign        %if sign change between A and B
        Tmin=A;
        Tmax=B;
        stop=1;
    elseif -Bsign==Csign    %if sign change between B and C
        Tmin=B;
        Tmax=C;
        stop=1;
    elseif isnan(Asign) && isnan(Csign)
        TminA=Tmin;
        Tmax=C;
        stop=0;
    elseif isnan(Asign)
        Tmin=A;
        Tmax=B;
        stop=0;
    elseif isnan(Csign)
        Tmin=B;
        Tmax=C;
        stop=0;
    end
    stop
    err
    TH
end


    
    
plot(TH,err)

% err
toc