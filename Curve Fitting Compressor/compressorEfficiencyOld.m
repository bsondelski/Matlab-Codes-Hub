function [ efficiency ] = compressorEfficiencyOld( n_s,d_s )
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
if logns>1.3
    eff_max=1.979*0.3773^logns;
elseif logns<-0.8
    eff_max=1.462*3.516^logns;
else
    eff_max=0.868229+0.0215138*logns-0.286446*logns^2+0.385698*logns^3-0.15606*logns^4-0.268875*logns^5+0.153681*logns^6;
end


%use piecewise function to find curve's center at given specific speed
if logns>1.35
    middle=0.099669666;
elseif logns<-0.8
    middle=-0.8563715456*logns+0.54328550432;
else
    middle=0.524877-0.408128*logns+0.472169*logns^2-0.574357*logns^3-0.0481688*logns^4+0.451904*logns^5-0.19625*logns^6;
end


%use piecewise function to find term corresponding to Gaussian curve width at given specific speed
if logns>1
    stdeviation=0.3799;
elseif logns<-0.09
    stdeviation=0.23570172;
else
    stdeviation=0.2592+0.2495*logns-0.1288*logns^2;
end

%using parameters found and log of given specific diameter, find efficiency
efficiency=eff_max*exp(-(logds-middle)^2/stdeviation^2);

end

