% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
%    ][    This function will create a GUI from Geomatric Input Pre-Calculation (GIP) 
%    ][    original program for test the program.
%
%    ][    Original created by : Tonkid Chantrasmi
%    ][    Renew created by : Wassanun Sangjun
%    ][    Date : 07/04/2016 
% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

function gip_gui_original()

    clc;
    clear all;
    close all;

    % Create and then hide the GUI as it is being constructed.
    gip_gui = figure('visible','on','position',[0,0,240,430]);
    movegui(gip_gui,'center');

    % --------------------------------------
    % Internal Variables
    % --------------------------------------
    inputs = '';
    outputs = '';
    input_filename = '';
    input_pathname = '';
    x0 = 0;
    y0 = 0;
    radius = 56;
    offset_max = 13;
    offset_step = 1;
    tracing_tol = 1.0;
    n_underlying_intervals = 100;

    % --------------------------------------
    % Construct the GUI components
    % --------------------------------------

    button_1 = uicontrol('style','pushbutton',...
                                   'string','Please select CAD file. (.dxf)',...
                                   'position',[30,380,180,25],...
                                   'callback',{@cad_file_select});
    
    % --------------------------------------
    % Construct the GUI components
    % --------------------------------------
    
    % Select CAD file.
    % --------------------------------------
    function cad_file_select(object,eventdata)
        
        % Get name and pathname of file that user selected.
        [filename,pathname] = uigetfile({'*.txt;*.dxf';'*.*'},...
                                                       'Please select CAD file. (.dxf)');
        
        % Check type of file must be .dxf file.
        if(~isequal(filename,0))
            inputs.input_file = fullfile(pathname,filename);
            input_filename = filename;
        end
    end

end

