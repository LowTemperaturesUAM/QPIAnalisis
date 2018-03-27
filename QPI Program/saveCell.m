function saveCell(Cell, Info)

NCell = length(Info.Energia);

PathName = uigetdir;


for i = 1:NCell
 
    SaveFigure         = figure;
    SaveFigure.Visible = 'off';
    colormap( Info.Colormap);
    
    imagesc(Info.DistanciaFourierColumnas, Info.DistanciaFourierFilas, Cell{i});
%%%%%%%%%%%%%%%%%%Choose whatever you prefer%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

                %%%%%%  NO TITLE NO AXES NO BORDERS %%%%%%%
                %      SaveFigure.Children.Position =  SaveFigure.Children.OuterPosition;
                %      SaveFigure.Children.XTick = [];
                %      SaveFigure.Children.YTick = [];
                %      SaveFigure.Children.XTickLabel = [];
                %      SaveFigure.Children.YTickLabel = [];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%  WITH TITLE AND AXES %%%%%%%%%%%%%
                %   title([num2str(Info.Energia(i)), ' mV']);
                %   SaveFigure.Children.Position= [0.1 0.1 0.85 0.75];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %%%%%%%%%%%%%%  ONLY TITLE  %%%%%%%%%%%%%%%%%%%
                title([num2str(Info.Energia(i)), ' mV']);
                SaveFigure.Children.Position= [0.0 0.0 1 0.94];
                SaveFigure.Children.XTick = [];
                SaveFigure.Children.YTick = [];
                SaveFigure.Children.XTickLabel = [];
                SaveFigure.Children.YTickLabel = [];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


      SaveFigure.PaperPosition = [ 0 0 15 15];

      daspect([1 (SaveFigure.Children.YLim(end) - SaveFigure.Children.YLim(1)) /...
         (SaveFigure.Children.XLim(end) - SaveFigure.Children.XLim(1)) 1])
  
    SaveFigure.Children.YDir = 'normal';
    SaveFigure.Children.FontSize = 20;
    SaveFigure.Children.CLim = Info.Contrast(:,i);
    SaveFigure.Children.XLim =  Info.XLim(:, i);
    SaveFigure.Children.YLim =  Info.YLim(:, i);
    



    
    name = num2str(Info.Energia(i));
    name = strrep(name,'.',',');
    print(SaveFigure,[PathName,'/', name],'-dpng','-noui')  
    
end
   