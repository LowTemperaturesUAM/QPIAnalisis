function [Profile, Momentum] = MakeProfile(Cell, Info, angle, Width)

    NCell = length(Info.Energia);
    PuntosCol = length(Info.DistanciaFourierColumnas)
    PuntosFil = length(Info.DistanciaFourierFilas)
    Profile = zeros(NCell,PuntosFil);
    size(Profile)
    
       
      Momentum = Info.DistanciaFourierColumnas*cosd(angle) + Info.DistanciaFourierFilas*sind(angle);
    for i = 1:NCell
        CellRot = imrotate(Cell{i}, angle, 'crop');
        size(Cell{i})
        size(CellRot)
        figure(81)        
        round(PuntosFil/2)-Width:round(PuntosFil/2)+Width
        size(mean(CellRot(round(PuntosFil/2)-Width:round(PuntosFil/2)+Width,:),1))
        Profile(i,:) = mean(CellRot(round(PuntosFil/2)-Width:round(PuntosFil/2)+Width,:),1);
      
        
        
    end
        