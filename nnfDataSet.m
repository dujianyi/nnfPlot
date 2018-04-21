classdef nnfDataSet < handle
    properties
        fName
        data
    end
    
    methods 
        function self = nnfDataSet(fileName, varName, units, values, varargin)
            % fileName: string, file to imported, or to save (can be used as legend)
            % varName: cell of all names of variables
            % units: cell of all units
            % values: table of all variables
            % varargin (optional): delimiter 
            pf = '\t';
            if nargin > 4
                pf = varargin{1};
            end
            varSplit = varName;
            unitsSplit = units;
            if ischar(varSplit)
                varSplit = strsplit(varName, pf);
                unitsSplit = strsplit(units, pf);
            end
            svalues = size(values);
            if (length(varSplit) == length(unitsSplit) && length(varSplit) ==  svalues(2))
                self.fName = fileName;
                self.data = {};
                for i = 1:svalues(2)
                    self.data{i} = nnfDataCol(varSplit{i}, unitsSplit{i}, values(:, i));
                end
            else
                error('Check column number of data, variables names and units!\n')
            end
        end
        
        function removeDataCol(self, dataColNum)
            self.data{dataColNum} = [];
        end
        
        function changeVarName(self, dataColNum, newVarName)
            self.data{dataColNum}.vName = newVarName;            
        end
        
        function changeUnitName(self, dataColNum, newUnitName)
            self.data{dataColNum}.unit = newUnitName;            
        end
    end
end