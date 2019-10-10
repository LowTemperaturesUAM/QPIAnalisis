function Topo = openIMG(lineas,columnas, filePath)
    %Abrimos la imagen
    fID = fopen(filePath,'r');
    %Los datos estan guardados en single (4 bytes) y como sabemos que tenemos
    %un numero de lineas (size) desde el final del archivo nos movemos
    % -(numero de puntos totales)*(4 bytes por punto)
          fseek(fID,1032,'bof');
    %Leemos los datos hacia abajo desde el punto que hemos dicho que se mueva
    %en formato 'single'
    DataIda = fread(fID,'single');

    fclose(fID);
  
    %Pasamos a modo matriz la imagen y normalizamos para que los valores vayan
    %de 0 a 1. 
    Topo = reshape(DataIda, lineas,columnas);
    %Topo = (Topo - min(min(Topo)));
    %Topo = (Topo )/max(max(Topo));

    %Se tiene que rotar y listo
    Topo       = imrotate(Topo,90);
    MediaTopoX = mean(Topo, 1);
    MediaTopoY = mean(Topo,2) ;

%   QUITAMOS EL PLANO
   
    %Derivamos la media del planoX y la media del planoY, y sacamos la
    %media de ese valor. Eso sera la pendiente X e Y.
    tiltX      = (diff(MediaTopoX));
    tiltY      = (diff(MediaTopoY));
    tiltX = mean(tiltX);
    tiltY = mean(tiltY);
    
    %Después creamos un plano a partir de ambas rectas, repitiendo el
    %vector y sumamos las dos componentes.
    planeX    = tiltX.*(1:lineas);
    planeY    = tiltY.*(1:columnas);
    planeY    = planeY';
    planeX    = repmat(planeX, lineas, 1);
    planeY    = repmat(planeY, 1, columnas);
    plane     = planeX + planeY;
    Topo = Topo - plane;
    
    
%   PUNTOS DE ERROR
    %Hacemos la media de la imagen entera y sacamos la desviacion tipica de
    %los puntos, creamos una mascara para los puntos que superen un tope de
    %veces la desviacion tipica le ponemos ese valor.
    meanTopo  = mean(mean(Topo));
    stdTopo   = std(std(Topo));
    tope      = 6;
    MascaraTopoMax = (Topo > meanTopo + tope*stdTopo) ;
    MascaraTopoMin = (Topo < meanTopo - tope*stdTopo);
    Topo =  (meanTopo + 7*stdTopo)*(MascaraTopoMax) ...
            + (meanTopo - 7*stdTopo)*(MascaraTopoMin)... 
            +Topo.*(~(MascaraTopoMax +MascaraTopoMin));
        
%   REAJUSTE
    %Se reajusta para que esten todos los valores entre 0 y 1
   Topo = (Topo - min(min(Topo)));
   % Topo = (Topo )/max(max(Topo));
    Topo  = Topo*1E9;
    
  
  