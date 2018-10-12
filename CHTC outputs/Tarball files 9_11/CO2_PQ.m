% CO2_PQ Help file for the CO2_PQ MEX-file.
%
% Calculates fluid properties of carbon dioxide at the thermodynamic state
% defined by the provided pressure (P, in kPa) and quality (Q, from 0 to 1).
%
% The calling syntax is:
% 
%   [prop1, prop2, ...] = CO2_PQ(P, Q, 'prop1', 'prop2', ...)
%
% with the requested property strings being one or more of:
%
%   temp -- temperature (K)
%   pres -- pressure (kPa)
%   dens -- density (kg/m3)
%   qual -- quality (-)
%   inte -- internal energy (kJ/kg)
%   enth -- enthalpy (kJ/kg)
%   entr -- entropy (kJ/kg-K)
%   cv   -- specific heat at constant volume (kJ/kg-K)
%   cp   -- specific heat at constant pressure (kJ/kg-K)
%   ssnd -- speed of sound (m/s)
%   visc -- viscosity (uPa-s) [note: 1 micro-Pa-s is 1e-6 Pa-s or 1e-6 kg/m-s]
%   cond -- thermal conductivity (W/m-K)
%
% Any number of the above strings can be used in any order, and the order of the output
% values returned by this function will correspond to the order of the property strings.
%
% Pressure and quality (P and Q) can be scalars or N-dimensional arrays.  The property values
% returned by this function will have the same size and shape as the inputs, which must match if
% both inputs are provided as arrays.  If one of the inputs is a scalar, its value will be used
% as though it were an array of identical values with the same size and shape of the other input.
%
% Note on Performance: Returning all the desired properties in one call is much more
% computationally efficient than calling this function multiple times at the same
% thermodynamic state.  Likewise, calling this function once with an array of pressure
% and quality values will be faster than iterating over a loop in MATLAB and calling
% this function multiple times with scalar pressure and quality values.
%
%
% This is a MEX-file for MATLAB that is part of the FIT Toolbox.
% Copyright 2016 Northland Numerics LLC
% 