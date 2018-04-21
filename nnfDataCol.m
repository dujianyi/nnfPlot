classdef nnfDataCol < handle
    properties
        vName
        unit
        data
    end
    
    methods
        function self = nnfDataCol(varargin)
            if (nargin == 1)
                if (isvector(varargin{1}) || istable(varargin{1}))
                    vName = 'untitled';
                    unit = '';
                    data = varargin{1};
                else
                    self.repError;
                end
            elseif (nargin == 3)
                    vName = varargin{1};
                    unit = varargin{2};
                    data = varargin{3};
            else
                self.repError;
            end
            
            self.vName = vName;
            self.unit = unit;
            if istable(data)
                self.data = data.Variables;
            else
                self.data = data;
            end
        end
        
        function tr(self, addValue)
            self.data = self.data + addValue;
        end
        
        function repError(self)
            error('Data input error: Wrong format!')
        end
        
    end
end