function  [Info] = VisualizeCell(Cell,Info)
3
%Every matrix in the cell is of the same size but not squared. If only XVector is given,
%an squared matrix is supposed with YVector equals to XVector
Energia = Info.Energia;
XVector = Info.DistanciaFourierColumnas;
YVector = Info.DistanciaFourierFilas; 
NumberOfImages = length(Energia);


Cero           = find(Energia == 0);
a = figure(23);
a.Name = 'mainFig';

axe = gca;


if ~isfield(Info, 'Contrast')
Info.Contrast = [zeros(1,NumberOfImages); ones(1,NumberOfImages)];
end


if ~isfield(Info, 'XLim')
    Info.XLim= [zeros(1,NumberOfImages); ones(1,NumberOfImages)];
end

if ~isfield(Info, 'YLim')
    Info.YLim = [zeros(1,NumberOfImages); ones(1,NumberOfImages)];
end





a.WindowKeyPressFcn = @WindowPress;
a.WindowButtonUpFcn = @WindowUp;
a.WindowButtonMotionFcn = @WindowMotion;
a.WindowButtonDownFcn = @WindowDown;




%First plot of the images
imagesc(XVector,YVector, Cell{Cero})

colormap(a.Children, Info.Colormap);
            
set(gca,'YDir','normal')
axe.FontSize = 20;
            if Info.XLim(2,2) == 1 && Info.YLim(2,2)  == 1
                
                axe.XLim  = [XVector(1), XVector(end)];
                axe.YLim  = [YVector(1), YVector(end)];
                
                Info.XLim = [repmat(XVector(1),[1,length(Energia)]);...
                             repmat(XVector(end),[1,length(Energia)])];
                         
                Info.YLim = [repmat(YVector(1),[1,length(Energia)]);...
                             repmat(YVector(end),[1,length(Energia)])]; 

            end
             
     axe.CLim = Info.Contrast(:,Cero);
      
      a.Colormap =  Info.Colormap ;    
     
pbaspect([1 (axe.YLim(end) - axe.YLim(1)) /(axe.XLim(end) - axe.XLim(1)) 1])
title([num2str(Energia(Cero)) ' mV'])





    function PreviousImage(~, ~)
        axe = gca;
        %disp('aa')
              
        Cero = Cero -1;
        if Cero <1; Cero = 1; end
         
         
        
        imagesc(XVector,YVector, Cell{Cero});
        set(gca,'YDir','normal')
        axe.FontSize = 20;
        
        axe.CLim = Info.Contrast(1:2,Cero);
        
       Info.XLim(1:2,Cero);
       Info.YLim(1:2,Cero);
        axe.XLim = Info.XLim(1:2,Cero);
        
        axe.YLim = Info.YLim(1:2,Cero);
         a.Colormap  = Info.Colormap   ;  
        if axe.CLim(2) ==1
             axe.CLim = Info.Contrast(1:2,Cero+1);
             
             
             
        end
        if axe.XLim(2) ==1
             axe.XLim = Info.XLim(1:2,Cero+1);
        end
        if axe.YLim(2) ==1
             axe.YLim = Info.YLim(1:2,Cero+1);
        end
        pbaspect([1 (axe.YLim(end) - axe.YLim(1)) /(axe.XLim(end) - axe.XLim(1)) 1])
        title([num2str(Energia(Cero)) ' mV'])
        
        
        
    end
    function NextImage(~, ~)
        
         axe = gca;
         
        Cero = Cero +1;
        if Cero >length(Energia); Cero = length(Energia); end
         
        
        a.Colormap  = Info.Colormap   ;
        imagesc(XVector,YVector, Cell{Cero})
        
        set(gca,'YDir','normal')
    
        

        axe.FontSize = 20;
        
        axe.CLim = Info.Contrast(1:2,Cero);
        axe.XLim = Info.XLim(1:2,Cero);
        axe.YLim = Info.YLim(1:2,Cero);
        if axe.CLim(2) ==1
             axe.CLim = Info.Contrast(1:2,Cero -1);
        end
        if axe.XLim(2) ==1
             axe.XLim = Info.XLim(1:2,Cero -1);
        end
        if axe.YLim(2) ==1
             axe.YLim = Info.YLim(1:2,Cero -1);
        end

      
        pbaspect([1 (axe.YLim(end) - axe.YLim(1)) /(axe.XLim(end) - axe.XLim(1)) 1])
        title([num2str(Energia(Cero)) ' mV'])
        a.UserData = Info;
      
    end
    function SaveContrast(~,~, ~)
            a = gcf;
            Info.Contrast(1:2,Cero) = axe.CLim;
            Info.XLim(1:2,Cero) = axe.XLim;
            Info.YLim(1:2,Cero) = axe.YLim;
            
            Info.Colormap = a.Colormap  ;
            a.UserData = Info;

    end
    function WindowPress(~, event,~)
        event.Key
        if strcmp(event.Key, 'return')
            SaveContrast;
        end
        if strcmp(event.Key, 'rightarrow')
            
            NextImage;
        end
        if strcmp(event.Key, 'leftarrow')
            PreviousImage;
        end
        if strcmp(event.Key, 'c')
            axe = gca;
            axe.XLim(2) = -axe.XLim(1);
            axe.YLim(2) = -axe.YLim(1);
            
        end
        if strcmp(event.Key, 's')
            axe = gca;
            axe.YLim = axe.XLim;
            
        end
        
        if strcmp(event.Key, 'b')
            axe = gca;
            ParametroRedColumnas = Info.ParametroRedColumnas;
            ParametroRedFilas = Info.ParametroRedFilas ;
            axe.XLim  = [-1/(2*ParametroRedColumnas), 1/(2*ParametroRedColumnas)];
            axe.YLim  = [-1/(2*ParametroRedFilas), 1/(2*ParametroRedFilas)];
            Info.XLim = [repmat(-1/(2*ParametroRedColumnas),[1,length(Energia)]);...
                                   repmat(1/(2*ParametroRedColumnas),[1,length(Energia)])];
            Info.YLim = [repmat(-1/(2*ParametroRedFilas),[1,length(Energia)]);...
                                   repmat(1/(2*ParametroRedFilas),[1,length(Energia)])]; 
            
            
        end
        if strcmp(event.Key, 'o')
            axe = gca;

            axe.XLim  = [XVector(1), XVector(end)];
            axe.YLim  = [YVector(1), YVector(end)];
            Info.XLim = [repmat(XVector(1),[1,length(Energia)]);...
                                   repmat(XVector(end),[1,length(Energia)])];
            Info.YLim = [repmat(YVector(1),[1,length(Energia)]);...
                                   repmat(YVector(end),[1,length(Energia)])];       
            
        end
        
        if strcmp(event.Key, 'space')
            axe = gca;

           
            
            Info.Contrast = [repmat(axe.CLim(1),[1,length(Energia)]);...
                                   repmat(axe.CLim(2),[1,length(Energia)])];
            
             
        end
        
        if strcmp(event.Key, '0')
            axe.ColorOrderIndex = 1;
            num = length(axe.Children);
            j=0;
            for i=1:num
                 if strcmp(axe.Children(i).Type,'rectangle') | strcmp(axe.Children(i).Type,'line')
                     j = j+1;
                     borra(j) = i;
                 end         
            end
                delete(axe.Children(borra))
        end
        pbaspect([1 (axe.YLim(end) - axe.YLim(1)) /(axe.XLim(end) - axe.XLim(1)) 1])
    end   
    function WindowUp(~, ~)
        [~, button, movimiento] = Up();
        
        axe = gca;
        Info.XLim = [repmat(axe.XLim(1),[1,length(Energia)]);...
                                   repmat(axe.XLim(2),[1,length(Energia)])];
        Info.YLim = [repmat(axe.YLim(1),[1,length(Energia)]);...
                                   repmat(axe.YLim(2),[1,length(Energia)])];
        pbaspect([1 (axe.YLim(end) - axe.YLim(1)) /(axe.XLim(end) - axe.XLim(1)) 1])
       
        if strcmp(button, 'alt') && movimiento >0
%             Coordinates = axe.UserData.Rectangle
%             
%             Coordinates = [Coordinates(1:2), Coordinates(1:2) + Coordinates(3:4)];
%             Coordinates = (Coordinates - Info.DistanciaFourierFilas(1) )./...
%             (abs(Info.DistanciaFourierFilas(1)) + Info.DistanciaFourierFilas(end));
%             
%             Index = round(Coordinates.*length(Info.DistanciaFourierFilas));
           Rectangulo = axe.UserData.Rectangle;
        
        MeanIVFunction(Rectangulo, Info.MatrizNormalizada, Info.Voltaje, length(Info.DistanciaFourierColumnas),...
            length(Info.DistanciaFourierColumnas), Info.DistanciaFourierColumnas,Info);
       
        end
        
        if strcmp(button,'open')
            %Puntero = axe.CurrentPoint;
            [Bias, ConductanciaCurvaUnica] = curvaUnicaPA(axe.CurrentPoint,Info.MapasConductancia{1},Info.Voltaje,Info.MatrizNormalizada, Info.DistanciaFourierFilas,Info.DistanciaFourierColumnas,0)
        end
        assignin('base','Voltaje',Bias);
        assignin('base','ConductanciaCurvaUnica',ConductanciaCurvaUnica);
    end
    function WindowMotion(~, ~)
        CurrentPoint()
    end
    function WindowDown(~, ~)
        Down()
    end
  
a.UserData = Info;        

end
