function [ efficiency, parameter ] = compressorEfficiency( n_s, d_s )
% find compressor efficiency given specific speed and specific diameter
%
% inputs:
% n_s: specific speed [unitless(radians)]
% d_s: specific diameter [unitless]
%
% outputs:
% efficiency: gives efficiency of compressor based on Balje curves
% parameter: gives d_s if n_s input and it is desired to stay on peak of
% curve

% take log base 10 of input specific speed and specific diameter
logns = log10(n_s);
logds = log10(d_s);



% use indexing and logicals to find max efficiency at given specific speed
% find logical arrays with ones for each piece of the piecewise function
inds1 = logns > 1.4;
inds2 = logns < -0.68;
inds3 = logns < 1.4 & logns >-0.68 | logns == 1.4 | logns == -0.68;

% array of efficiencies for each part of piecewise function
eff_max1 = zeros(1,length(logns));
eff_max1(inds1) = 1.745*0.4144.^logns(inds1);

eff_max2 = zeros(1,length(logns));
eff_max2(inds2) = 1.289*3.265.^logns(inds2);

eff_max3 = zeros(1,length(logns));
eff_max3(inds3) = 0.870908+0.014574*logns(inds3)-0.381744*logns(inds3).^2+0.617609*logns(inds3).^3-...
        0.113082*logns(inds3).^4-0.564492*logns(inds3).^5+0.284332*logns(inds3).^6;

eff_max = eff_max1 + eff_max2 + eff_max3;



% use indexing and logicals to find curve's center at given specific speed
% logical arrays with ones for each piece of the piecewise function
inds5 = logns < -0.79;
inds6 = logns < 1.4 & logns > -0.79 | logns == 1.4 |  logns == 0.79;

% array of center values for each part of piecewise function
middle4 = inds1*0.076445106688; % it is constant so mult by 1 in locations where not zero

middle5 = zeros(1,length(logns));
middle5(inds5) = -0.643301783584803.*logns(inds5)+0.706787306595485;

middle6 = zeros(1,length(logns));
middle6(inds6) = 0.488977-0.426379*logns(inds6)+0.638746*logns(inds6).^2-0.637014*logns(inds6).^3-...
        0.249812*logns(inds6).^4+0.580012*logns(inds6).^5-0.196472*logns(inds6).^6;

middle = middle4 + middle5 + middle6;
    



eff_balj_max = 0.871051704626864;   % max efficiency from balje curves
eff_new_max = 0.871051704626864;    % max efficiency of newer designs

if d_s == inf
    % on design point
    efficiency = eff_max/eff_balj_max*eff_new_max; % find efficiency
    parameter = 10.^middle;          % d_s is output parameter
else
    % off design point
    % use indexing and logicals to find term corresponding to Gaussian curve 
    % width at given specific speed
    % logical arrays with ones for each piece of the piecewise function
    inds7 = logns > 1.2;
    inds8 = logns < -0.85;
    inds9 = logns < 1.2 & logns > -0.85 | logns == 1.2 | logns == -0.85;
    
    % array of stdev values for each part of piecewise function
    stdeviation7 = 0.330576742720000*inds7; % it is constant so mult by 1 in locations where not zero
    
    stdeviation8 = 0.134142426375164*inds8;
    
    stdeviation9 = zeros(1,length(logns));
    stdeviation9(inds9) = 0.251641+0.317814*logns(inds9)+0.1485*logns(inds9).^2-...
            0.562636*logns(inds9).^3-0.130096*logns(inds9).^4+0.428757*logns(inds9).^5-...
            0.114255*logns(inds9).^6;
    
    stdeviation = stdeviation7 + stdeviation8 + stdeviation9;
    
    
    % using parameters found and log of given specific diameter, find
    % efficiency.
    efficiency = eff_max.*exp(-(logds-middle).^2./stdeviation.^2);
    % find new proportional efficiency
    efficiency = efficiency/eff_balj_max*eff_new_max;
    parameter = inf;                % no output parameter
end
% end
end

