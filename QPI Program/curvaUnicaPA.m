

function [Voltaje, ConductanciaCurvaUnica] = curvaUnicaPA(puntero,ConductanceMap, Voltaje,MatrizNormalizada, VectorTamanhoX,VectorTamanhoY, flag)
%Programa que te printa las curvas elegidas con el puntero


Columnas = length(VectorTamanhoX);

% display(['VectorTamanhoY = ',num2str(VectorTamanhoY)]);
% display(['VectorTamanhoX = ',num2str(VectorTamanhoX)]);

hold on

%imagesc(vectorTamanho, vectorTamanho, conductanceMap)
%axis square
%colorbar

%src.conductanceMap = conductanceMap;
%src.matrizVoltaje = matrizVoltaje;
%src.matrizNormalizada = matrizNormalizada;
%size = 11.7; % tamaño en nm de la imagen (creo?)

 
 %[XinicioFinal,YinicioFinal] = puntosRaton(); %LLama a la funcion con la que se escogen los puntos
 %conversor = abs(ConductanceMap(1,length(ConductanceMap(1,:)))-ConductanceMap(1,1))/length(ConductanceMap(1,:));
 
    XinicioFinal = puntero(1,1);
	YinicioFinal = puntero(1,2);
 
 %Paso las input a pixeles para elegir el numero de puntos e el perfil
 
    PixelXinicioFinal = zeros(length(XinicioFinal),1);
    PixelYinicioFinal = zeros(length(YinicioFinal),1);
    
for i =1:length(XinicioFinal)
    [~, PixelXinicioFinal(i)] = min(abs(XinicioFinal(i)-VectorTamanhoX));
    [~, PixelYinicioFinal(i)] = min(abs(YinicioFinal(i)-VectorTamanhoY));
end
b=findobj('Name', 'mainFig');
if flag
    curvaUnicaPlot = figure(120);
    curvaUnicaPlot.Position = [20 300 460 410];
    display(['RS Pixel = [',num2str(PixelXinicioFinal),',',num2str(PixelYinicioFinal),...
            '] \\ Indice = ',num2str((PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i))]);
else
    curvaUnicaPlot = figure(121);
%     curvaUnicaPlot.Position = [500 300 460 410];
    display(['FFT Pixel = [',num2str(PixelXinicioFinal),',',num2str(PixelYinicioFinal),...
            '] \\ Indice = ',num2str((PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i))]);
end

color = winter(length(PixelXinicioFinal));

%Paso los valores directamente a vectores para que sea mas facil de
%entender:
    (PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i)
    size(MatrizNormalizada)
    ConductanciaCurvaUnica = MatrizNormalizada(:,(PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i));
    
    ConductanciaCurvaUnica = ConductanciaCurvaUnica*1e3; %Conductancia en nS
%     ConductanciaCurvaUnica = smooth(MatrizNormalizada(:,(PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i)));


for i=1:length(PixelXinicioFinal)
    hold on
    curvaUnicaPlot.Children.ColorOrderIndex = b.Children.ColorOrderIndex;
    FigCurvas = plot(Voltaje,...
                     ConductanciaCurvaUnica,...
                     '-','LineWidth',2);
%         FigCurvas.Color = color(i,:);
         
        xlabel('Energy (meV)',...
                'FontSize',16);
            xlim([min(Voltaje),max(Voltaje)]);
        
        ylabel('Conductance (nS)',...
                'FontSize',16);
%             ylim([0 ,2]);
    
        title(num2str(Columnas*(PixelYinicioFinal(i)-1)+ PixelXinicioFinal(i)));
    
        axis square; legend off; box on;
        set(gcf,'color',[1 1 1]); % quita el borde gris
        set(gca,'FontWeight','bold');
        set(gca,'fontsize',12);
%         FigCurvas.Name = 'curvaUnicaFig';
end

%ConductanceMap(PixelYinicioFinal,PixelXinicioFinal)
% uicontrol('Style', 'pushbutton', 'String', 'Save',...
%         'Position', [400 120 50 20],...
%         'Callback', @(src,eventdata)saveData(src,eventdata,ConductanceMap,PixelXinicioFinal,...
%                         PixelYinicioFinal, Voltaje, ConductanciaCurvaUnica));
%                     
% uicontrol('Style', 'text', 'String', num2str(Columnas*(PixelYinicioFinal(i)-1)+ PixelXinicioFinal(i)),...
%         'Position', [400 180 50 20],...
%         'Callback', @(src,eventdata)saveData(src,eventdata,ConductanceMap,...
%         PixelXinicioFinal, PixelYinicioFinal));
curvaUnicaPlot.Name = 'curvaUnicaFig';
curvaUnicaPlot.CloseRequestFcn = 'kill';
a=findobj('Name', 'mainFig');
hold on
cross = plot(a.Children,XinicioFinal,YinicioFinal,'x','MarkerSize',10,'LineWidth',2);
cross.Tag = 'curvaUnicaFig';

