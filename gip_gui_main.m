% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
%    ][
%    ][                                                 GIP GUI Main
%    ][
%    ][    This function will create a GUI from Geomatric Input Pre-Calculation (GIP) 
%    ][    original program for test the program.
%    ][
%    ][    Original created by : Tonkid Chantrasmi
%    ][    Renew created by : Wassanun Sangjun
%    ][    Date : 07/04/2016
%    ][    
% -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

function gip_gui_main()

    clc;
    clear all;
    close all;
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                                   GUI properties initialization 
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    font_type = 'Calibri';
    font_size_1 = 10;
    font_size_2 = 11;
    font_size_3 = 12;
    font_size_4 = 13;
    font_color_1 = [0 0 0]; % Black Color
    font_color_2 = [1 1 1]; % White Color
    bg_color_1 = [0 0 0]; % Black Color
    bg_color_2 = [1 1 1]; % White Color
    
    plot_type_list = {'--- Choose ---','Open','High','Low','Close'};
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                                   Create GUI and set background 
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-

    % Create GUI figure. (set name, size and position)
    main_gip_gui = figure('name','Geomatric Input Pre-Calculation (GIP) for Internal Ballistic','numbertitle','off',...
              'position',[0 0 1000 600],'resize','off','color','white');
    movegui(main_gip_gui,'center');
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                                   Create all components of GUI 
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    
    % GUI panel.
    % ---------------------------------------------------------------------------------
    load_dxf_uipanel = uipanel('title','Load CAD file','fontsize',font_size_2,'fontname',font_type,...
                                            'foregroundcolor','black','backgroundcolor','none','position',[0.025 0.8 0.95 0.125],...
                                            'bordertype','line','highlightcolor',bg_color_1,'borderwidth',3,...
                                            'parent',main_gip_gui);
    define_casing_uipanel = uipanel('title','Define Casing','fontsize',font_size_2,...
                                                  'fontname',font_type,'backgroundcolor','none','position',[0.025 0.590 0.375 0.185],...
                                                  'bordertype','line','highlightcolor',bg_color_1,'borderwidth',3,...
                                                  'parent',main_gip_gui);
    offsets_uipanel = uipanel('title','Offsets','fontsize',font_size_2,...
                                         'fontname',font_type,'backgroundcolor','none','position',[0.025 0.435 0.375 0.125],...
                                         'bordertype','line','highlightcolor',bg_color_1,'borderwidth',3,...
                                         'parent',main_gip_gui);
    numerical_parameters_uipanel = uipanel('title','Numerical Parameters','fontsize',font_size_2,...
                                                               'fontname',font_type,'backgroundcolor','none','position',[0.025 0.23 0.375 0.175],...
                                                               'bordertype','line','highlightcolor',bg_color_1,'borderwidth',3,...
                                                               'parent',main_gip_gui);
                                    
    % Tag or text description.
    % ---------------------------------------------------------------------------------
    tag_1 = uicontrol('style','text','string','Instruction : This program will show the components of internal ballistic propellant after you select CAD file. (.dxf file)',...
                             'position',[30 590 815 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_4,'backgroundcolor',bg_color_2);
    tag_2 = uicontrol('style','text','string','Please choose CAD file (.dxf file) >>> ',...
                              'position',[15 20 250 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                              'foregroundcolor',font_color_1,'backgroundcolor','default','parent',load_dxf_uipanel);
    tag_x0 = uicontrol('style','text','string','X0 :',...
                               'position',[20 28 25 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                               'foregroundcolor',font_color_1,'backgroundcolor','default','parent',define_casing_uipanel);
    tag_y0 = uicontrol('style','text','string','Y0 :',...
                               'position',[130 28 25 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                               'foregroundcolor',font_color_1,'backgroundcolor','default','parent',define_casing_uipanel);
    tag_r = uicontrol('style','text','string','R :',...
                              'position',[240 28 25 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                              'foregroundcolor',font_color_1,'backgroundcolor','default','parent',define_casing_uipanel);                        
    tag_max_dist = uicontrol('style','text','string','Max Dist. :',...
                                         'position',[20 22.5 75 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                         'foregroundcolor',font_color_1,'backgroundcolor','default','parent',offsets_uipanel);                          
    tag_offset_step = uicontrol('style','text','string','Offset Step :',...
                                              'position',[180 22.5 85 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                              'foregroundcolor',font_color_1,'backgroundcolor','default','parent',offsets_uipanel);                       
    tag_tracing_tol = uicontrol('style','text','string','Tracing Tol. :',...
                                            'position',[20 55 85 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                            'foregroundcolor',font_color_1,'backgroundcolor','default','parent',numerical_parameters_uipanel);
    tag_tracing_tol = uicontrol('style','text','string','Number of Underlying Intervals :',...
                                            'position',[20 18 215 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                            'foregroundcolor',font_color_1,'backgroundcolor','default','parent',numerical_parameters_uipanel);
    tag_progress = uicontrol('style','text','string','Progress : 0%',...
                                         'position',[150 99 115 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                         'foregroundcolor',font_color_1,'backgroundcolor','default','parent',main_gip_gui);
    tag_graph_header = uicontrol('style','text','string','Graph show the components of propellant.',...
                                         'position',[450 460 350 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                         'foregroundcolor',font_color_1,'backgroundcolor','default','parent',main_gip_gui);
    tag_plot_type = uicontrol('style','text','string','Plot Type :',...
                                         'position',[450 50 75 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                         'foregroundcolor',font_color_1,'backgroundcolor','default','parent',main_gip_gui);                                 
                                                  
    % Button.
    % ---------------------------------------------------------------------------------
    browse_dxf = uicontrol('style','pushbutton','string','Browse','backgroundcolor','default',...
                                       'position',[275 17 100 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size_2,...
                                       'parent',load_dxf_uipanel);
    compute = uicontrol('style','pushbutton','string','Compute','backgroundcolor','default',...
                                  'position',[30 95 100 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size_2,...
                                  'parent',main_gip_gui);
    plot_graph = uicontrol('style','pushbutton','string','Plot Graph','backgroundcolor','default',...
                                  'position',[30 50 125 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size_2,...
                                  'parent',main_gip_gui);                          
    export_file = uicontrol('style','pushbutton','string','Export File','backgroundcolor','default',...
                                  'position',[180 50 125 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size_2,...
                                  'parent',main_gip_gui);                          
                              
    % Textbox.
    % ---------------------------------------------------------------------------------
    show_dxf = uicontrol('style','edit','backgroundcolor','white','position',[390 17 525 30],'horizontalalignment','left',...
                                    'fontname',font_type,'fontsize',font_size_1,'parent',load_dxf_uipanel);
    x0_box = uicontrol('style','edit','backgroundcolor','white','position',[55 26 60 30],'horizontalalignment','center',...
                                'fontname',font_type,'fontsize',font_size_1,'parent',define_casing_uipanel,'enable','on',...
                                'horizontalalignment','center');                           
    y0_box = uicontrol('style','edit','backgroundcolor','white','position',[165 26 60 30],'horizontalalignment','center',...
                                'fontname',font_type,'fontsize',font_size_1,'parent',define_casing_uipanel,'enable','on',...
                                'horizontalalignment','center');   
    r_box = uicontrol('style','edit','backgroundcolor','white','position',[275 26 60 30],'horizontalalignment','center',...
                              'fontname',font_type,'fontsize',font_size_1,'parent',define_casing_uipanel,'enable','on',...
                              'horizontalalignment','center');
    max_dist_box = uicontrol('style','edit','backgroundcolor','white','position',[105 20 60 30],'horizontalalignment','center',...
                                          'fontname',font_type,'fontsize',font_size_1,'parent',offsets_uipanel,'enable','on',...
                                          'horizontalalignment','center');                         
    offset_box = uicontrol('style','edit','backgroundcolor','white','position',[275 20 60 30],'horizontalalignment','center',...
                                      'fontname',font_type,'fontsize',font_size_1,'parent',offsets_uipanel,'enable','on',...
                                      'horizontalalignment','center');                         
    tracing_tol_box = uicontrol('style','edit','backgroundcolor','white','position',[275 53 60 30],'horizontalalignment','center',...
                                             'fontname',font_type,'fontsize',font_size_1,'parent',numerical_parameters_uipanel,'enable','on',...
                                             'horizontalalignment','center');
    no_interval_box = uicontrol('style','edit','backgroundcolor','white','position',[275 15 60 30],'horizontalalignment','center',...
                                             'fontname',font_type,'fontsize',font_size_1,'parent',numerical_parameters_uipanel,'enable','on',...
                                             'horizontalalignment','center');                                     
                                                           
    % Checkbox.
    % ---------------------------------------------------------------------------------
    checkbox_1 = uicontrol('style','checkbox','string','Automatically from CAD','backgroundcolor',bg_color_2,'position',[20 67 300 20],'horizontalalignment','left',...
                                      'fontname',font_type,'fontsize',font_size_2,'parent',define_casing_uipanel);
                         
    % Display graph area.
    % ---------------------------------------------------------------------------------
    result_graph = axes('unit','normalized','position',[0.45 0.145 0.375 0.555],'fontname',font_type,'fontsize',font_size_4,...
                                  'xcolor','black','ycolor','black','color','black','gridlinestyle','-','parent',main_gip_gui);
    
    % Popup list view.
    % ---------------------------------------------------------------------------------
    graph_plot_list = uicontrol('style','popupmenu','foregroundcolor','black','backgroundcolor','white',...
                                           'position',[540 53 275 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size_3,...
                                           'parent',main_gip_gui);
    set(graph_plot_list,'string',plot_type_list);
    
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                                  GUI component initialization  
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
   
    set(browse_dxf,'callback',{@browsefile,show_dxf});
    set(show_dxf,'enable','off');
    set(checkbox_1,'callback',{@set_default,x0_box,y0_box,r_box,max_dist_box,offset_box,tracing_tol_box,no_interval_box})

%     % Create and then hide the GUI as it is being constructed.
%     gip_gui = figure('visible','on','position',[0,0,240,430]);
%     movegui(gip_gui,'center');
% 
%     % --------------------------------------
%     % Internal Variables
%     % --------------------------------------
%     inputs = '';
%     outputs = '';
%     input_filename = '';
%     input_pathname = '';
%     x0 = 0;
%     y0 = 0;
%     radius = 56;
%     offset_max = 13;
%     offset_step = 1;
%     tracing_tol = 1.0;
%     n_underlying_intervals = 100;
% 
%     % --------------------------------------
%     % Construct the GUI components
%     % --------------------------------------
% 
%     button_1 = uicontrol('style','pushbutton',...
%                                    'string','Please select CAD file. (.dxf)',...
%                                    'position',[30,380,180,25],...
%                                    'callback',{@cad_file_select});
%     
%     % --------------------------------------
%     % Construct the GUI components
%     % --------------------------------------
%     
%     % Select CAD file.
%     % --------------------------------------
%     function cad_file_select(object,eventdata)
%         
%         % Get name and pathname of file that user selected.
%         [filename,pathname] = uigetfile({'*.txt;*.dxf';'*.*'},...
%                                                        'Please select CAD file. (.dxf)');
%         
%         % Check type of file must be .dxf file.
%         if(~isequal(filename,0))
%             inputs.input_file = fullfile(pathname,filename);
%             input_filename = filename;
%         end
%     end

    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    %                                     GUI callback function  
    % -o][=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=][o-
    
    % ---------------------------------------------------------------------------------
    %                                     Function : Browse File 
    % ---------------------------------------------------------------------------------   
    function browsefile(hobject,eventdata,show_dxf)

        [filename dirpath] = uigetfile('*.dxf','Please select CAD file... (.dxf file)');
 
        % This condition will check conditon about text file.
        if isequal(filename,0) || isequal(dirpath,0)
            return;
        elseif (isempty(regexp(strcat(dirpath,filename),'.dxf')))
            msgbox('Please choose .dxf file type only.','Warning !!!','warn');
            set(show_dxf,'enable','off');
        else
            filepath = strcat(dirpath,filename);
            set(show_dxf,'enable','off');
            set(show_dxf,'string',filepath);
%             set(handles2,'callback',{@update_set100_stock,filepath,handles2,handles3,table_data1,table_data2});
        end    
    end

    % ---------------------------------------------------------------------------------
    %                                     Function : Set Default 
    % ---------------------------------------------------------------------------------   
    function set_default(hobject,eventdata,x0_box,y0_box,r_box,max_dist_box,offset_box,tracing_tol_box,no_interval_box)

        [x0,y0,radius,offset_max,offset_step,tracing_tol,n_underlying_intervals] = gip_gui_default();
        
        % This value will collect the status of checkbox.
        status_check = get(hobject,'value');
        
        if(status_check == 1)
            set(x0_box,'string',x0);
            set(x0_box,'enable','off');
            set(y0_box,'string',y0);
            set(y0_box,'enable','off');
            set(r_box,'string',radius);
            set(r_box,'enable','off');
            set(max_dist_box,'string',offset_max);
            set(offset_box,'string',offset_step);
            set(tracing_tol_box,'string',tracing_tol);
            set(no_interval_box,'string',n_underlying_intervals);
        else
            set(x0_box,'string','');
            set(x0_box,'enable','on');
            set(y0_box,'string','');
            set(y0_box,'enable','on');
            set(r_box,'string','');
            set(r_box,'enable','on');
            set(max_dist_box,'string','');
            set(offset_box,'string','');
            set(tracing_tol_box,'string','');
            set(no_interval_box,'string','');
        end
            
        
    end

end

