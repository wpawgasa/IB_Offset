% -o][------------------------------------------------------------------------][o-
%    ][                                                                                                     ][
%    ][                          Traffic Graphic User Interface                            ][
%    ][                                                                                                     ][
%    ][       Description : This progarm will create GUI for user to see the   ][
%    ][                            traffic data more easier. They can choose a          ][
%    ][                            parameter to see an anomaly event on graph.         ][
%    ][       Created by  : Mr.Wassanun Sangjun                                          ][
%    ][       Date           : Tuesday 27th November 2012                              ][
%    ][                                                                                                     ][
% -o][------------------------------------------------------------------------][o-

function traffic_gui()
    
    % Clear all variable in workspace and close all figure;
    clear all;
    close all;
    clc;

    % Set color for all element in GUI
    bg_color = [255/255 230/255 157/255];
    font1_color = [0 0 0];
    graph1_color = [255/255 165/255 28/255];

    % Set font property for text in GUI
    font_type = 'Calibri';
    font_size1 = 12;
    font_size2 = 11;
    font_size3 = 10;

    % -o][------------------------------------------------------------------------][o-
    %                                   Create GUI and set background 
    % -o][------------------------------------------------------------------------][o-

    % Prevent figure(1) show after execute.
    close(figure(1));

    % Create GUI figure. (set name, size and position)
    main_traffic = figure('name','Traffic Graphic User Interface (Traffic GUI)','numbertitle','off',...
              'position',[0 0 1000 600],'resize','off');
    movegui('center');

    mhandles = guihandles(main_traffic);

    % Set axes for background image of this GUI.
    axes_handle = axes('unit','normalized','position',[0 0 1 1]);

    % Import the background image for this GUI.
    background = imread('traffic_gui_background_edit.jpg'); 
    imagesc(background);

    % Prevent show an axes on image.
    set(axes_handle,'handlevisibility','off','visible','off');

    % Making sure the background must behind all the other uicontrols.
    uistack(axes_handle,'bottom');

    % -o][------------------------------------------------------------------------][o-
    %    ][                              Create all component in GUI                             ][
    % -o][------------------------------------------------------------------------][o-

    tag1 = uicontrol('style','text','string','Instruction : This program will show anomaly event on graph after you select data set and parameter.',...
                  'position',[30 590 665 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1);
    tag2 = uicontrol('style','text','string','Please choose textfile and push get data button for plot graph.',...
                  'position',[30 560 415 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1);
    textbox1 = uicontrol('style','edit','backgroundcolor','white',...
                  'position',[30 525 500 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1);
    getdata_button = uicontrol('style','pushbutton','string','Get Data','backgroundcolor',bg_color,...
                  'position',[665 525 100 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2);
    browse_button = uicontrol('style','pushbutton','string','Browse File','backgroundcolor',bg_color,...
                  'position',[550 525 100 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2);
    tag3 = uicontrol('style','text','string','Please choose a variable that you want to see graph status.',...
                  'position',[30 495 395 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'visible','off');
    dropdown_list = uicontrol('style','popupmenu','backgroundcolor','white',...
                  'position',[30 465 500 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1);
    result_graph = axes('unit','normalized','position',[0.09 0.1 0.65 0.535]);
    
    % this command will read header file for use in list of dropdown list.
    fid = fopen('header.txt','rt');
    tline = fgets(fid);
    i = 1;
    header = {};

    while ischar(tline)
        header{i} = tline;
        tline = fgets(fid);
        i = i + 1;
    end
    clear i fid tline;

    set(getdata_button,'enable','off');
    set(textbox1,'enable','off');
    set(browse_button,'callback',{@browsefile,textbox1,getdata_button,tag3,dropdown_list,result_graph});
    set(dropdown_list,'string',header,'visible','off');
    set(result_graph,'visible','off');
    
    % -o][------------------------------------------------------------------------][o-         
    %        Step I ::: Select textfile that you want and get data for plot graph.
    % -o][------------------------------------------------------------------------][o-
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                     Function : Browse File 
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-   
    function browsefile(hobject,eventdata,handles1,handles2,handles3,handles4,handles5)

        [filename dirpath] = uigetfile('*.txt','Please select text file...');
 
        % This condition will check conditon about text file.
        if isequal(filename,0) || isequal(dirpath,0)
            return;
        elseif (isempty(regexp(strcat(dirpath,filename),'.txt')))
            msgbox('Please choose text file only.','Warning !!!','warn');
            set(handles1,'enable','off');
            set(handles2,'enable','off');
        else
            filepath = strcat(dirpath,filename);
            set(handles1,'enable','on');
            set(handles2,'enable','on');
            set(handles1,'string',filepath);
            set(handles2,'callback',{@get_data,get(handles1,'string'),handles3,handles4,handles5,handles2});
        end    
    end
    
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                       Function : Get Data 
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function get_data(hobject,eventdata,filepath,tag,popup,graph,getdata_button)
        
        set(getdata_button,'enable','off');
        
        % This command will open textfile and read all data that user selected.
        fid = fopen(filepath,'rt');
        temp =  textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
        fclose(fid);
        
        % This loop will get data from temp and convert it to array.
        rawdata = [];
    
        for a = 1 : length(temp)
            test = temp{1,a};
            rawdata = [rawdata test];
        end
        clear a;
    
        % This command convert data in cell to matrix. 
        rawdata_convert = cellfun(@str2num,rawdata);
        real_data = rawdata_convert;
        open_popup(real_data,tag,popup,graph);
    end
    
    % -o][------------------------------------------------------------------------][o-         
    %           Step II ::: Select a variable that you want to see graph status.
    % -o][------------------------------------------------------------------------][o-
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                     Function : Open Popup
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function open_popup(real_data,tag,popup,graph)
        % This component will appear for introduce user to do next step.
        set(tag,'visible','on');
        set(popup,'visible','on');
        set(popup,'callback',{@selected_variables,real_data,popup,graph});
    end
    
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                     Function : Select Variables
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function selected_variables(hobject,eventdata,real_data,popup,graph)
        % This component will appear for introduce user to do next step.

        choice = get(popup, 'String');
        index = get(popup,'Value');
        
        % This switch case will decide to plot for each variables follow
        % user's selection.
        switch choice{index}
            case choice{2}
                plot_graph(real_data(:,2),real_data(:,17),choice{index},graph);
            case choice{3}
                plot_graph(real_data(:,3),real_data(:,17),choice{index},graph);
            case choice{4}
                plot_graph(real_data(:,4),real_data(:,17),choice{index},graph);
            case choice{5}
                plot_graph(real_data(:,5),real_data(:,17),choice{index},graph);
            case choice{6}
                plot_graph(real_data(:,6),real_data(:,17),choice{index},graph);
            case choice{7}
                plot_graph(real_data(:,7),real_data(:,17),choice{index},graph);
            case choice{8}
                plot_graph(real_data(:,8),real_data(:,17),choice{index},graph);
            case choice{9}
                plot_graph(real_data(:,9),real_data(:,17),choice{index},graph);
            case choice{10}
                plot_graph(real_data(:,10),real_data(:,17),choice{index},graph);
            case choice{11}
                plot_graph(real_data(:,11),real_data(:,17),choice{index},graph);
            case choice{12}
                plot_graph(real_data(:,12),real_data(:,17),choice{index},graph);
            case choice{13}
                plot_graph(real_data(:,13),real_data(:,17),choice{index},graph);
            case choice{14}
                plot_graph(real_data(:,14),real_data(:,17),choice{index},graph);
            case choice{15}
                plot_graph(real_data(:,15),real_data(:,17),choice{index},graph);
            case choice{16}
                plot_graph(real_data(:,15),real_data(:,17),choice{index},graph);
            otherwise
                msgbox('Please choose variable first !!!.','Warning !!!','warn');
        end
    end

    % -o][------------------------------------------------------------------------][o-         
    %             Step III ::: Plot graph of each variables that user selected.
    % -o][------------------------------------------------------------------------][o-
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                       Function : Plot Graph
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function plot_graph(data,traffic_status,head_graph,graph)
        set(graph,'visible','on','fontname',font_type,'fontsize',font_size3);
        start_time = datenum('06:00:00');
        end_time = datenum('17:59:30');
        xData = linspace(start_time,end_time,length(data));
        step_tick = 1:119:length(data);
        step_tick(end + 1) = length(data);
        plot(data,'color','blue');
        grid on;
        hold on;
        
        detect_head = [];
        detect_tail = [];
        count_head = 1;
        count_tail = 1;
        
        for a = 2 : length(data)
            % This condition will detect position at the begin of each case.
            if(traffic_status(a-1) == 0 && traffic_status(a) == 1 || traffic_status(a-1) == 0 && traffic_status(a) == 2)
                detect_head(count_head) = a;
                count_head = count_head + 1;
            end
            % This condition will detect position at the end of each case.
            if(traffic_status(a) == 1 && traffic_status(a+1) == 0 || traffic_status(a) == 2 && traffic_status(a+1) == 0)
                detect_tail(count_tail) = a;
                count_tail = count_tail + 1;
            end
        end
        
        for a = 1 : length(detect_head) 
            plot(detect_head(a):detect_tail(a),data(detect_head(a):detect_tail(a)),'color','red','linewidth',1);
        end
        
%         set(gca,'XTick',xData(step_tick));
%         datetick('x','HH:MM','keepticks');
        graph_title = ['Graph show anomaly status of ' head_graph];
        title(graph_title);
        xlabel('Time');
        ylabel(head_graph);
        hold off;
    end
end





