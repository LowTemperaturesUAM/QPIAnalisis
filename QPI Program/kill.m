function kill
a = gcf;

Fig2Close = a.Name;

    axe = findobj('Name', 'mainFig');
    if ishghandle(axe)
        axe = axe.Children;
        num = length(axe.Children);
                j=0;
                for i=1:num
                     if strcmp(axe.Children(i).Tag,Fig2Close)
                         j = j+1;
                        borra(j) = i;
                     end         
                end
                    delete(axe.Children(borra))
        axe.ColorOrderIndex = 1;
                    delete(a)
    else
        delete(a)
    end

end
        