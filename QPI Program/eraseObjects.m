%Funcion para borrar el objeto, "object" en el la grafica Axes.
%Input: Nombre del Axes, Nombre del objeto (string)
%Ejemplo: eraseObjects(Axes1, 'rectangle')
%Borrará todos los objetos rectangles del Axes "Axes1"

function eraseObjects(ax, object)
           for i = 1:length(ax.Children)
                   
                if strcmp(ax.Children(i).Type,object)
                    delete(ax.Children(i))
                    break
                end
                if i == length(ax.Children)
                    break
                end
            end
