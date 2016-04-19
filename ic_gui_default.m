% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
%    ][
%    ][                                   IC GUI Default Configuration File
%    ][
%    ][    This function will initialize the variables for Internal Combustion (IC) 
%    ][    program if user does not define it. (User can edit it as appropriate)
%    ][
%    ][    Created by : Wassanun Sangjun
%    ][    Date : 11/04/2016
%    ][    
% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

function [d_throat,mass_ig,time_ig,dx,dt,max_nt,p_initial_guess,tol,offset1,offset2,...
              length1,length2,length3,length4,length5] = ic_gui_default()

    d_throat = 50;
    mass_ig = 0.151;
    time_ig = 0.1;
    dx = 0.03;
    dt = 0.02;
    max_nt = 100;
    p_initial_guess = 1700; % PSI
    tol = 1e-5;
    offset1 = 0;
    offset2 = 0;
    length1 = 1.2;
    length2 = 0;
    length3 = 0;
    length4 = 0;
    length5 = 0;
    
end