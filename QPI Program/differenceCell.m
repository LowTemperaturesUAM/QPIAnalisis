function [MapsDiference, InfoNew] = differenceCell(Cell, Info)

NCell = length(Info.Energia);

MapsDiference{NCell-1} = 0;
for i = 2:NCell
    size(Cell{i-1})
    size(Cell{i})
    size(MapsDiference{i-1})
    MapsDiference{i-1} = Cell{i} - Cell{i-1};
    
    MaxDifference = max(max(abs(MapsDiference{i-1})));
    MapsDiference{i-1} = MapsDiference{i-1}/(MaxDifference);
end



InfoNew = Info;
InfoNew.Energia = Info.Energia(2:end);
    
    