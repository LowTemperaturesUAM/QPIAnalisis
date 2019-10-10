function [Info] = completeInfo(Info,VBias,PuntosDerivada)
 Info.Bias = VBias;
 a = size(Info.MatrizNormalizada);
 Info.PuntosIV = a(1);
 Info.Voltaje = linspace(Info.Bias,-1*Info.Bias,Info.PuntosIV);
 Info.PuntosDerivada = PuntosDerivada;
end