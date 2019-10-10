function [CellSmooth] = GaussSmooth(Cell, Value, Info)

CellSmooth = Cell;

for k=1:length(Info.Energia)
   CellSmooth{k} = imgaussfilt(Cell{k},Value);
end