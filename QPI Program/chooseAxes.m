%Funcion que te dice en que Axes tienes el puntero
function [Ax, In] = chooseAxes(Fig)

Array = findobj(Fig, 'Type', 'Axes'); %Busca todos los Axes en Fig
Norm       = Fig.Position;            %Posicion de la figura
Norm       = [Norm(3), Norm(4)];       %Me quedo con el tamaño
Ax =0;
In =0;

for i = 1:length(Array)               %Bucle por todos los Axes encontrados en Array
   
    Array(i).Units = 'pixels';    %Cambio las uniddaes a normalizadas
    Mouse = Array(i).CurrentPoint;         %Posicion actual del raton
    Mouse = Mouse(1, 1:2);
                  %Pongo posicion normalizada del raton
    Limites = [Array(i).XLim Array(i).YLim];
             %Se comprueba si se esta dentro del
                                      %Axes
    if Mouse(1)>Limites(1) && Mouse(1)<= Limites(2)%Condicion de posicion del raton en X
        if Mouse(2)>Limites(3) && Mouse(2)<= Limites(4)%Condicion de posicion del raton en Y
           Ax = Array(i);
           In = 1;
           
          % disp('Si!');
         
           break                    %Se sale porque no se necesita seguir buscando
        else
            Ax = 0;
            In = 0;
        end
    end
     Array(i).Units = 'normalized';
end

           