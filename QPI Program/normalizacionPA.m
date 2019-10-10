% NORMALIZACI�N
% ------------------------------------
% Pepe  06/07/2015
% Ant�n 13/07/2015 - Modificaci�n
% Ant�n 28/07/2015 - Modificaci�n
% Ant�n 31/03/2016 - Modificaci�n
% Ant�n 06/04/2016 - Modificaci�n: retoques en visualizaci�n
% ------------------------------------
%
% Esta funci�n toma la derivada de una "matrizConductancia" y la normaliza
% a los valores correspondientes al promedio de los valores de la
% conductancia entre dos valores de voltaje dados: "voltajeSuperior" y
% "voltajeInferior".
%
% ENTRADA:
%   voltajeSuperior:    l�mite inferior de voltaje para el promedio de la
%                       normalizaci�n
%   voltajeInferior:    l�mite superior de voltaje para el promedio de la
%                       normalizaci�n
%   matrizVoltaje:      matriz con los voltajes
%   matrizConductancia: matriz con la conductancia
%
% SALIDA:
%   matrizNormalizada: matriz con los valores normalizados
%
% NOTA: se utilizan las variables globales lineas e iV
 
function [MatrizNormalizada] = normalizacionPA(VoltajeSuperior,VoltajeInferior,Voltaje,MatrizConductancia,Filas,Columnas)

[IV, ~] = size(MatrizConductancia);
% Filas = sqrt(Delete);
% Columnas = sqrt(Delete);
% clear Delete;

% Tomamos los valores entre los voltajes elegidos y hacemos la media como:
% NormaTotal = (norma1 + norma2)/2;

    Indices1 = find(VoltajeSuperior > Voltaje(1:IV) & VoltajeInferior < Voltaje(1:IV));
    Indices2 = find(-VoltajeSuperior < Voltaje(1:IV) & -VoltajeInferior > Voltaje(1:IV));
    
% La normalizaci�n total de la imagen ser� el promedio de las
% normalizaciones para valores de voltaje positivos y negativos

    Norma1 = mean(MatrizConductancia(Indices1,:),1);
    Norma2 = mean(MatrizConductancia(Indices2,:),1);
    Norma = (Norma1(:,:) + Norma2(:,:))/2;

MatrizNormalizada= bsxfun(@rdivide,MatrizConductancia,Norma);

% % REPRESENTACI�N
% % Se cogen aleatoriamente unas curvas de conductancia para ver si el
% % resultado es o no satisfactorio y se representan.
% %
% % COMENTAR LAS SIGUIENTES L�NEAS EN CASO DE NO QUERER REPRESENTAR LOS
% % EJEMPLOS
% % ---------------------------------------------------------------------------
%     i = 1+round(rand(10,1)*(Columnas-1)); % �ndice aleatorio para la elecci�n de curvas
%     j = 1+round(rand(10,1)*(Filas-1)); % �ndice aleatorio para la elecci�n de curvas
%     
% 
%     close(figure(17))
%     
%     figure(17)
%         hold on
%         for count=1:length(i)
%            plot(Voltaje ,MatrizNormalizada(:,(Filas*(j(count)-1)+ i(count))),...
%                '-o',...
%                'MarkerSize',2)
%         end
%         
%         clear count i j;
%         
%         % Si se quiere a�adir la media total de la figura (solo tiene
%         % sentido si el gap es homog�neo, cosa que no suele ocurrir)
%         plot(Voltaje,mean(MatrizNormalizada,2),'k-','LineWidth',2);
%         
%         plot([VoltajeInferior, VoltajeInferior], [0, 2],'b-');
%         plot([-VoltajeInferior, -VoltajeInferior], [0, 2],'b-');
%         plot([VoltajeSuperior, VoltajeSuperior], [0, 2],'r-');
%         plot([-VoltajeSuperior, -VoltajeSuperior], [0, 2],'r-');
%     
%         xlabel('Bias voltage (mV)',...
%                 'FontSize',20);
%             xlim([min(Voltaje),max(Voltaje)]);
%         
%         ylabel('Normalized conductance',...
%                 'FontSize',20);
%             ylim([0 ,2]);
%     
%         title('Examples');
%     
%         axis square; legend off; box on;
%         set(gcf,'color',[1 1 1]); % quita el borde gris
%         set(gca,'fontsize',16);
%         set(gcf,'Position',[367   286   727   590]);
%         
%         hold off
% % -----------------------------------------------------------------------------
