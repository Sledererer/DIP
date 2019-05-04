function main
    %Figure cleanup
    close all; clc;

    %Load in images to process
    noisy_unfiltered = imread('noisy-elliptical-object.tif');
    noisy_filtered = imgaussfilt(noisy_unfiltered,4);
    lena = rgb2gray(imread('Lena.png'));
    U200 = imread('U200.tif');
    
    %Perform Otsu's
    otsu(U200)
    otsu(noisy_unfiltered)
    otsu(noisy_filtered)
    otsu(lena)
end
