function [ efficiency, d_s ] = turbineEfficiency( n_s, d_s )
% find turbine efficiency given specific speed and specific diameter
%
% inputs:
% n_s: specific speed [unitless(radians)]
% d_s: specific diameter [unitless]
%
% outputs:
% efficiency: gives efficiency of turbine based on Balje curves
% d_s: specific diameter resulting from input n_s and staying on peak of
% curve

% take log base 10 of input specific speed and specific diameter
logns = log10(n_s);
logds = log10(d_s);

% use piecewise function to find max efficiency at given specific speed
if logns > 0.06
    eff_max = 0.6865*0.1497^logns;
elseif logns < -0.8392
    eff_max = 1.436*2.349^logns;
else
    eff_max = 0.695455-1.47518*logns+0.0529263*logns^2+21.3801*logns^3+...
        56.9767*logns^4+58.1086*logns^5+20.8809*logns^6;
end

% use piecewise function to find curve's center at given specific speed
if logns > 0.065
    middle = -0.702209532478022*logns+0.371756558699681;
elseif logns < -1
    middle = -0.625631000000001*logns+0.475997999999999;
else
    middle = 0.369142-0.629575*logns-0.381976*logns^2-1.73486*logns^3-...
        0.991895*logns^4+1.07147*logns^5+0.813393*logns^6;
end

eff_balj_max = 0.904586624844687; % max efficiency from balje curves
eff_new_max = 0.904586624844687;  % max efficiency of newer designs

if d_s == inf
    % on design point
    efficiency = eff_max/eff_balj_max*eff_new_max;	% find efficiency
    d_s = 10^middle;
else
    % off design point
    % use piecewise function to find term corresponding to Gaussian curve 
    % width at given specific speed
    if logns > -0.045
        stdeviation = 0.175353691653290;
    elseif logns < -1
        stdeviation = 0.229935999999995;
    else
        stdeviation = 0.165216-0.39868*logns-4.93956*logns^2-...
            26.6755*logns^3-58.8628*logns^4-56.5442*logns^5-...
            19.7513*logns^6;
    end
    
    % using parameters found and log of given specific diameter, 
    % find efficiency
    efficiency = eff_max*exp(-(logds-middle)^2/stdeviation^2);
    % find new proportional efficiency
    efficiency = efficiency/eff_balj_max*eff_new_max;
end
end



