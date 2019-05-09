function [ err,d_s,n_s ] = psiDiameterError( d_s_guess,psi )
% calculates error between guessed specific diameter and actual specific
% diameter for a given head coefficient

% Inputs:
% d_s: value for specific diameter
% psi: compressor head coefficient

% outputs:
% err: error value between guessed d_s and resulting d_s for psi value
% d_s: specific diameter
% n_s: specific speed


% equation relating n_s, d_s, and psi
n_s = 2/(d_s_guess*psi^(1/2));

logns = log10(n_s);

if logns > 1.4
    middle = 0.076445106688;
elseif logns < -0.79
    middle = -0.643301783584803*logns+0.706787306595485;
else
    middle = 0.488977-0.426379*logns+0.638746*logns^2-0.637014*logns^3-...
        0.249812*logns^4+0.580012*logns^5-0.196472*logns^6;
end

d_s = 10^middle;

err = d_s_guess - d_s;

end

