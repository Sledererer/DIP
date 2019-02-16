%Zac Ferris
%Stephen Lederer

function main()

    imageName = 'rose512.tif';
    treshold = 0.05;
    sig = 1;
    nsig = 2;
    
    % (a) no blurring and without thresholding
    example_a = snakeMap4e(imageName);
    figure, imshow(example_a) , title('No Blurring and Without Thresholding')
    
    % (b) blurring of image before computing emap
    example_b = snakeMap4e(imageName,treshold,sig,nsig,'before');
    figure, imshow(example_b) , title('Blurring of Image Before Computing EMAP')
    
    % (c) blurring of the MOG after computing emap
    example_c = snakeMap4e(imageName,treshold,sig,nsig,'after');
    figure, imshow(example_c) , title('Blurring of the MOG After Computing EMAP')
    
    % (d) blurring of image before computing emap and blurring after computing the MOG for emap
    example_d = snakeMap4e(imageName,treshold,sig,nsig,'both');
    figure, imshow(example_d) , title('Bluring of Image Before & After Computing EMAP')
    
    % (e) no blurring but given a threshold a priori
    example_e = snakeMap4e(imageName,treshold);
    figure, imshow(example_e) , title('No Bluring With Non-Automatic Thresholding')
    
    % (f) allow an automatic threshold but do not blur
    example_f = snakeMap4e(imageName,'auto');
    figure, imshow(example_f) , title('No Bluring With Automatic Thresholding')
