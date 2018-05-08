function [CutCell, DistFourierColumnasCrop, DistFourierFilasCrop] = CropImage(cell,cut, DistanciaFourierColumnas, DistanciaFourierFilas)
CutCell{1} = 0;
%DistFourierColumnasCrop = nonzeros(DistanciaFourierColumnas(DistanciaFourierColumnas>=cut(1) & DistanciaFourierColumnas<=cut(2)));
%DistFourierFilasCrop    = nonzeros(DistanciaFourierFilas(DistanciaFourierFilas>cut(3) & DistanciaFourierFilas<=cut(4)));
rectY = round(length(DistanciaFourierColumnas)*[cut(1) cut(2)]./...
    (2*abs([DistanciaFourierColumnas(1) DistanciaFourierColumnas(end)])) +...
    length(DistanciaFourierColumnas)/2 );

rectX = round(length(DistanciaFourierFilas)*[cut(3) cut(4)]./...
    (2*abs([DistanciaFourierColumnas(1) DistanciaFourierColumnas(end)])) +...
    length(DistanciaFourierFilas)/2 );
rectX = round(255.*rectX./256 +1);
rectY = round(255.*rectY./256 +1);

for i = 1:size(cell,1)
    Map2Cut = cell{i};
    Map = Map2Cut(rectX(1):rectX(2), rectY(1):rectY(2));
    CutCell{i} = Map;
end
DistFourierColumnasCrop = DistanciaFourierColumnas(rectY(1):rectY(2));
DistFourierFilasCrop    = DistanciaFourierFilas(rectX(1):rectX(2));