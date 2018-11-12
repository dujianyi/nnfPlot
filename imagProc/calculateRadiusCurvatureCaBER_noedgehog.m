% This directly extracts the figures from image sequences
% Input parameters

imgDir = dir('*.tif');
imgDir = {imgDir.name};
N = length(imgDir);

stTime = 50;
fps = 6700;
% imshow(imgDir{stTime});

timePick = [40, 50, 60, 80, 90, 95, 100];
timePickNum = round(stTime + timePick*6700/1000);
[H, L] = size(imread(imgDir{1}));
recProf = {};
for i = 1:length(timePickNum)
    thisImage = imread(imgDir{timePickNum(i)});
    bw = edge(thisImage, 'canny', 0.5);
    figure(i)
    imshow(bw)
    thisProf = zeros(1, H);
    for j = 1:H
        thisLine = find(bw(j, :)>0);
        if ~isempty(thisLine)
            if (thisLine(end) > L/2)
                thisProf(j) = thisLine(end);
            else
                if (j > 1)
                    thisProf(j) = thisProf(j-1);
                else
                    thisProf(j) = L;
                end
                fprintf('Yes1\n');
            end
        else
            if (j == 1)
                thisProf(j) = L;
            else
                thisProf(j) = thisProf(j-1);
                fprintf('Yes2\n');
            end
        end
    end
    recProf{i} = thisProf;
end

x = linspace(-0.5, 0.5, H);
for i = 1:length(timePickNum)
    y = fliplr(recProf{i} - L/2)/(L/2);
    yf = sgolayfilt(y, 2, 15);
    recProf{i} = yf;
end

hp = nnfPlot(x, recProf{1});
for i = 2:length(timePickNum)
    hp.addPlot(x, recProf{i});
end




%{
data = dlmread('data.txt', '\t', 1, 0);

Ndata = size(data, 1);
blockInd = 1:(Ndata-1);
findBlock = find(data(blockInd, 1)> data(blockInd+1, 1));
dataProf = {};
st = 1;
for i = 1:length(findBlock)
    dataProf{i} = data((st+1):findBlock(i), :);
    st = findBlock(i) + 1;
end

dt = 1000/6700;
startT = 115; % csb
% startT = 50;  % M1
t = [0:(length(findBlock)-1)]*dt;

rad1 = zeros(1, length(findBlock));    % radial
rad2 = zeros(1, length(findBlock));    % axial
Rmid = 169;

for i = 1:length(findBlock)
    thisProf = dataProf{i};
    % check circle
    % temp = (0:0.1:400)';
    % thisProf = [temp, -temp.^2+200*temp];
    
    [minR, minRpos] = max(thisProf(:, 2));
    % plot(thisProf(:, 1), thisProf(:, 2));
    yy = sgfilterDataProc(thisProf(:, 1), thisProf(:, 2), 0:2, 3, 25);
    
    rad1(i) = Rmid - minR;
    % plot(thisProf(:, 1), thisProf(:, 2), '.', thisProf(:, 1), yy(:, 1), '-');
    % hold on;
    rad2(i)  = abs((1).^(3/2)./(yy(minRpos, 3)));
    
    cx = thisProf(minRpos, 1);
    cy = thisProf(minRpos, 2) - rad2(i);
    % viscircles([cx, cy], abs(Rmin))
    
end
%}