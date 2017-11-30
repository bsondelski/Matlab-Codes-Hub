function [Tmin,Tmax] = BraytonCycleBoundFind2(m_dot,p1,T4,TLowerBound,PR,UA,A_panel,T_amb,fluid,mode)
%find bounds for BraytonCycle fzero function 

T=TLowerBound:T4;

err=zeros(1,length(T));

for i=1:length(T)
    try
        err(i) = simpleCycleError(T(i),m_dot,p1,T4,PR,UA,A_panel,T_amb,fluid,mode);
    catch
        
    end
end

[errmin,Tminloc]=min(err)
[errmax,Tmaxloc]=max(err)

Tmin=T(Tminloc);
Tmax=T(Tmaxloc);
