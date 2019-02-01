function [x, y] = snake_manual_input(f, np, style)
%SNAKE_MANUAL_INPUT Manual input of initial snake.
%   [X, Y] = SNAKE_MANUAL_INPUT(F, NP, STYLE) generates the (x,y)
%   coordinates on an np-point initial snake for a region of image
%   F. The user inputs vertices manually and then this function
%   generates points in between the vertices so that the snake has
%   NP equally-spaced points. When the function is called, it
%   outputs the instructions for inputting the vertices. The
%   snake coordinates, [x, y] form a closed polygon. 
%
%   STYLE is a character string made from one element from any or
%   all the following 3 columns:
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
%   is the symbol used in the plot, and the third specifies the type
%   of line used to join the points in the plot. For example, to
%   plot red circles joined by straight lines we specify the string
%   'ro-'. To plot just red circles without any connecting lines we
%   specify the string 'ro'. The default MATLAB plot is black points
%   joined by black solid lines. The default for the present
%   function is black dots with no lines.

disp(' ')
disp('PRESS ANY KEY TO BEGIN DATA ENTRY. SELECT POINTS WITH THE MOUSE.')
disp('PRESS RETURN TO TERMINATE DATA ENTRY.')
disp(' ')
pause;
figure, imshow(f)

% Get points interactively. Function myginput is a 3rd-party
% function included in the book support package.
[c, r] = myginput; 
x = r;
y = c;

% Add one more point to close the snake.
x(numel(x) + 1) = x(1);
y(numel(y) + 1) = y(1);

% Interpolate to get np, equally spaced (in terms of arc distance)
% points. Note the order in which x and y are input. Function
% interparc is a 3rd-party function included in the book support
% package.
p = interparc(np, y, x, 'linear'); 
% Remember: In the book, (x, y) = (r, c) but interparc outputs
% values as (c, r);
x = p(:,2); 
y = p(:,1);

% Close the current figure.
close gcf

% Display the figure with the snake supoperimposed on it.
figure, imshow(f)
hold on
plot(y, x, style)
hold off
