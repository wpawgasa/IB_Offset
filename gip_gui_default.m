% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
%    ][
%    ][                                 GIP GUI Default Configuration File
%    ][
%    ][    This function will initialize the variables for Geomatric Input Pre-Calculation (GIP) 
%    ][    program if user does not define it. (User can edit it as appropriate)
%    ][
%    ][    Created by : Wassanun Sangjun
%    ][    Date : 08/04/2016
%    ][    
% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

function [x0,y0,radius,offset_max,offset_step,tracing_tol,n_underlying_intervals] = gip_gui_default()

    x0 = 0;
    y0 = 0;
    radius = 56;
    offset_max = 13;
    offset_step = 1;
    tracing_tol = 1.0;
    n_underlying_intervals = 100;
    
end