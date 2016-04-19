% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
%    ][
%    ][                                          DXF Coordinate Extraction
%    ][
%    ][    This function will extract the coordinate x and y from .dxf file to use 
%    ][    in bulge calculation for simulate the Initial Fuel Surface (IFS) of the
%    ][    propellant.
%    ][    
%    ][    The important keyword of .dxf file is 'AcDbPolyline' that can tell us the
%    ][    start point of coordinate extraction. While do this process the program
%    ][    must check the numeric code as below.
%    ][    
%    ][    Numeric Codes     Description
%    ][    ----------------------------------------------------------------
%    ][             0                end of data section
%    ][            10                x value of the vertex (x coordinate)
%    ][            20                y value of the vertex (y coordinate)
%    ][            42                bulge
%    ][                                --> (-) sign = arc counter-clockwise
%    ][                                --> (+) sign = arc clockwise
%    ][            70                flag (1 = closed polyline)
%    ][            90                number of vertices
%    ][
%    ][    Created by : Wassanun Sangjun
%    ][    Date : 12/04/2016
%    ][    
% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

%function [coor_x,coor_y,bulge] = dxf_coordination_extraction()
    
    clc;
    clear all;
    close all;
    
    % Variable declaration.
    coor_x = [];
    coor_y = [];
    bulge = [];
    
    % Assign keyword for determine start point of coordinate extraction.
    start_point_keyword = 'AcDbPolyline';
    
    % Assign keyword for determine end point of coordinate extraction.
    end_point_keyword = 'ENDSEC';
    
    % Define path to read data from .dxf file.
    dxf_filepath = 'F:\DTI\Taotanukung Work\IB\IB_Offset-master\DTI1Star4.dxf';
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                            Step I : Read all data from .dxf file
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    
    % Open .dxf file which choosen follow the path.
    fid = fopen(dxf_filepath);
    
    % Read all data from .dxf file as cell array of strings.
    raw_dxf = textscan(fid,'%s');
    
    % After finish read all data then close the file.
    fclose(fid);
    
    % For easy operation with the data reshape it.
    raw_dxf = raw_dxf{1,1};
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                            Step II : Search data extraction zone
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

    % Define new variable to keep data extraction zone.
    pre_extract = {};
    
    % Define variable to keep start point of data extraction zone.
    start_point = 0;
    
    % This loop will find the begin section of coordinate extraction follow
    % start point keyword.
    for a = 1 : length(raw_dxf)
        if(strcmp(raw_dxf{a},start_point_keyword))
            start_point = a;
        end
    end
    
    % This loop will collect data for coordinate extraction process
    % until meet end point keyword.
    a = start_point;
    
    while(~strcmp(raw_dxf{a},end_point_keyword))
        pre_extract = [pre_extract raw_dxf{a}];
        a = a + 1;
    end
    
    % Arrange data again before extraction process.
    pre_extract = pre_extract(2:end-1);
    pre_extract = [pre_extract '0'];
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                     Step III : Seperate to coordinate and bulge
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    % This step will seperate the pre-processing data to coordinate x, y and
    % bulge follow numeric codes.
    
    % Define variable to collect something.
    num_coor = 0; % No. of coordinate.
    close_loop = 0; % Check close polygon.
    status_x = 0; % Check get x coordinate.
    status_y = 0; % Check get y coordinate.
    status_bulge = 0; % Check get bulge.
    sum_status = 0; % Check all status for manage bulge variable.
    
    for a = 1 : length(pre_extract) - 1        
        % Find number of coordinate.
        if(strcmp(pre_extract{a},'90'))
            num_coor = str2double(pre_extract{a+1});
        % Close polygon ?.
        elseif(strcmp(pre_extract{a},'70'))
            close_loop = str2double(pre_extract{a+1});
        % Coordinate x
        elseif(strcmp(pre_extract{a},'10'))
            status_x = 1;
            coor_x = [coor_x str2double(pre_extract{a+1})];
        % Coordinate y    
        elseif(strcmp(pre_extract{a},'20'))
            status_y = 1;
            coor_y = [coor_y str2double(pre_extract{a+1})];
        % Bulge
        elseif(strcmp(pre_extract{a},'42'))
            status_bulge = 1;
            bulge = [bulge str2double(pre_extract{a+1})];
        else
            continue;
        end
        
        % Sum all status for decide to manage the bulge variable.
        sum_status = sum([status_x status_y status_bulge]);
        
        if(sum_status == 3)
            % Reset status check.
            status_x = 0;
            status_y = 0;
            status_bulge = 0;
            sum_status = 0;      
        elseif((sum_status == 2 && strcmp(pre_extract{a+2},'10')) || (sum_status == 2 && strcmp(pre_extract{a+2},'0')))
            % This tell that between this vertices not have bulge.
            bulge = [bulge 0];
        else
            continue;
        end
    end
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                           Step IV : Rearrange the coordinate
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    % This step will rearrange coordinate x and y for use in bulge calculation
    % process.
    
    % Define variable to collect processed coordinate data.
    processed_coor_x = [];
    processed_coor_y = [];
    
    for a = 1 : length(coor_x)
        if(a == length(coor_x))
            processed_coor_x = [processed_coor_x;[coor_x(end) coor_x(1)]];
            processed_coor_y = [processed_coor_y;[coor_y(end) coor_y(1)]];
        else
            processed_coor_x = [processed_coor_x;coor_x(a:a+1)];
            processed_coor_y = [processed_coor_y;coor_y(a:a+1)];
        end
    end
    
    
    plot(coor_x,coor_y,'- red');
    pause;

    
    [all_coor_x,all_coor_y] = bulge_calculation(processed_coor_x,processed_coor_y,bulge);
    disp('finish');
   
%     
%     figure;
%     plot(X_IFS,Y_IFS)
    
%end