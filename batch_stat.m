function [outputArg1,outputArg2] = batch_stat(a)

% a is selectedTab object

% creat new obj
% b = SetVar;
test.alias = {'A','B'};
test.text = {'mean(x)','mean(y)'};
b = SetVar(test);
ff = showVar(b);

% set figure name by Tab title
ff.Name = 'User-defined Variable';

% create a working structor by a.data
objbeam = a.data;

no = 1;

% assign function callback to object in class

% add callback for add item
ff.findobj('Tag','uimenu_add_var').Callback = @addVar;
ff.findobj('Tag','uimenu_goplot').Callback = {@goPlot,objbeam};

% add callback for edit item
set(ff.findobj('Type','UIControl','style','pushbutton'),'Callback',{@editVar});

% remove item

    function addVar(hObject,evendata,handles)
        c = b.addVar;
        handles = guihandles(c);
        c.findobj('Tag','txt_var_apply').Callback = {@ApplyVar,c};
    end

    function ApplyVar(hObject,evendata,handles)
        new.alias = handles.findobj('Tag','txt_var_alias').String;
        new.text = handles.findobj('Tag','txt_var_text').String;
        
        % append data
        b = SetVar(b,new);
        
        % close Apply figure
        close(handles);
        
        % update GUIShowVar
        ff = showVar(b,ff);
        set(ff.findobj('Type','UIControl','style','pushbutton'),'Callback',{@editVar});
    end

    function editVar(hObject,evendata,handles)
        edit_no = hObject.UserData;
        c = b.addVar(edit_no);
        
        % apply
        c.findobj('Tag','txt_var_apply').Callback = {@EditVar,c,edit_no};
        
        % delete
        c.findobj('Tag','txt_var_delete').Callback = {@DeleteVar,c,edit_no};
        
    end

    function EditVar(hObject,evendata,handles,edit_no)
        new.alias = handles.findobj('Tag','txt_var_alias').String;
        new.text = handles.findobj('Tag','txt_var_text').String;
        
        % edit data
        b = SetVar(b,new,edit_no);
        
        % close Apply figure
        close(handles);
        
        % update GUIShowVar
        ff = showVar(b,ff);
        set(ff.findobj('Type','UIControl','style','pushbutton'),'Callback',{@editVar});
    end


    function DeleteVar(hObject,evendata,handles,edit_no)
        qb =questdlg('Are you sure','Delete!','No','Yes','No');
        switch qb
            case 'Yes'
                b = deleteVar(b,edit_no);
            case 'No'
        end
        % close Apply figure
        close(handles);
        
        % update GUIShowVar
        ff = showVar(b,ff);
        set(ff.findobj('Type','UIControl','style','pushbutton'),'Callback',{@editVar});
        
    end


    function goPlot(hObject,evendata,objbeam)
        a
        vis_plot(a,b);
    end

end