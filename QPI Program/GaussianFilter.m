function [CellFiltered] = GaussianFilter(Cell, Sigma, Info)

Columnas = length(Info.DistanciaFourierColumnas)
Filas    = length(Info.DistanciaFourierFilas)
    size(Cell{1})
    x0 = floor(Columnas/2)+1;
    y0 = floor(Filas/2)+1;
    x = (1:1:Columnas)';
        y = (1:1:Filas)';
    GaussianFilter = ones(Filas,Columnas);

    for i = 1:length(x)
        GaussianFilter(:,i) = exp(-((x(i)-x0)/(sqrt(2)*Sigma)).^2)*exp(-((y-x0)/(sqrt(2)*Sigma)).^2); 
    end
    MatrizFiltroFFT1 = 1-GaussianFilter;
    for i=1:length(Info.Energia)
        CellFiltered{i} = Cell{i}.*MatrizFiltroFFT1;
    end
    