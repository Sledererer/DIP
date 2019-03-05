%Zac Ferris
%Stephen Lederer

function main()

    input_image = 'rose512.tif';
    threshold = 0.05;%0-1 or 'auto'
    sig = 1;%any number
    nsig = 2;%any number
    order = 'after';%'before', 'after', 'both', 'none'
    
    %Provide input image, with optional threshold, and optional
    %{sig,nsig,order}
    emap = snakeMap4e(input_image, threshold, sig, nsig, 'after');
    snakeForce4e(emap);
end
