function [ efficiency,d_s ] = compressorEfficiency( n_s,d_s )
%find compressor efficiency given specific speed and specific diameter
%
%inputs:
%n_s: specific speed [unitless(radians)]
%d_s: specific diameter [unitless]
%
%outputs:
%efficiency: gives efficiency of compressor based on Balje curves

%take log base 10 of input specific speed and specific diameter
logns=log10(n_s);
logds=log10(d_s);


%use piecewise function to find max efficiency at given specific speed
if logns>1.4
    eff_max=1.745*0.4144^logns;
elseif logns<-0.68
    eff_max=1.289*3.265^logns;
else
    eff_max=0.870908+0.014574*logns-0.381744*logns^2+0.617609*logns^3-0.113082*logns^4-0.564492*logns^5+0.284332*logns^6;
end



%use piecewise function to find curve's center at given specific speed
if logns>1.4
    middle=0.076445106688;
elseif logns<-0.79
    middle=-0.643301783584803*logns+0.706787306595485;
else
    middle=0.488977-0.426379*logns+0.638746*logns^2-0.637014*logns^3-0.249812*logns^4+0.580012*logns^5-0.196472*logns^6;
end

eff_balj_max=0.871051704626864;                     %max efficiency from balje curves
eff_new_max=0.871051704626864;                      %max efficiency according to newer designs

if d_s==inf
    %on design point
    efficiency=eff_max/eff_balj_max*eff_new_max;        %find efficiency proportionally
    d_s=10^middle;
else
    %off design point
    %use piecewise function to find term corresponding to Gaussian curve width at given specific speed
    if logns>1.2
        stdeviation=0.330576742720000;
    elseif logns<-0.85
        stdeviation=0.134142426375164;
    else
        stdeviation=0.251641+0.317814*logns+0.1485*logns^2-0.562636*logns^3-0.130096*logns^4+0.428757*logns^5-0.114255*logns^6;
        
    end
        
    %using parameters found and log of given specific diameter, find efficiency
    efficiency=eff_max*exp(-(logds-middle)^2/stdeviation^2);
    %find new proportional efficiency
    efficiency=efficiency/eff_balj_max*eff_new_max;
end

end

