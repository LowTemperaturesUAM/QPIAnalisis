function [CellOut, InfoOut] = adjustZero(CellC, Info)

InfoOut = Info;
CellOut = CellC;
for i = 1: length(Info.Energia)
CellOutM = zeros(length(Info.DistanciaFourierColumnas)+1, length(Info.DistanciaFourierFilas)+1);

Cell = CellC{i};



%%%First Quadrant
CellOutM(1:length(Info.DistanciaFourierColumnas)/2,1:length(Info.DistanciaFourierFilas)/2) = ...
        Cell(1:length(Info.DistanciaFourierColumnas)/2,1:length(Info.DistanciaFourierFilas)/2);
  
%%%%Fourth Quadrant
CellOutM(length(Info.DistanciaFourierColumnas)/2 +2:end,length(Info.DistanciaFourierFilas)/2 +2:end) = ...
        Cell(length(Info.DistanciaFourierColumnas)/2+1:end,length(Info.DistanciaFourierFilas)/2+1:end);
    
%%%%Second Quadrant    
CellOutM(length(Info.DistanciaFourierColumnas)/2 +2:end,1:length(Info.DistanciaFourierFilas)/2) = ...
        Cell(length(Info.DistanciaFourierColumnas)/2+1:end,1:length(Info.DistanciaFourierFilas)/2);
    
 %%%%Third Quadrant      
 CellOutM(1:length(Info.DistanciaFourierColumnas)/2,length(Info.DistanciaFourierFilas)/2 +2:end) = ...
        Cell(1:length(Info.DistanciaFourierColumnas)/2,length(Info.DistanciaFourierFilas)/2+1:end);
    
 

 

 CellOutM(1:length(Info.DistanciaFourierColumnas)/2, length(Info.DistanciaFourierFilas)/2+1)= ...
     mean(Cell(1:length(Info.DistanciaFourierColumnas)/2, length(Info.DistanciaFourierFilas)/2:...
         length(Info.DistanciaFourierFilas)/2+1),2);
     
  CellOutM(length(Info.DistanciaFourierColumnas)/2+2:end, length(Info.DistanciaFourierFilas)/2+1)= ...
     mean(Cell(length(Info.DistanciaFourierColumnas)/2+1:end, length(Info.DistanciaFourierFilas)/2:...
         length(Info.DistanciaFourierFilas)/2+1),2);
     
CellOutM(length(Info.DistanciaFourierColumnas)/2+1, 1:length(Info.DistanciaFourierFilas)/2)= ...
     mean(Cell(length(Info.DistanciaFourierColumnas)/2:length(Info.DistanciaFourierFilas)/2+1,...
    1:length(Info.DistanciaFourierFilas)/2));        
     
CellOutM(length(Info.DistanciaFourierColumnas)/2+1, length(Info.DistanciaFourierFilas)/2+2:end)= ...
     mean(Cell(length(Info.DistanciaFourierColumnas)/2:length(Info.DistanciaFourierFilas)/2+1,...
    length(Info.DistanciaFourierFilas)/2+1:end));

CellOutM(length(Info.DistanciaFourierColumnas)/2+1, length(Info.DistanciaFourierFilas)/2+1)= ...
    mean([CellOutM(length(Info.DistanciaFourierColumnas)/2+1, length(Info.DistanciaFourierFilas)/2)...         
        CellOutM(length(Info.DistanciaFourierColumnas)/2, length(Info.DistanciaFourierFilas)/2+1)...
        CellOutM(length(Info.DistanciaFourierColumnas)/2+1, length(Info.DistanciaFourierFilas)/2+2)...
        CellOutM(length(Info.DistanciaFourierColumnas)/2+2, length(Info.DistanciaFourierFilas)/2+1)]);
    
    CellOut{i} = CellOutM;

end      
    
    InfoOut.DistanciaFourierColumnas = [Info.DistanciaFourierColumnas abs(Info.DistanciaFourierColumnas(1))];
    InfoOut.DistanciaFourierFilas = [Info.DistanciaFourierFilas abs(Info.DistanciaFourierFilas(1))];  