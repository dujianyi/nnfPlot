% Class function
% Function: generatedLabel
% Generate axis labels for the DataCol types
function labl = generatedLabel(self, DataCol)
    if (isempty(DataCol.unit))
        labl = DataCol.vName;
    else
        labl = [DataCol.vName, ' [', DataCol.unit, ']'];
    end
end