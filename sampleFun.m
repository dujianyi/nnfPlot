function y = sampleFun(paras, x)
    % This is a sample function structure. Users can take this to any function
    % that they need, but keep the features:
    % - The first two arguments needs to be (paras) and (x)
    % - The output should be y
    % - Use vector operation mode (add '.*' or '.^', etc)
    % If extra const parameters are included, use the following syntax: 
    % - In sampleFun:          function y = sampleFun(paras, x, constParas)
    % - Main window, use       paras2 = hPlot.addFitLine(1, @(paras, x) sampleFun(paras, x, constParas), [1, 1, 1]);
    y = paras(1)*sin(x+paras(2))+paras(3);
end

