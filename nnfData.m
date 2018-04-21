classdef nnfData < handle
% nnfData
% Ver. 1.0.0

% Jianyi Du (MIT)
% jydu@mit.edu
% License: MIT

% This package is created for the purpose to visualize data more easily for
% engineering purposes. I have tried several different softwares, including
% MATLAB, Origin Pro, Graphpad Prism, scidavis, and R. They all have their
% own problems: 
% 1. GUI softwares (Origin, Prism and scidavis): lack of flexibility in
% processing;
% 2. Programming language (MATLAB, R): every plot requires a lot of
% repeated coding job and it is rather hard to save figures locally for
% future referencing

% Thus none can meet my requirements for the following stuff: 

% 1. Easy to import data from raw equipment outputs (including raw data, );
% 2. Check back the plots conveniently without re-running the codes;
% 3. The plot can reflect the change of x, y data with minimizing plot data
% 4. Calculation within the program, to utilize the power of MATLAB for
% data post-processing, including fitting and solving ODE/PDE
% 5. Figure properties are easy to change and new plots can be generated
% without re-running the processing codes
% 6. The plots are beautiful (compared with Origin)
% 7. Easy to add reference lines and fitting lines 
% 8. The data are easy to trace back from the figure
% 9. Running on Macbook 

% This package aims to solve all the problems listed above, while
% giving users flexibility to add their own features. The package is
% written with the following features:
% 1. The typical data processing procedures include: 
%    (1) Data importing: From raw data file to data handles
%    (2) Data processing: From data handles to results handles
%    (3) Data visualization: From results handles to plot handles
%    To minimize the repeated figure work, the direct way is to separate
%    the three processes, and save them individually at specific
%    locations in the class.
% 2. Structure: For the structure I refer to that of Origin Pro, which I
% think can preserve the data and processing nicely. This structure includes:
%    (1*) Folders and subfolders to save differnt types of data
%    (2) Raw data files to save data itself, and can be loaded as input for
%    processing procedures
%    (3) Processing function should be input by the users, but shall be
%    saved inside the class rather than as individual files ( too messy,
%    unless the template is specified, output = func(input) )
%    (4) Results are saved individually without contaminating the raw data.
%    (4*) Results are linked with raw data with handles.update options
%    (5) Plots are handles itself, saving all properties. Defaults should
%    be well defined for everyday purpose, while flexibility is given to
%    further customize the figures
%    Plot rules
%    a. Plots will be reploted with plotUpdate function

% Structures are pretty much object oriented. 
% 1. Exp handle (main file to save):
%    (1) Cells of Raw Data handle
%    (2) Cells of Res handle
%    (3) Cells of Plot handle
%    (4) Functions:
%        a. Import / Export data
%        b. Replace data
%        c. Res updates: given user-defined function
%        d. Save itself to the file
%        e. Quick way to update the modifications in the classdef
% 2. Raw data / Res handle: data handle
%    For each column: Name + Unit (used for plotting of xlabel)
%    Data: 
%    (*) Process of NaN: ignored processed right here.
% 3. Plot handle: a lot of default settings
%    (1) Figure: handle
%    (2) Properties
%    (3) Functions:
%        a. Add/Remove single lines
%        b. Fitting: Fit and then add lines, report fitting parameters
%        c. Add reference line
%        d. Shaded a specific area

    methods(Hidden, Access = private)
        function setDefaultProperties()
        end
    end
    
    % Public properties
    properties
        dataN
        Data
        resN
        Res
        plotsN
        Plots
        
        libName
    end
    
    methods
        function self = nnfData(varargin)
            self.dataN = 0;
            self.Data = {};
            self.resN = 0;
            self.Res = {};
            self.plotsN = 0;
            self.Plots = {};
            if nargin == 0
                self.libName = 'Untitled_Lib';
            elseif nargin == 1
                self.libName = varargin{1};
            else
                error('More than one arguments are input!')
            end
        end
        
        % Data: multiple Data handles
        function addData(self, hData)
            self.dataN = self.dataN + 1;
            self.Data{self.dataN} = hData;
        end
        function removeData(self, hDataNum)
            if (hDataNum > self.dataN || hDataNum < 1)
                error('Number exceeds range!\n')
            else
                self.dataN = self.dataN - 1;
                self.Data(hDataNum) = [];
            end
        end
        function replaceData(self, hDataNum, newhData)
            if (hDataNum > self.dataN || hDataNum < 1)
                error('Number exceeds range!\n')
            else
                self.Data(hDataNum) = newhData;
            end
        end
        function listData(self)
            for i = 1:self.dataN
                fprintf('%d: %s\n', i, self.Data{i}.fname);
            end
        end
        
        % Res: single Data handle
        function addRes(self, hRes)
            self.resN = self.resN + 1;
            self.Res{self.resN} = hRes;
        end
        function removeRes(self, hResNum)
            if (hResNum > self.resN || hResNum < 1)
                error('Number exceeds range!\n')
            else
                self.resN = self.resN - 1;
                self.Res(hResNum) = [];
            end
        end
        function replaceRes(self, hResNum, newhRes)
            if (hResNum > self.resN || hResNum < 1)
                error('Number exceeds range!\n')
            else
                self.Res(hResNum) = newhRes;
            end
        end
        function listRes(self)
            for i = 1:self.resN
                fprintf('%d: %s [%s]\n', i, self.Res{i}.vName, self.Res{i}.unit);
            end
        end
        
        % Plots: single Plots handle
        function addPlots(self, hPlots)
            self.plotsN = self.plotsN + 1;
            self.Plots{self.plotsN} = hPlots;
        end
        function removePlots(self, hPlotsNum)
            if (hDataNum > self.dataN || hDataNum < 1)
                error('Number exceeds range!\n')
            else
                self.plotsN = self.plotsN - 1;
                self.Data(hPlotsNum) = [];
            end
        end
        function listPlots(self)
            for i = 1:self.plotsN
                fprintf('%d: %s\n', i, self.Plots{i}.fname);
            end
        end
        
        function saveLib(self)
            % Used to save the obj locally, specified by the given filename
            save([self.libName, '.mat'], 'self');
        end

    end
end