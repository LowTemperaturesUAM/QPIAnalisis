function [curva] = meanConductance(Info)
Filas = length(Info.DistanciaFilas);
Columnas = length(Info.DistanciaColumnas);
PuntosIV = length(Info.Voltaje);
curva = zeros(PuntosIV,2);
curvaCorriente = zeros(PuntosIV,2);
curva(:,1) = Info.Voltaje;
curvaCorriente(:,1) = Info.Voltaje;
for k=1:PuntosIV
    Matriz3D(:,:,k) = reshape(Info.MatrizNormalizada(k,:),Filas,Columnas);
    Matriz3DCorriente(:,:,k) = reshape(Info.MatrizCorriente(k,:),Filas,Columnas);
%     Matriz3D(:,:,k) = Matriz3D(:,:,k)';
%     Matriz3DRecortada(:,:,k) = Matriz3D(248:503,108:363,k);
%     MatrizNormalizadaRecortada (k,:) = reshape(Matriz3DRecortada(:,:,k),1,length(Matriz3DRecortada)^2);
    curva(k,2) = mean(mean(Matriz3D(:,:,k)));
    curvaCorriente(k,2) = mean(mean(Matriz3DCorriente(:,:,k)));
end

curva = curva*1e3;%para que esté en [nS]

%Plot current
figure (8983)
plot(Info.Voltaje,curvaCorriente(:,2))
% maximo = abs(Info.Energia(1));
% plotPoints = ceil(maximo*PuntosIV/Info.Bias);
% plot(Info.Voltaje(Info.PuntosIV/2-round(plotPoints/2):Info.PuntosIV/2+round(plotPoints/2)),...
%     curva(Info.PuntosIV/2-round(plotPoints/2):Info.PuntosIV/2+round(plotPoints/2)));

a=gca;
% a.XLim = [-95 95];
a.Children.LineWidth = 2;
a.Children.Color = [0 0 0];
a.FontWeight = 'bold';
a.LineWidth = 2;
a.XColor = [0 0 0];
a.YColor = [0 0 0];
a.XLabel.String = 'Energy (meV)';
a.YLabel.String = 'Intensity (nA)';

%Plot conductance
figure (8984)
plot(Info.Voltaje(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada)...
    ,curva(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada,2))
maximo = abs(Info.Energia(1));
% plotPoints = ceil(maximo*PuntosIV/Info.Bias);
% plot(Info.Voltaje(Info.PuntosIV/2-round(plotPoints/2):Info.PuntosIV/2+round(plotPoints/2)),...
%     curva(Info.PuntosIV/2-round(plotPoints/2):Info.PuntosIV/2+round(plotPoints/2)));

b=gca;
% a.XLim = [-95 95];
b.Children.LineWidth = 2;
b.Children.Color = [0 0 0];
b.FontWeight = 'bold';
b.LineWidth = 2;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.XLabel.String = 'Energy (meV)';
b.YLabel.String = 'Conductance (nS)';
end