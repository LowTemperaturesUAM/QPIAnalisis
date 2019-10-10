%LineasPromedio = 3;
LongitudPerfil = length(InfoStruct.DistanciaFilas)+1; %Poner ese +1 sólo si se ha ajustado el (0,0) previamente en QPIStudy.m


Perfiles = zeros(length(InfoStruct.Energia),LongitudPerfil);
%Perfiles2 = zeros(length(Energia),LongitudPerfil);

for k=1:length(InfoStruct.Energia)
    Perfiles(k,:) = TransformadasAnalisis{k}(:,length(InfoStruct.DistanciaFilas)/2+1);
    %Perfiles2(k,:) = TransformadasSimetrizadas{k}(:,1+Filas/2);
    %Perfiles(k,1:LongitudPerfil-1)= diff(Perfiles(k,:));
end

% mediaTotal = mean(mean(Perfiles));
% FlattenMatrix=Perfiles;
% for i = 1:length(Perfiles(:,1))
%                FlattenMatrix(:,i) = FlattenMatrix(:,i) - (mean(FlattenMatrix(:,i)) - mediaTotal);
% end
% PerfilesPromedio = (Perfiles + Perfiles2)/2;
% PerfilesFlatten=Flatten(Perfiles,[1,1]);

a=figure;
%surf((ParametroRed/TamanhoReal)*(1:LongitudPerfil-1),Energia,Perfiles(:,1:LongitudPerfil-1))
imagesc(InfoStruct.DistanciaFourierFilas*2*InfoStruct.ParametroRedFilas,InfoStruct.Energia,Perfiles);
%axis([0 1 min(InfoStruct.Energia) max(InfoStruct.Energia)]);
axis([0 1 -85 85]);
b=gca;
b.Colormap = parula;
b.YDir='normal';
b.YLabel.String = '\fontsize{15} Energy (meV)';
b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
b.LineWidth = 2;
b.FontWeight = 'bold';
% b.Position = b.OuterPosition;
b.CLim=[0 0.15];
%b.CLim=[min(min(Perfiles)) max(max(Perfiles))];
%colormap gray