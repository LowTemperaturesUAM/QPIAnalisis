% DERIVADOR
% ------------------------------------
% Pepe  06/07/2015
% Ant�n 13/07/2015 - Modificaci�n
% Ant�n 28/07/2015 - Modificaci�n
% Ant�n 31/03/2016 - Modificaci�n: eliminamos variables globales
% Ant�n 06/04/2016 - Modificaci�n: para m�nimos cuadrados
% ------------------------------------
%
% Esta funci�n hace la derivada de "matrizCorriente" (m, n, z) con respecto a
% "MatrizVoltaje" (m, n, z) para cada una de las curvas IV de la tercera
% dimiensi�n utilizando la definici�n de derivada con "nPuntosDer" puntos. La salida es la
% derivada "matrizConductancia".
%
% ENTRADA:
%   NPuntosDerValor: n�mero de puntos a utilizar en la derivada
%   MatrizCorriente: la matriz con los valores de corriente a derivar
%   MatrizVoltaje: matriz con los valores respecto a los que se deriva
%
% SALIDA:
%   MatrizConductancia: matriz con los valores de la derivada. Notar que su
%       tercera dimensi�n ser� menor que la de "matrizCorriente" debido al
%       n�mero de puntos que se usan en la derivada.
%


function [MatrizConductancia] = derivadorLeastSquaresPA(NPuntosDerValor,MatrizCorriente,Voltaje,Filas,Columnas)

[IV, ~] = size(MatrizCorriente);
% Filas = sqrt(Delete);
% Columnas = sqrt(Delete);
% clear Delete;

PasoVoltaje = abs(Voltaje(2) - Voltaje(1)); % Definimos el paso en voltaje
NPuntosDer = abs(NPuntosDerValor);                              % Por si un boludo, lo escribe en negativo

MatrizConductancia = zeros(IV-2*NPuntosDer,Filas*Columnas);      % Definimos la matriz de salida

if NPuntosDer==0 % Derivada cl�sica de un punto
%     fprintf('Derivada con %g puntos\n', NPuntosDer); % Control
    for i=1:Filas
        for j=1:Columnas
            for c=1+NPuntosDer:IV -NPuntosDer
                MatrizConductancia(i,j,c-NPuntosDer)=((MatrizCorriente(i,j,c+NPuntosDer))-(MatrizCorriente(i,j,c-NPuntosDer)))/(PasoVoltaje);
            end 
        end
    end
    
else
%     fprintf('Derivada con %g puntos\n', NPuntosDer); % Control

% -----------------------------------------------------------------
% INFO:
% -----------------------------------------------------------------
% Para hacer esta derivada se usa una GENERALIZACI�N DE M�NIMOS CUADRADOS
% para hacer diferencias finitas. Puede consultarse en:
%
% Real Anal. Exchange
% Volume 35, Number 1 (2009), 205-228.
% A Least Squares Approach to Differentiation
% Russell A. Gordon
% 
% http://projecteuclid.org/euclid.rae/1272376232
% http://projecteuclid.org/download/pdf_1/euclid.rae/1272376232
% -----------------------------------------------------------------

	for c = 1+NPuntosDer:IV-NPuntosDer
                
        Numerador = zeros(1,Filas*Columnas);
        Ajuste = zeros(1,Filas*Columnas);
        Denominador = 0;
                
        for k = -NPuntosDer:NPuntosDer
        	Numerador = Numerador + MatrizCorriente(c+k,:)*(Voltaje(c+k)-Voltaje(c));
            Denominador = Denominador + (Voltaje(c+k)-Voltaje(c))*(Voltaje(c+k)-Voltaje(c));
        end
                
        Ajuste(:) = Numerador(:)./Denominador;
        MatrizConductancia(c-NPuntosDer,:) = Ajuste(:);
                
	end

end 

clear c k Numerador Denominador Ajuste PasoVoltaje;

% Amplio la matrizConductancia para que tenga las dimensiones originales.
% Simplemente los primeros y ultimos puntos de la derivada son iguales que
% el ultimo y primer punto de la matriz. Por comodidad en la visualizaci�n
% y el tratamiento de los datos

MatrizConductanciaAUX = MatrizConductancia;
MatrizConductancia = zeros(IV,Filas*Columnas);
MatrizConductancia(1+NPuntosDer:IV-NPuntosDer,:) = MatrizConductanciaAUX;

for i = 1:NPuntosDer
    MatrizConductancia(i,:) = MatrizConductanciaAUX(2*NPuntosDer,:);
    MatrizConductancia(IV-(i-1),:) = MatrizConductanciaAUX(IV-2*NPuntosDer,:);
end

clear i MatrizConductanciaAUX
