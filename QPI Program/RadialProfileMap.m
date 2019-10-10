function RadialProfileMap(Info,Transformadas)
N = size(Transformadas{1});
Mapa = zeros(length(Info.Energia),floor(N(1)/2));

TamanhoReal = [N(1)+1, N(1)+1]; %+1 si Adjust(0,0) previamente
Center = floor(TamanhoReal/2)+1;
for k=1:length(Info.Energia)
    [A,~] = RadialProfilev2(TamanhoReal, Center, Transformadas{k}, TamanhoReal(1), Center(1)-1);
    Mapa(k,:) = A';
end

figure(45980);
imagesc(Info.DistanciaFourierFilas*2*Info.ParametroRedFilas,Info.Energia,Mapas);
%axis([0 1 min(InfoStruct.Energia) max(InfoStruct.Energia)]);
axis([0 1 Info.Energia(1) Info.Energia(end)]);
b=gca;
b.Colormap = parula;
b.YDir='normal';
b.YLabel.String = '\fontsize{15} Energy (meV)';
b.XLabel.String = '\fontsize{15} k_{rad}';
b.LineWidth = 2;
b.FontWeight = 'bold';
% b.Position = b.OuterPosition;
% b.CLim=[minimo maximo];
%b.CLim=[min(min(Perfiles)) max(max(Perfiles))]

end