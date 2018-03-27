% ----------------------------------------
%   SIMETRIZAR TRANSFORMADAS DE FOURIER
% ----------------------------------------
% Antón - 21/04-2016
% ----------------------------------------
%
% DESCRIPCIÓN:
% ------------------------------
% Simetrización de la 2D-FFT con respecto a un eje que se introduce a mano.
% La simetrización se hace con un promedio de las líneas con respecto a ese
% eje. La función devuelve una matriz orientada del mismo modo que la
% original.
%
% ENTRADAS:
% ------------------------------
% TransformadasEqualizados: CellArray creado con el escript de análisis que
%                           contiene las 2D-FFT que queremos simetrizar.
%
% IndiceMapaInicial:    Índice del mapa en el cual se quiere seleccionar
%                       el eje de simetría dentro del cellArray '{k}'
%
% TamanhoX: Tamaño en nm de la imagen en la dirección X
%
% TamanhoY: Tamaño en nm de la imagen en la dirección Y
% ------------------------------
%
% Nota: Los tamaños se encuentran duplicados para facilitar el análisis de
% imágenes de distintos tamaños y puntos en X e Y sin tener que reescribir
% todo el código.
%
% SALIDA:
% ------------------------------
% TransformadasSimetrizadas:    Contiene las matrices simetrizadas en el
%                               eje seleccionado y orientadas del mimo modo
%                               que las originales. Conservan también su
%                               tamaño en pixeles para simplificar el
%                               tratamiento en posteriores funciones pese a
%                               que las zonas de los bordes generadas con
%                               las distintas rotaciones no tienen sentido.
%

function [TransformadasSimetrizadas] = simetrizarFFT_Automatico(TransformadasEqualizados,Angulo)

% Creamos el cellArray de salida que contendrá las matrices simetrizadas y
% que por conveniencia tendrán el mismo tamaño que las originales aunque
% los puntos estén interpolados.
% Los vectores Tamanho hacen falta para pasar de distancia a píxeles

    [NumeroMapas, NumeroMapas, Columnas] = size(TransformadasEqualizados);

    
    TransformadasSimetrizadasAUX = TransformadasEqualizados;  

%   Control sobre el valor del ángulo

%         if Angulo == 90
%             Angulo = Angulo + 0.001*rand;
%         elseif Angulo == 180
%             Angulo = Angulo + 0.001*rand;
%         else
%         end
        
% Rotamos todas las transformadas {IndiceMapa} el ángulos correspondiente. Siempre
% colocando el punto seleccionado sobre OX+

	for IndiceMapa = 1:NumeroMapas  
        
        MatrizRotadaZoom = TransformadasSimetrizadasAUX{IndiceMapa};
        MatrizRotadaZoom = imrotate(MatrizRotadaZoom, Angulo, 'crop');
        
        
        
%           SIMETRIA HERMANN
%   Concentra todo en un cuadrante y replica
% ---------------------------------------------     
%         XCentro = Columnas/2;
%         YCentro = Filas/2;
%         for i = 1:Columnas/2
%             for j = 1:Filas/2
%                 MatrizSymetrizada(XCentro+j,YCentro+i) = (1/4)*(MatrizRotadaZoom(XCentro+j,YCentro+i) +MatrizRotadaZoom(XCentro-(j-1),YCentro+i)+MatrizRotadaZoom(XCentro-(j-1),YCentro-(i-1))+MatrizRotadaZoom(XCentro+j,YCentro-(i-1)));
%                 MatrizSymetrizada(XCentro-(j-1),YCentro+i) = MatrizSymetrizada(XCentro+j,YCentro+i);
%                 MatrizSymetrizada(XCentro-(j-1),YCentro-(i-1)) = MatrizSymetrizada(XCentro+j,YCentro+i);
%                 MatrizSymetrizada(XCentro+j,YCentro-(i-1)) = MatrizSymetrizada(XCentro+j,YCentro+i);
%             end
%         end
% ---------------------------------------------        
% ---------------------------------------------
%           SIMETRIA ESPEJANDO
%   Espeja en ejes perpendiculares
% ---------------------------------------------      
%         for i = 1:Columnas/2
%             MatrizSymetrizada(i,:) = (1/2)*( MatrizRotadaZoom(i,:) + MatrizRotadaZoom(Columnas-(i-1),:));
%             MatrizSymetrizada(Columnas-(i-1),:) = MatrizSymetrizada(i,:);
%         end
% ---------------------------------------------
%               SIMETRÍA C4
%   Roto la matriz 4 veces y hago el promedio de las 4
% ---------------------------------------------        
        M1 = imrotate(MatrizRotadaZoom,90, 'crop');
        M2 = imrotate(MatrizRotadaZoom,180, 'crop');
        M3 = imrotate(MatrizRotadaZoom,270, 'crop');
        M4 = fliplr( MatrizRotadaZoom);
    
        M5 = imrotate( M4, 90, 'crop');
        M6 = imrotate( M4,180, 'crop');
        M7 = imrotate(M4, 270,'crop');
       
        
            MatrizSymetrizada = (MatrizRotadaZoom+M1+...
                        M2+M3+ M4+M5+...
                        M6+M7)/8;
        
% ---------------------------------------------

%   Invertimos la matriz antes de sacarla para ponerla en la orientación
%   inicial y hacemos un zoom para conservar el número de puntos.

%         MatrizRotadaInversa = imrotate(MatrizSymetrizada,-Angulo);
%         MatrizSalida = MatrizRotadaInversa(CentroY-Columnas/2+1:CentroY+Columnas/2,CentroX-Columnas/2+1:CentroX+Columnas/2);
        TransformadasSimetrizadasAUX{IndiceMapa} = MatrizSymetrizada;
        
	end
    
% Asignamos el valor al CellArray de la salida
   
    TransformadasSimetrizadas = TransformadasSimetrizadasAUX;

end