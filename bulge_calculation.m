% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
%    ][
%    ][                                                 Bulge Calculation
%    ][
%    ][    This function will calculate bulge of the Initial Fuel Surface (IFS) from the   
%    ][    processed coordinate.
%    ][
%    ][    Original created by : Tonkid Chantrasmi
%    ][    Renew created by : Wassanun Sangjun
%    ][    Date : 18/04/2016
%    ][    
% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

function [all_coor_x,all_coor_y] = bulge_calculation(coor_x,coor_y,bulge)

all_coor_x = [];
all_coor_y = [];

for a = 1 : size(coor_x,1)
% Extract the end points
% P1=[X_CAD(i) Y_CAD(i) ];
% P2=[X_CAD(i+1) Y_CAD(i+1)];


P1 = [coor_x(a,1) coor_y(a,1)];
P2 = [coor_x(a,2) coor_y(a,2)];
BU_CAD = bulge;
ds = 1;

X_IFS = [];
Y_IFS = [];

%Calculate normal vector (with right-hand-rule  convention)
N=cross([P2-P1 0],[0 0 -1]); N=N(1:2); N=N/norm(N);

%Calculate chord length (P1 to P2)
chord = norm(P1-P2);

%Check if there is bulge

if(BU_CAD(a) == 0)% no bulge,meaning straight line
    % Subdivide the line
    np=ceil(chord/ds)+1;
    % np=2;
    for j=1:np-1 % exclude the last vetext
        P=P1 + (j-1)/(np-1)*(P2-P1);
        X_IFS(end+1)=P(1);
        Y_IFS(end+1)=P(2);
    end 
else % there is a bulge
     % Calculate the included angle
     th=4*atan(BU_CAD(a));
     
     % Distance from chord to circle center
     l= chord/2/tan(th/2);
     
     % Circle center and radius
     c=(P1+P2)/2+ 1*N;
     R=norm(P1-c);
     
     % Starting and ending angles
     a1 = atan2(P1(2)-c(2),P1(1)-c(1));
     a2 = atan2(P2(2)-c(2),P2(1)-c(1));
     
     % Adjust the values of a1 and a2 + Calculating arc length
     if(th<0) % the bulge arc goes clockwise , which requires a1>a2
         while(a1<a2)
             a1=a1+2*pi;
         end 
         arc_length=(a1-a2)*R;
     else % the bulge arc goes counter-clockwise,which requires a1<a2
         
         while(a1>a2)
             a1=a1-2*pi;
         end
         arc_length=(a2-a1)*R;
     end 
     % Subdivide the arc
     np=ceil(arc_length/ds)+1;
     for j=1:np-1 % exclude the last vertex
         a=a1+(j-1)/(np-1)*(a2-a1);
         X_IFS(end+1)=c(1)+R*cos(a);
         Y_IFS(end+1)=c(2)+R*sin(a);
     end

end

all_coor_x = [all_coor_x X_IFS];
all_coor_y = [all_coor_y Y_IFS];


end

plot(all_coor_x,all_coor_y,'- red');

end

