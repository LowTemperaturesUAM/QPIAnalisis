% Módulo de la transformada de Fourier 2D
% Nota para mejor comprensión: RSI = Real Space Image

function FFT = fft2d(RSI)% La entrada es una matriz con la imagen en el espacio real

    FFT = fft2(RSI);        % Esta orden hace la transformada para una imagen 2D rutina de matlab
    FFT = fftshift(FFT);    % Pone la componente de frecuencia cero en el centro del espectro
    FFT = abs(FFT);         % Valor absoluto para evitar problemas con la parte imaginaria
%      FFT = log((FFT+1)+1);   % Logaritmo para que la escalca quede mejor

%   FFT = mat2gray(FFT);    % Escala de grises (opcional)
end

