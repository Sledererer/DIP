function [x, y] = snake_manual_input(np)
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
