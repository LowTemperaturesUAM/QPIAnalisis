function [InfoStruct] = RecorteQPI(x1,x2,y1,y2,Info)
for k=1:length(Info.Energia)
    Mapas1{k} = Info.MapasConductancia{k}(x1:x2,y1:y2);
    Transformadas1{k} = fft2d(Mapas1{k});
end

InfoStruct1 = Info;
InfoStruct1.MapasConductancia = Mapas1;
InfoStruct1.Transformadas = Transformadas1;

InfoStruct1.TamanhoRealColumnas = Info.TamanhoRealColumnas*...
    length(InfoStruct1.MapasConductancia{1})/length(Info.MapasConductancia{1});
InfoStruct1.TamanhoRealFilas = Info.TamanhoRealFilas*...
    length(InfoStruct1.MapasConductancia{1})/length(Info.MapasConductancia{1});

Filas = length(Info.DistanciaFilas);
Columnas = length(Info.DistanciaColumnas);

TamanhoPixelFilas = InfoStruct1.TamanhoRealFilas/Filas;
TamanhoPixelColumnas = InfoStruct1.TamanhoRealColumnas/Columnas;

Filas = length(Mapas1{1});
Columnas = Filas;

InfoStruct1.DistanciaColumnas = TamanhoPixelColumnas*(1:1:Columnas);
InfoStruct1.DistanciaFilas = TamanhoPixelFilas*(1:1:Filas);
    
InfoStruct1.DistanciaFourierColumnas = (1/InfoStruct1.TamanhoRealColumnas)*(1:1:Columnas);
InfoStruct1.DistanciaFourierFilas = (1/InfoStruct1.TamanhoRealFilas)*(1:1:Filas);

% Centering reciprocal space units
% ------------------------------------------------------------------------
	InfoStruct1.DistanciaFourierColumnas = InfoStruct1.DistanciaFourierColumnas - InfoStruct1.DistanciaFourierColumnas(floor(Columnas/2)+1); 
    InfoStruct1.DistanciaFourierFilas = InfoStruct1.DistanciaFourierFilas - InfoStruct1.DistanciaFourierFilas(floor(Filas/2)+1);
%-------------------------------------------------------------------------

Filas = length(Info.DistanciaFilas);
Columnas = length(Info.DistanciaColumnas);
PuntosIV = length(Info.Voltaje);

for k=1:PuntosIV
    Matriz3D(:,:,k) = reshape(Info.MatrizNormalizada(k,:),Filas,Columnas);
%     Matriz3D(:,:,k) = Matriz3D(:,:,k)';
    Matriz3DRecortada(:,:,k) = Matriz3D(y1:y2,x1:x2,k);
    MatrizNormalizadaRecortada (k,:) = reshape(Matriz3DRecortada(:,:,k),1,length(Matriz3DRecortada)^2);
end
length(MatrizNormalizadaRecortada)
InfoStruct1.MatrizNormalizada = MatrizNormalizadaRecortada;
InfoStruct = InfoStruct1;
end