function [CellRotated] = RotateMatrix(Cell, Angle, Info)

Columnas = length(Info.DistanciaFourierColumnas);
Filas    = length(Info.DistanciaFourierFilas);

CellRotated = Cell;

for k=1:length(Info.Energia)
    TransformadasRotadaAUX = imrotate(Cell{k},Angle); 
        [FilasMatrizRotada, ColumnasMatrizRotada] = size(TransformadasRotadaAUX);
        CentroX = floor(ColumnasMatrizRotada/2);
        CentroY = floor(FilasMatrizRotada/2);
    MatrizRotadaZoom = TransformadasRotadaAUX(CentroY-Filas/2+1:CentroY+Filas/2,CentroX-Columnas/2+1:CentroX+Columnas/2);
        CellRotated{k} = MatrizRotadaZoom;
        
        clear TransformadasRotadaAUX MatrizRotadaZoom ;
        clear CentroX CentroY FilasMatrizRotada ColumnasMatrizRotada;
end