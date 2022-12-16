function [] = zobackogram(Sv, Pp, mu, Wbo, T0, Ceff, dP, sigma_dT)
%ZOBACKOGRAM boundaries for stress regimes
%   input
%   Sv - vertical stress
%   Pp - pore pressure
%   mu - coefficient of sliding friction (0.6-1)
%   Wbo - wellbore breakout width (rad), 0 signifies no wellbore breakouts were observed.
%   T0 - rock tensile strength (should be negative)
%   Ceff - effective rock compressive strength
%   dP - difference between the mud weight in the wellbore and the pore pressure
%   sigma_dT - thermal stresses (sigma_dT=alpha*E*dT/(1-nu))
%       alpha - linear coefficient of thermal expansion
%       E - static Young’s modulus
%       nu - Poisson coefficient
%       dT - difference between the mud temperature and formation temperature

%output
%   stress polygons

% Normal faulting
Shmin1=(Sv-Pp+Pp.*(sqrt(mu.^2+1)+mu).^2)./((sqrt(mu.^2+1)+mu).^2);
Shmax1=Shmin1;

Shmin2=Shmin1;
Shmax2=Sv;

Shmin3=Sv;
Shmax3=Sv;

NF_x1=[Shmin1 Shmin2 Shmin3 Shmin1];
NF_y1=[Shmax1 Shmax2 Shmax3 Shmax1];

plot(NF_x1, NF_y1);
hold on;

% Strike-Slip regime

Shmin4=Sv;
Shmax4=((sqrt(mu.^2+1)+mu).^2).*(Shmin4-Pp)+Pp;

NF_x2=[Shmin2 Shmin4 Shmin3 Shmin2];
NF_y2=[Shmax2 Shmax4 Shmax3 Shmax2];

plot(NF_x2, NF_y2);
hold on;

% Reverse faulting

Shmax5=((sqrt(mu.^2+1)+mu).^2).*(Sv-Pp)+Pp;
Shmin5=Shmax5;

NF_x3=[Shmin3 Shmin4 Shmin5 Shmin3];
NF_y3=[Shmax3 Shmax4 Shmax5 Shmax3];

plot(NF_x3, NF_y3);

% Tensile fracture
Shmin6=Shmin1;
Shmax6=3.*Shmin6-2.*Pp-dP-T0-sigma_dT;

Shmin7=Sv;
Shmax7=3.*Shmin7-2.*Pp-dP-T0-sigma_dT;

Line6_x=[Shmin6 Shmin7];
Line6_y=[Shmax6 Shmax7];

plot(Line6_x, Line6_y, 'g');

% Wellbore breakouts
theta=pi-Wbo;
Shmin8=Sv;
Shmax8=((Ceff+2.*Pp+dP+sigma_dT)-Shmin8.*(1+2.*cos(theta)))/(1-2.*cos(theta));

Shmax9=Shmax5;
Shmin9=((Ceff+2.*Pp+dP+sigma_dT)-Shmax9.*(1-2.*cos(theta)))/(1+2.*cos(theta));

Line7_x=[Shmin8 Shmin9];
Line7_y=[Shmax8 Shmax9];

plot(Line7_x, Line7_y, 'r');

% Intersection

Shmin10=((1-2.*cos(theta)).*(2.*Pp+dP+T0+sigma_dT)+(Ceff+2.*Pp+dP+sigma_dT))/(3.*(1-2.*cos(theta))+(1+2.*cos(theta)));
Shmax10=((Ceff+2.*Pp+dP+sigma_dT)-Shmin10.*(1+2.*cos(theta)))/(1-2.*cos(theta));

Line8_x=[Shmin8 Shmin10];
Line8_y=[Shmax8 Shmax10];

plot(Line8_x, Line8_y, 'r');


end

