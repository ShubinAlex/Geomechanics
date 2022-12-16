function [Sv, Shydro] = stress(density, depth, water_depth)
%STRESS calculate overburden and hydrostatic stresses
%   input:
%   density - density log, kg/m3
%   depth, meters
%   water_depth, meteres, for onshore wells: 0
%   output:
%   overburden -Sv and hydrostatic -Shydro stresses, MPa

g=10;
Sv=zeros(length(depth),1);
Shydro=zeros(length(depth),1);
cumden=cumsum(density);
for i=1:length(depth)
    Sv(i)=((cumden(i)./i.*g.*(depth(i)-water_depth))./1000000)+(1000.*g.*water_depth./1000000);
    Shydro(i)=1000.*g.*depth(i)./1000000;
end
plot(Sv,depth, 'r');
set(gca,'YDir','reverse')
hold on;
plot(Shydro,depth);
set(gca,'YDir','reverse')
end

