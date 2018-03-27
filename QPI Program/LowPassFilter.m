function [CellFilt] = LowPassFilter(Cell, Filter, Info)
NCell = length(Info.Energia);
CellFilt{NCell} = 0;
    for i = 1:NCell
        CellFilt{i} = wiener2(Cell{i}, Filter);
    end