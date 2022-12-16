function [ A,B ] = bowers( Vint, V0, Sv, Pp )
% BOWERS - calculate coefficients (A,B) for Bower's equation: V=V0+A*sigma^B

%   input
% Vint - interval velocities,  m/s (log or seismic)
% V0 - velocity of unconsolidated sediments (1500 m/s)
% Sv - overbuden stress, MPa
% Pp - pore pressure (RFT, mud weight measurments) or hydrostatic, MPa
%   output
% A,B coefficients

Vint=Vint.*3.281; % ft/s
V0=V0.*3.281;
sigma=Sv-Pp; % effective stress
sigma=sigma.*145.0378; % psi
Lg_sigma=log(sigma); % Ln(sigma)
Lg_V=log(Vint-V0);
Unit_vector=ones(max(size(Vint)),1); 
Matrix=[Unit_vector,Lg_sigma];
X=(Matrix'*Matrix)\(Matrix'*Lg_V); % Least squares inversion
B=X(2,1);
A=exp(X(1,1)./B);



end

