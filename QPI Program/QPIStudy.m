%% Script for analyzing deeply QPI
% Variables needed:
   %Transformadas
   %DistanciaFourierColumnas
   %DistanciaFourierFilas
   %DistanciaColumnas
   %DistanciaFilas
   %Energia
   %TamanhoRealFilas
   %TamanhoRealColumnas
   %ParametroRedFilas
   %ParametroRedColumnas
   %MatrizNormalizada
   %MapasConductancia

   InfoStruct.Energia = Energia;
   InfoStruct.DistanciaFourierColumnas= DistanciaFourierColumnas;
   InfoStruct.DistanciaFourierFilas = DistanciaFourierFilas;
%% Complete InfoStruct
Bias = 100; %Bias Voltaje in mV
PuntosDerivada = 6; %Número de puntos de derivada con los que se ha cuardado0 el InfoStruct
InfoStruct = completeInfo(InfoStruct,Bias,PuntosDerivada);
%% Initial colormap
%    InfoStruct.Colormap = JapanColormap;
%    InfoStruct.Colormap = parula;
   InfoStruct.Colormap = bone;
%%
InfoStructOriginal = InfoStruct;
%%
InfoStruct = InfoStructOriginal;
%% Recorte QPI
x1=120;
x2=247;
y1=70;
y2=197;
InfoStruct = RecorteQPI(x1,x2,y1,y2,InfoStructOriginal);
%% Mapas Conductancia
  VisualizeCell(InfoStruct.MapasConductancia,InfoStruct)
        fourierImage = gcf;
        fourierImage.UserData.Colormap = InfoStruct.Colormap;
%% Curva Conductancia Media
   curva = meanConductance(InfoStruct);
% meanConductance(InfoStruct);
   %% 
    for k=1:length(InfoStruct.Energia)
        InfoStruct.Transformadas{k}=InfoStruct.Transformadas{k}*1e6;
%         InfoStruct.MapasConductancia{k}=InfoStruct.MapasConductancia{k}*1e-6;
    end
%% Visualize and change contrast or colormap in KSpace
    VisualizeCell(InfoStruct.Transformadas,InfoStruct)
        fourierImage = gcf;
        fourierImage.UserData.Colormap = InfoStruct.Colormap;
%         fourierImage.UserData.Contrast = Contraste;
%%  Save things IMPORTANT     
     
      TransformadasAnalisis = InfoStruct.Transformadas;
      InfoStruct = fourierImage.UserData;
      
      InfoStructAnalisis  = fourierImage.UserData;
      InfoStructAnalisisCopy    = InfoStructAnalisis;
%% Remove central line
[TransformadasAnalisisCopy] = RemoveCentralLine(TransformadasAnalisis, InfoStructAnalisis);
VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy); 
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
%% Rotate matrix
Angle=17.48;
% Angle=0.7;
% Angle=23.34;
% Angle=15.5;
% Angle=19.13;
% Angle=21.6;
% Angle=17.75;
% Angle=14;
% Angle=17.56;
% Angle=17;
% Angle=20.4;
% Angle=14.44;
% Angle=18;
% Angle=20.35;
% Angle=17.14;
% Angle=22.45;
% Angle=22.16;
% Angle=17.19;
% Angle=22.13;
% Angle=21.14;
% Angle=15.63;
% Angle=18.03;
% Angle=18;
% Angle=16.06;
% Angle=18.04;
[TransformadasAnalisisCopy] = RotateMatrix(TransformadasAnalisis, Angle, InfoStructAnalisis);
VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy); 
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
%% Cut Matrix as seen in figure

  
    cut  = [fourierImage.Children(end).XLim, fourierImage.Children(end).YLim];
   [TransformadasAnalisisCopy, DistFourierColCrop, DistFourierFilCrop] = CropImage(TransformadasAnalisis, cut,...
       InfoStructAnalisis.DistanciaFourierColumnas,InfoStructAnalisis.DistanciaFourierFilas);
  
   Energia = InfoStructAnalisisCopy.Energia;
   InfoStructAnalisisCopy.DistanciaFourierColumnas = DistFourierColCrop;
   InfoStructAnalisisCopy.DistanciaFourierFilas = DistFourierFilCrop; 
   InfoStructAnalisisCopy.Contrast       = InfoStruct.Contrast;
   InfoStructAnalisisCopy.XLim       = [repmat(DistFourierColCrop(1),[1, length(Energia)]);...
                                    repmat(DistFourierColCrop(end),[1, length(Energia)])];
   InfoStructAnalisisCopy .YLim      = [repmat(DistFourierFilCrop(1),[1, length(Energia)]);...
                                    repmat(DistFourierFilCrop(end),[1, length(Energia)])];                             
        
   VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy );
   %% Save things
     
      TransformadasAnalisis = TransformadasAnalisisCopy;
      InfoStructAnalisis   = fourierImage.UserData;
%% Filters%%%%%%%%%%%%%%%%%%%%%%%
%% CenterFilter
% Sigma = 3;
%  [TransformadasAnalisisCopy] = GaussianFilter(TransformadasAnalisis, Sigma, InfoStructAnalisis);

%  Filter = [2 2];
%  [TransformadasAnalisisCopy] = LowPassFilter(TransformadasAnalisis, Filter, InfoStructAnalisis);
[TransformadasAnalisisCopy] = GaussSmooth(TransformadasAnalisis, 0.5, InfoStructAnalisis);
    VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy);
%% Save things

      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
    
    %% Simetrization

TransformadasAnalisisCopy = simetrizarFFT_Automatico(TransformadasAnalisis, 0);
VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy);
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;

%%  Make Maps Difference
      
    [TransformadasAnalisisCopy ,  InfoStructAnalisisCopy] = differenceCell(TransformadasAnalisis, InfoStructAnalisis);
    VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy);
    %% Save things
      
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
     
            
%% Make Line Profile with angle
angle = 45;
width = 1;
[Profile, Momentum] = MakeProfile(TransformadasAnalisis , InfoStructAnalisis,angle,width);

figure(80)
%imagesc(Momentum, InfoStructAnalisis.Energia, Profile)
imagesc(InfoStructAnalisis.DistanciaFourierFilas*2*InfoStructAnalisis.ParametroRedFilas,InfoStructAnalisis.Energia,Profile);
% colormap(tColor)
axis([0 1 min(InfoStructAnalisis.Energia) max(InfoStructAnalisis.Energia)]);
axis([0 1 -8.5 8.5]);
axe = gca;
set(gca,'YDir','normal')
axe.FontSize = 20;     
axe.CLim = InfoStructAnalisis.Contrast(:,1);
axe.XTick = [];
axe.YTick = [];
% axe.Position = axe.OuterPosition;
axis square

%% Make diagonal profile
diagonal(InfoStruct,TransformadasAnalisis,0.01,0.15)
%% Make Radial profile
RadialProfileMap(InfoStruct,TransformadasAnalisis)
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
%%
for i = 1:length(InfoStructAnalisis.Energia)
    TransformadasAnalisisCopy{i} = TransformadasAnalisis{i}*1000000;
end
VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy);
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
%% MAKE MEAN
%% Save all figures
saveCell(TransformadasAnalisis, InfoStructAnalisis) 

% saveCell(InfoStruct.MapasConductancia, InfoStructAnalisis)


%%
VisualizeCell(TransformadasAnalisis, InfoStructAnalisisCopy);
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;

%% Adjust the (0,0) in matrix
 [TransformadasAnalisisCopy ,  InfoStructAnalisisCopy] = adjustZero(TransformadasAnalisis, InfoStructAnalisis);
    VisualizeCell(TransformadasAnalisisCopy, InfoStructAnalisisCopy);
%% Save things
      TransformadasAnalisis = TransformadasAnalisisCopy  ;
      InfoStructAnalisis   = fourierImage.UserData;
