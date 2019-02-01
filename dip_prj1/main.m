%Group Members:
%Zac Ferris
%Stephen Lederer

function main(f, np, style)
%STYLE is a character string made from one element from
%   any or all the following 3 columns:
%
%            b     blue          .     point           -     solid
%            g     green         o     circle          :     dotted
%            r     red           x     x-mark          -.    dashdot 
%            c     cyan          +     plus            --    dashed   
%            m     magenta       *     star          (none)  no line
%            y     yellow        s     square
%            k     black         d     diamond
%            w     white         v     triangle (down)
%                                ^     triangle (up)
%                                <     triangle (left)
%                                >     triangle (right)
%                                p     pentagram
%                                h     hexagram
%                           
%
%   Thus, a symbol from the first column gives the color, the second
%   the symbol used in the plot, and the third specified the type of
%   line used to join the points in the plot. For example, to plot
%   red circles joined by dotted lines we speficify the string
%   'ro:'. To plot just red circles without any connecting lines we
%   specify the string 'ro'. The default MATLAB plot is black points
%   joined by black solid lines. The default for the present
%   function is black dots with no lines.

disp(' ')
disp('PRESS ANY KEY TO BEGIN DATA ENTRY. SELECT POINTS WITH THE MOUSE.')
disp('PRESS RETURN TO TERMINATE DATA ENTRY.')
disp(' ')
pause;

% Default black image
im = ones(512)*0;

% Display image if provided or black by default
if(f == "")
    figure, imshow(im);
else
    figure, imshow(f)
end

[x,y] = snake_manual_input(np);

% Close the current figure.
close gcf

% Display the figure with the snake supoperimposed on it.
if(f == "")
    figure, imshow(im);
else
    figure, imshow(f)
end

hold on
snake_display(y, x, style)
hold off
