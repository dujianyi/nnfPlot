function [output] = sgfilterDataProc(x, y, p, ord, nplum)

    output = [];
    
    [b, g] = sgolay(ord, nplum);
    
    dx = x(end) - x(end-1);
    for i = 1:length(p)
        output(:, i) = conv(y, factorial(p(i))/(-dx).^(p(i)) * g(:, p(i)+1), 'same');
    end

end

%{
    x = weaklyelasticS1.Timems;
    y = weaklyelasticS1.Diameter;

    dt = (1000/6700);

    figure(1)
    for i = 2:5
        [b, g] = sgolay(i, 25);

        yy = conv(y, 1*g(:, 1),       'same');
        dy = conv(y, 1/(-dt)*g(:, 2), 'same');


        plot(x, -2*dy./yy, '-');
        hold on;
    end
    legend({'2', '3', '4', '5'})
    hold off;

    figure(10)
    snrcal = [];
    for i = 5:20:85
        [b, g] = sgolay(2, i);

        yy = conv(y, 1*g(:, 1),       'same');
        dy = conv(y, 1/(-dt)*g(:, 2), 'same');


        plot(x, -2*dy./yy, '-');
        hold on;
        nanind = find(~isnan(yy));
        snrcal = [snrcal, sum((y(nanind)-yy(nanind)).^2)/length(nanind)];
    end
    legend({'5', '25', '45', '65', '85'})
    figure(2)
    plot(snrcal)
%}