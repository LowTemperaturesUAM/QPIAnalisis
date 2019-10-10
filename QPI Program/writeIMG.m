%Guarda una imagen de Matlab como .img.

%Copia la cabecera de la imagen de topo 
%original y sobreescribre la imagen a guardar.

%Entrada: lineas y columnas por ser general
%         la imagen de Matlab K
%         Topo original
%         Archivo que sale el nuevo .img

function writeIMG(Lineas,Columnas,Imagen, ReadFilePath, SaveFilePath)
    
%   Es necesario rotar la imagen porque luego se gira 
%   al verlo en imgviewer.
    Imagen = imrotate(Imagen, -90);
    
%   Copio la topo original en un nuevo archivo.
    copyfile(ReadFilePath, SaveFilePath);
%   Abro el nuevo archivo, pongo el inicio despues
%   de la cabecera y pego la nueva imagen hecha vector
%   y pasada a clase "single", y cierro el archivo.
    fID = fopen(SaveFilePath,'r+');
          fseek(fID,1032,'bof');
          ImagenSingle = im2single(Imagen);
          fwrite(fID, reshape(ImagenSingle, Lineas*Columnas,1), 'single');
          fclose(fID);