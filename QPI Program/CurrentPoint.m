%Funcion para colocar en WindowsMotionButton de la figure del GUI

%Esta funcion esta SIEMPRE activa. Pero solo es funcional cuando mantienes
%pulsado un boton del raton y te desplazas.

%Si pulsas el boton normal, te dibuja un cuadrado dinamico y guardando por
%donde vas yendo para despues cuando sueltes el boton te haga zoom.

%Si pulsas el central o haces shift+normal, te desplazas por la pantalla

%Se le pueden meter mas entradas para distintos tipos de click


function CurrentPoint(~,~)


fig = gcf; 
       if ~isfield(fig.UserData, 'Pressing')                                            %Guarda el primer XLim e YLim para tenerlo siempre porque 
%      ax.UserData.XLimO = ax.XLim;                                             %en el mmomento en que entra se crea el UserData.XLim y 
%      ax.UserData.YLimO = ax.YLim;                                             %no se puede volver a entrar hasta que se cierra el programa
       fig.UserData.Pressing     = 0;
%   
%   
    
       end%Detecto al figura o GUI
[ax, In] = chooseAxes(fig);                                                 %Detecto en que Axes esta segun el puntero                                                      
if In
ultimoClick = fig.SelectionType;                                            %Guardo el boton con el que se ha pulsado
 
if fig.UserData.Pressing                                                   % Esto es cuando esta activado el boton
    %disp('Pressing')
    ax.UserData = ax.UserData;                                             %No hace nada peor me da miedo quitarlo
    Puntos = ax.CurrentPoint;
    %disp('pulsando')
    if ultimoClick(1) == 'n'                                                %Si el ultimo click ha sido con el Izquierdo entramos
        %disp('Izquierdo');
       %ax= gca; 
       %disp('n')
       Size = -(ax.UserData.Origin(1) - Puntos(1,1));                       %Tamaño X dinamico segun la posicion original y la posicion actual del raton 
       Size2 = -(ax.UserData.Origin(2) - Puntos(1,2));                      %Tamaño Y dinamico segun la posicion original y la posicion actual del raton 
      
       ax.UserData.XLimC = [min( [ax.UserData.Origin(1), ax.UserData.Origin(1) + Size]), max( [ax.UserData.Origin(1), ax.UserData.Origin(1) + Size])];
       ax.UserData.YLimC =  [min([ax.UserData.Origin(2), ax.UserData.Origin(2) + Size2]), max([ax.UserData.Origin(2), ax.UserData.Origin(2) + Size2])];
                                                                         %Voy guardando un XLimC(urrent) e YLimC(urrent) mientras siga pulsando
       eraseObjects(ax, 'rectangle') ;      
       rect = drawRectangle(ax.UserData.Origin(1),ax.UserData.Origin(2), Size,  Size2) ;    %Creo y borro cuadrados
        ax.UserData.Rectangle =[rect.Position];
    end
    
    if ultimoClick(1) == 'e'                                                 %Si has pulsado el boton central ('extend') entra
       ax.XLim =  ax.XLim -  (Puntos(1,1) -ax.UserData.Origin(1));           %Cambio el XLim e YLim por como muevo el raton para desplazarme
       ax.YLim =  ax.YLim - (Puntos(1,2) - ax.UserData.Origin(2));           %por la pantalla
       ax.UserData.XLimC =  ax.XLim ;                                        %Y guardo en el XLimC e YLimC las ultimas XLim e YLim.   
       ax.UserData.YLimC =  ax.YLim ;
       %disp('Derecho');
    end
    
        if ultimoClick(1) == 'a'                                                %Si el ultimo click ha sido con el Izquierdo entramos
        %disp('Izquierdo');
       %ax= gca; 
       %disp('n')
       Size = -(ax.UserData.Origin(1) - Puntos(1,1));                       %Tamaño X dinamico segun la posicion original y la posicion actual del raton 
       Size2 = -(ax.UserData.Origin(2) - Puntos(1,2));                      %Tamaño Y dinamico segun la posicion original y la posicion actual del raton 
      
       ax.UserData.XLimC = [min( [ax.UserData.Origin(1), ax.UserData.Origin(1) + Size]), max( [ax.UserData.Origin(1), ax.UserData.Origin(1) + Size])];
       ax.UserData.YLimC =  [min([ax.UserData.Origin(2), ax.UserData.Origin(2) + Size2]), max([ax.UserData.Origin(2), ax.UserData.Origin(2) + Size2])];
                                                                         %Voy guardando un XLimC(urrent) e YLimC(urrent) mientras siga pulsando
       eraseObjects(ax, 'rectangle') ;      
       rect = drawRectangle(ax.UserData.Origin(1),ax.UserData.Origin(2), Size,  Size2);     %Creo y borro cuadrados
        ax.UserData.Rectangle =[rect.Position];
    end
    
    
end
else


end

end
