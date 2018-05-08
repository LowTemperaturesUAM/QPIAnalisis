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
   
%% Visualize and change contrast or colormap in KSpace
    VisualizeCell(InfoStruct.Transformadas,InfoStruct)
        fourierImage = gcf;
        fourierImage.UserData.Colormap = InfoStruct.Colormap;
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
angle = 90;
width = 1;
[Profile, Momentum] = MakeProfile(TransformadasAnalisis , InfoStructAnalisis,angle,width);

figure(79)
%imagesc(Momentum, InfoStructAnalisis.Energia, Profile)
imagesc(InfoStructAnalisis.DistanciaFourierFilas*2*InfoStructAnalisis.ParametroRedFilas,InfoStructAnalisis.Energia,Profile);
colormap(tColor)
axis([0 1 min(InfoStructAnalisis.Energia) max(InfoStructAnalisis.Energia)]);
axis([0 1 -85 85]);
axe = gca;
set(gca,'YDir','normal')
axe.FontSize = 20;     
axe.CLim = InfoStructAnalisis.Contrast(:,1);
axe.XTick = [];
axe.YTick = [];
% axe.Position = axe.OuterPosition;
%axis square

%% Make Radial Profile



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
