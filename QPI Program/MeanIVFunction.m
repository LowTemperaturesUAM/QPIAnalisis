function MeanIVFunction(Rectangulo, MatrizNormalizada, Voltaje, Columnas, Filas, DistanciaColumnas,Info)
Rectangulo1 = [Rectangulo(1)-DistanciaColumnas(1) Rectangulo(2)-DistanciaColumnas(1) (Rectangulo(3)) (Rectangulo(4))];
Rectangulo1 = Columnas.*Rectangulo1./(DistanciaColumnas(end)- DistanciaColumnas(1) );
Inicio = [round(Rectangulo1(1)), round(Rectangulo1(2))];
Final = [Inicio(1) + round(Rectangulo1(3)), Inicio(2) + round(Rectangulo1(4))];

m = 0;
Coordenadas = 0;
for i = 1:Columnas
    for j = 1:Filas
        if i>=Inicio(1) && j>=Inicio(2) && i<=Final(1) && j<=Final(2)
            m = m+1;

            Coordenadas(m) = sub2ind([Columnas, Filas], i, j);
        end
    end
end
mean = 0;

if length(Coordenadas)>1

for i = 1:length(Coordenadas)
        mean = mean + MatrizNormalizada(:,Coordenadas(i))/length(Coordenadas);
end
%assignin('base','mean',[Voltaje, mean])
b=findobj('Name', 'mainFig');
meanIVFig = figure(23321);
meanIVFig.CloseRequestFcn = 'kill';
meanIVFig.Name = 'meanIVFig';

hold on
a=gca;
% a.ColorOrder = jet(50);
a.ColorOrderIndex = b.Children.ColorOrderIndex;
plot(Voltaje(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada), mean(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada),'-','LineWidth',2)

a.XLabel.String = 'Energy (meV)';
a.YLabel.String = 'Conductance (\muS)';
% a.Children.LineWidth = 2;
% a.Children.Color = [0 0 0];
a.FontWeight = 'bold';
a.LineWidth = 2;
a.FontSize = 10;
a.XColor = [0 0 0];
a.YColor = [0 0 0];
a.Box = 'on';
%plot(Voltaje(5:60),curva(5:60))
%ylim([0 , 2])

x1=Rectangulo(1);
y1=Rectangulo(2);
a1=Rectangulo(3);
b1=Rectangulo(4);

b=findobj('Name', 'mainFig');
hold(b.Children, 'on');

area = plot(b.Children,[x1 x1+a1 x1+a1 x1 x1], [y1 y1 y1+b1 y1+b1 y1],'LineWidth',2);

area.Tag = 'meanIVFig';
% rectangle('Position',Rectangulo,'EdgeColor','white')
end