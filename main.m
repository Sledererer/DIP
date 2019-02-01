function main(f, np, style)

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
