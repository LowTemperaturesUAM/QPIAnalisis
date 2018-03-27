%Funcion para colocar en WindowsUpButton de la figure del GUI

%Cuando sueltas el boton del raton segun que boton haya estado pulsado te
%hace ciertas acciones

%Ademas te da una salida con el boton que se ha pulsado por ultima vez y
%si el raotn se ha movido o no desde que se clico hasta que se desclico, de
%esta manera se pueden colocar un funciones extra en el codigo a usar sin
%tener que cambair este
function [ax, Button, Movimiento] = Up(~, ~)


Fig = gcf;                                                                  %Llama a la figura o GUI
[ax, In] = chooseAxes(Fig); 

%Elige el eje donde esta el raton
%ax = Fig.UserData.Axes;


%Fig.UserData.Pressing                                                   
if ax~=0
Puntero = ax.CurrentPoint;                                                  %Guardo la posicion del puntero el soltar
Puntero = Puntero(1,1:2); 
Origin = ax.UserData.Origin;  

%Me quedo con el X e y
                                              %Me guardo la posicion donde se dio el primer click en Down
Comprobacion = (mean(Puntero - Origin)); 
%Esto es para saber si se ha movido algo o no.

if Comprobacion
 
eraseObjects(ax, 'rectangle');                                              %Borro el ultimo recuadro
end
ultimoClick = Fig.SelectionType;                                            %Guardo la info de que click se ha dado en el raton
      


switch ultimoClick                                                          % Segun que click distintas acciones
    case 'alt'    %Boton Derecho
                %[ax, In] = chooseAxes(Fig);
                if In
                 

                    ax.XLim = ax.UserData.XLimO;                             %Si das a boton derecho te recupera el XLim e YLim Original
                    ax.YLim = ax.UserData.YLimO;
                end
                if Comprobacion
                    Button = 'alt';
                    Movimiento = 1;
                else
                    Button = 'alt';
                    Movimiento = 0;
                end
                
            
    case 'normal' %Boton izquierdo                                          %Si das al boton normal y te has movido un poco te cambia el XLim e YLim al XLimC e YLimC
                if Comprobacion                                             % guardado dinamicamente en el Current
                    if ax.UserData.XLimC(2) > ax.UserData.XLimC(1) && ax.UserData.YLimC(2)> ax.UserData.YLimC(1) ...
                       
                    
                        ax.XLim = ax.UserData.XLimC;
                        ax.YLim = ax.UserData.YLimC;
                    end
                    Movimiento = 1;
                    Button = 'normal';
                else
                    %disp('No te moviste!');                                 %Si no te has movido puedes poner acciones extras
                    Movimiento = 0;
                    Button = 'normal';
                end
                
    case 'open'   %Doble Click                                               %Si se hace Doble Click    
                  disp('Double Click!') 
                  if Comprobacion
                      Movimiento = 1;
                      Button     = 'open';
                  else
                      Movimiento = 0;
                      Button     = 'open';
                  end
                  
                  
    case 'extend' %Central                                                  %Si se da al central
        if Comprobacion
                  ax.XLim = ax.UserData.XLimC ;
                  ax.YLim = ax.UserData.YLimC ;
                      Movimiento = 1;
                      Button     = 'extend';
        else
                      Movimiento = 0;
                      Button     = 'extend';
        end
        
end
else
 ax = 0;
 Button = 0;
 Movimiento =0;  
end
Fig.UserData.Pressing =0;                                                   %Y se vuelve a no pulsar

    