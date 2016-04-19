% -o][------------------------------------------------------------------------][o-
%    ][                                                                                                     ][
%    ][                    SET Stock Graphic User Interface V.3                       ][
%    ][                                                                                                     ][
%    ][       Description : This progarm will create GUI for user to see the   ][
%    ][                           SET stock data more easier. They can add             ][
%    ][                           new data to each stock data in list.                        ][
%    ][       Created by  : Mr.Wassanun Sangjun                                          ][
%    ][       Date           : Monday 9th June 2014                                        ][
%    ][                                                                                                     ][
% -o][------------------------------------------------------------------------][o-

function set100_stock_gui_ver_3()
   
    % Set color for all element in GUI
    bg_color1 = [187/255 224/255 227/255];
    bg_color2 = [230/255 244/255 245/255];
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
    main_set100_gui = figure('name','SET100 Stock Graphic User Interface (SET100 Stock GUI)','numbertitle','off',...
              'position',[0 0 1000 600],'resize','off','color','white');
    movegui('center');

    mhandles = guihandles(main_set100_gui);

    % Set axes for background image of this GUI.
    axes_handle = axes('unit','normalized','position',[0 0 1 1]);

    % Import the background image for this GUI.
    background = imread('./Image/stock_background_clean.jpg'); 
    imagesc(background);

    % Prevent show an axes on image.
    set(axes_handle,'handlevisibility','off','visible','off');

    % Making sure the background must behind all the other uicontrols.
    uistack(axes_handle,'bottom');

    % -o][------------------------------------------------------------------------][o-
    %    ][                              Create all component in GUI                             ][
    % -o][------------------------------------------------------------------------][o-
    
    % =+=+=+=+=+=+=+=+=  GUI panel here =+=+=+=+=+=+=+=+= 
    check_update_uipanel = uipanel('title','Check status of SET100 stock database','fontsize',font_size2,...
                                        'fontname',font_type,'backgroundcolor','none','position',[0.03 0.48 0.7 0.40],...
                                        'bordertype','line','highlightcolor',bg_color1,'borderwidth',3);
    database_update_uipanel = uipanel('title','SET100 stock database update from file','fontsize',font_size2,...
                                        'fontname',font_type,'backgroundcolor','none','position',[0.03 0.295 0.7 0.175],...
                                        'bordertype','line','highlightcolor',bg_color1,'borderwidth',3);
    database_manual_uipanel = uipanel('title','SET100 stock database manual update','fontsize',font_size2,...
                                        'fontname',font_type,'backgroundcolor','none','position',[0.03 0.025 0.675 0.26],...
                                        'bordertype','line','highlightcolor',bg_color1,'borderwidth',3);
                                    
    % =+=+=+=+=+=+=+=+=  GUI tag here =+=+=+=+=+=+=+=+=     
    tag1 = uicontrol('style','text','string','Instruction : This program is a database of SET100 stock data which user can do an operation like check and update stock info',...
                  'position',[30 590 830 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,'parent',main_set100_gui);
    tag2 = uicontrol('style','text','string','or manage data in a SET100 stock database.',...
                  'position',[30 570 300 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,'parent',main_set100_gui);
    tag3 = uicontrol('style','text','string','Please push ''Check Update'' button to see status of SET100 database >>>',...
                  'position',[15 200 450 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',check_update_uipanel);
    tag4 = uicontrol('style','text','string','-=] Same date stock data [=-',...
                  'position',[80 170 180 20],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',check_update_uipanel);
    tag5 = uicontrol('style','text','string','-=] Different date stock data [=-',...
                  'position',[415 170 205 20],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',check_update_uipanel);
    tag6 = uicontrol('style','text','string','Please select .txt file to update SET100 stock database.',...
                  'position',[15 60 340 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_update_uipanel);
    tag7 = uicontrol('style','text','string','Please fill the data to update SET100 stock database.',...
                  'position',[15 115 340 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag8 = uicontrol('style','text','string','Stock Name : ',...
                  'position',[15 80 85 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag9 = uicontrol('style','text','string','Date : ',...
                  'position',[250 80 45 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag10 = uicontrol('style','text','string','format >>> ddmmyyyy e.g. 10031990',...
                  'position',[435 80 230 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag11 = uicontrol('style','text','string','Open : ',...
                  'position',[15 45 45 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag12 = uicontrol('style','text','string','High : ',...
                  'position',[215 45 45 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag13 = uicontrol('style','text','string','Low : ',...
                  'position',[415 45 40 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag14 = uicontrol('style','text','string','Close : ',...
                  'position',[15 10 45 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    tag15 = uicontrol('style','text','string','Volume : ',...
                  'position',[215 10 60 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size2,...
                  'backgroundcolor','white','parent',database_manual_uipanel);
    
    % =+=+=+=+=+=+=+=+=  GUI button here =+=+=+=+=+=+=+=+=                                 
    check_update_button = uicontrol('style','pushbutton','string','Check Update','backgroundcolor',bg_color1,...
                  'position',[465 200 115 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'parent',check_update_uipanel);
    browse_button = uicontrol('style','pushbutton','string','Browse File','backgroundcolor',bg_color1,...
                  'position',[435 25 115 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'parent',database_update_uipanel);
    update_button1 = uicontrol('style','pushbutton','string','Update','backgroundcolor',bg_color1,...
                  'position',[565 25 115 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'parent',database_update_uipanel);
    update_button2 = uicontrol('style','pushbutton','string','Update','backgroundcolor',bg_color1,...
                  'position',[540 10 115 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'parent',database_manual_uipanel);
    clear_button = uicontrol('style','pushbutton','string','Clear','backgroundcolor',bg_color1,...
                  'position',[440 10 85 30],'horizontalalignment','center','fontname',font_type,'fontsize',font_size2,...
                  'parent',database_manual_uipanel);
              
    % =+=+=+=+=+=+=+=+=  GUI table here =+=+=+=+=+=+=+=+=
    table_info1 = uitable('position',[15 15 325 150],'parent',check_update_uipanel);
    table_info2 = uitable('position',[355 15 325 150],'parent',check_update_uipanel);
    
    % =+=+=+=+=+=+=+=+=  GUI textbox here =+=+=+=+=+=+=+=+=
    textbox1 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[15 25 400 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_update_uipanel);
    textbox2 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[110 80 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);
    textbox3 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[300 80 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);              
    textbox4 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[65 45 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);
    textbox5 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[265 45 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);
    textbox6 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[465 45 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);
    textbox7 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[65 10 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);
    textbox8 = uicontrol('style','edit','backgroundcolor',bg_color2,...
                  'position',[285 10 125 25],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1,...
                  'parent',database_manual_uipanel);
              
    % =+=+=+=+=+=+=+=+=  GUI component set enable first time here =+=+=+=+=+=+=+=+= 
    set(update_button1,'enable','off');
    set(check_update_button,'callback',{@check_set100_update,table_info1,table_info2,textbox1,update_button1,...
                                                           browse_button,check_update_button});
    set(browse_button,'callback',{@browsefile,textbox1,update_button1,browse_button,table_info1,table_info2});
    set(clear_button,'callback',{@clear_filled_textbox,textbox2,textbox3,textbox4,textbox5,textbox6,textbox7,...
                                              textbox8})
    set(update_button2,'callback',{@manual_update_set100_stock,textbox2,textbox3,textbox4,textbox5,textbox6,...
                                              textbox7,textbox8,table_info1,table_info2});
    
    % -o][------------------------------------------------------------------------][o-         
    %                       Check and Update SET100 stock database
    % -o][------------------------------------------------------------------------][o-   
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                     Function : Check SET100 Update
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function check_set100_update(hobject,eventdata,handles1,handles2,handles3,handles4,handles5,handles6)
        
        % Set check update button unable to work while checking database.
        set(handles6,'enable','off');
        
        % This function will check date in SET100 database and display result if 
        % some stock data date is different from the other.
        check_stock_database_ver_2(handles1,handles2);
        
        % Set check update button ready to work again.
        set(handles6,'enable','on');
        
    end
    
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                     Function : Browse File 
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-   
    function browsefile(hobject,eventdata,handles1,handles2,handles3,table_data1,table_data2)

        [filename dirpath] = uigetfile('*.txt','Please select text file...');
 
        % This condition will check conditon about text file.
        if isequal(filename,0) || isequal(dirpath,0)
            return;
        elseif (isempty(regexp(strcat(dirpath,filename),'.txt')))
            msgbox('Please choose txt file type only.','Warning !!!','warn');
            set(handles1,'enable','off');
            set(handles2,'enable','off');
        else
            filepath = strcat(dirpath,filename);
            set(handles1,'enable','on');
            set(handles2,'enable','on');
            set(handles1,'string',filepath);
            set(handles2,'callback',{@update_set100_stock,filepath,handles2,handles3,table_data1,table_data2});
        end    
    end
    
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                 Function : Update SET100 Stock 
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function update_set100_stock(hobject,eventdata,handles1,handles2,handles3,table_data1,table_data2)
        
        % Set update button unable to work while updating database.
        set(handles2,'enable','off');
        
        % This function will update SET100 stock database from .prn file that user selected.
        %update_stock_database_edit(handles1,handles4,handles5);
        update_stock_database_edit(handles1);
        
        % Change result in table for new information.
        check_stock_database_ver_2(table_data1,table_data2);
        
        % Set browse file on to choose new text file and unnable update button after finish update
        % database and until user choose new file for update database.
        set(handles3,'enable','on');
        set(handles2,'enable','off');
        
    end
    
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                             Function : Manual Update SET100 Stock 
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function manual_update_set100_stock(hobject,eventdata,handles1,handles2,handles3,handles4,handles5,handles6,handles7,handles8,handles9)
        
        % Daclare variable to collect status if all data complete and ready
        % to add to stock database.
        ready_add_check = 0;
        
        % Get data from all textbox.
        stock_name = upper(get(handles1,'string'));
        date_update = get(handles2,'string');
        open_price = get(handles3,'string');
        high_price = get(handles4,'string');
        low_price = get(handles5,'string');
        close_price = get(handles6,'string');
        stock_vol = get(handles7,'string');
        
        % Check correction of data before add new row of each stock to SET100 database.
        ready_add_check = check_filled_data(stock_name,date_update,open_price,high_price,low_price,close_price,stock_vol);
        
        if(ready_add_check == 1)
            % Add new row of each stock to SET100 database here.
            update_stock_database_manual(stock_name,date_update,open_price,high_price,low_price,close_price,stock_vol);
            
            % Change result in table for new information.
            check_stock_database_ver2(handles8,handles9);
        else
            msgbox('Maybe data you filled are not suitable, so please fill the data again. !!!','Warning !!!','warn');
        end
        
    end

    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    %                                 Function : Clear Filled Textbox
    % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
    function clear_filled_textbox(hobject,eventdata,handles1,handles2,handles3,handles4,handles5,handles6,handles7)
        % After click clear button all data in textbox will disappear.
        set(handles1,'string','');
        set(handles2,'string','');
        set(handles3,'string','');
        set(handles4,'string','');
        set(handles5,'string','');
        set(handles6,'string','');
        set(handles7,'string','');   
    end
    
    
%     % -o][------------------------------------------------------------------------][o-         
%     %                   Step III ::: Search SET100 Stock Information
%     % -o][------------------------------------------------------------------------][o-
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     %                                 Function : Search SET100 Stock
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     function search_set100_stock(hobject,eventdata,handles1,handles2,handles3,handles4,handles5,handles6,handles7,handles8,handles9)
%         % This function will select data of stock that user searched.
%         handles1 = get(handles1,'string');
%         [selected_stock,selected_name] = search_stock(handles1,handles2);
%         stock_data_selected = selected_stock;
%         
%         % If returned_data is null it's mean cannot find data from search keyword.
%         if(isempty(selected_stock))
%             msgbox('Cannot find stock data from search keyword.','Warning !!!','warn');
%         else
%             stock_status_str = ['The letest date of ' selected_name ' stock is ' selected_stock(end,2)];
%             stock_status_str = [stock_status_str{1} stock_status_str{2} stock_status_str{3} stock_status_str{4}];
%             
%             tag8 = uicontrol('style','text','string',stock_status_str,...
%                   'position',[320 375 325 20],'horizontalalignment','left','fontname',font_type,'fontsize',font_size1);
%               
%             % This function will show result in graph.
%             plot_graph(selected_stock,selected_name,handles3,handles4,handles5,handles6,handles7,handles8,handles9);
%         end
%     end
% 
%     % -o][------------------------------------------------------------------------][o-         
%     %             Step III ::: Plot graph of each variables that user selected.
%     % -o][------------------------------------------------------------------------][o-
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     %                                       Function : Plot Graph
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     function plot_graph(data,stock_name,graph,var_disp1,var_disp2,var_disp3,var_disp4,var_disp5,var_disp6)
%         
%         % Set display result part visible.
%         set(graph,'visible','on');
%         set(var_disp1,'visible','on');
%         set(var_disp2,'visible','on');
%         set(var_disp3,'visible','on');
%         set(var_disp4,'visible','on');
%         set(var_disp5,'visible','on');
%         set(var_disp6,'visible','on');
%         
%         % Prepare variable for candlestick.
%         open_price = cell2mat(data(:,3));
%         high_price = cell2mat(data(:,4));
%         low_price = cell2mat(data(:,5));
%         close_price = cell2mat(data(:,6));
%         stock_volume = cell2mat(data(:,7));
%         
%         % Variable name of data.
%         data_var_name = {'Open Price' 'High Price' 'Low Price' 'Close Price' 'Stock Volume'};
%         
%         % Candlestack will plot here.
%         candle(high_price,low_price,close_price,open_price,'red');
%         grid on;
%         graph_title = ['Graph show candlestick of ' stock_name];
%         title(graph_title);
%         xlabel('Data Point');
%         
%         set(var_disp1,'callback',{@plot_variable,open_price,stock_name,data_var_name{1}});
%         set(var_disp2,'callback',{@plot_variable,high_price,stock_name,data_var_name{2}});
%         set(var_disp3,'callback',{@plot_variable,low_price,stock_name,data_var_name{3}});
%         set(var_disp4,'callback',{@plot_variable,close_price,stock_name,data_var_name{4}});
%         set(var_disp5,'callback',{@plot_variable,stock_volume,stock_name,data_var_name{5}});
%         set(var_disp6,'callback',{@plot_candlestick,high_price,low_price,close_price,open_price,stock_name});
%         
%     end
%    
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     %                                       Function : Plot Variable
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     function plot_variable(hobject,eventdata,data,stock_name,title_var)
%         % Clear old graph.
%         cla reset
%         
%         % Create string for graph title.
%         str_title = ['Graph show ' title_var ' of ' stock_name];
%         
%         % Plot other variable of stock data here.
%         plot(data,'- red');
%         grid on;
%         title(str_title);
%         xlabel('Data Point');
%         ylabel(title_var);
%     end
% 
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     %                                       Function : Plot Candlestick
%     % -o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-+-o-
%     function plot_candlestick(hobject,eventdata,h_price,l_price,c_price,o_price,stock_name)
%         % Clear old graph.
%         cla reset
%         
%         % Create string for graph title.
%         str_title = ['Graph show candlestick of ' stock_name];
%         
%         % Candlestack will plot here.
%         candle(h_price,l_price,c_price,o_price,'red');
%         grid on;
%         title(str_title);
%         xlabel('Data Point');
%     end
% 
end





