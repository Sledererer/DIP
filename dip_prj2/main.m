function main(F,varargin)

%Input Validation

%T:     [0-1] or ‘auto’
%SIG:   Positive Integer
%NSIG:  Positive Integer
%Order: ‘before’,’after’,’both’,’none’(default)

if nargin == 1
    %Validate ImageName Argument
    validateattributes(F,{'char'},{'nonempty'})
    
    %Emap is produced without thresholding and without blurring
    inIMG = imread(F);
    outIMG = edge(inIMG,'Sobel');
    
    
    
    imshow(Ig)
    
elseif nargin == 2
    %Validate ImageName Argument
    validateattributes(F,{'char'},{'nonempty'})
    
    %Validate Threshold Argument
    threshold = str2double(varargin(1));
    if isnan(threshold)
        threshold = string(varargin(1));
        validatestring(threshold,"auto")
    else
        validateattributes(threshold,{'double'},{'>=',0.0,'<=',1.0})
    end
    
    % EMAP is thresholded so
    % that,at any point,EMAP=1 if EMAP>T,and it is zero
    % otherwise. If T is the string 'auto', thresholding is done
    % automatically. Otherwise, T is expected to be a number in the
    % range [0,1].
    
elseif nargin == 5
    %Validate ImageName Argument
    validateattributes(F,{'char'},{'nonempty'})
    
    %Validate Threshold Argument
    threshold = str2double(varargin(1));
    
    if isnan(threshold)
        threshold = string(varargin(1));
        validatestring(threshold,"auto")
    else
        validateattributes(threshold,{'double'},{'>=',0.0,'<=',1.0})
    end
    
    %Validate SIG Argument
    sig = cell2mat(varargin(2));
    validateattributes(sig,{'double'},{'positive','nonzero'})
    
    %Validate NSIG Argument
    nsig = cell2mat(varargin(3));
    validateattributes(nsig,{'double'},{'positive','nonzero'})
    
    %Validate Order Argument
    order = string(varargin(4));
    validatestring(order,["before","after","both", "none"])
    
    %Input Image
    inIMG = imread(F);
    
    % Gaussian filter with size = [NSIG*SIG NSIG*SIG] and sigma = SIG
    Gaus = fspecial('gaussian',[nsig*sig, nsig*sig],sig);
    
    
    % Apply Gaussian Filter (Pre)
    Pre = imfilter(inIMG,Gaus);
    
    %Edge (no-filter)
    edno = edge(inIMG,'Sobel');
    
    edpre = edge(Pre,'Sobel');
    
    edpost = imfilter(edno,Gaus);
    
    figure, imshow(edno) , title('No Blur')
    figure, imshow(edpre), title('Pre-Blur')
    figure, imshow(edpost) , title('Post-Blur')

    
else
    disp('Invalid Number of Arguments Supplied')
end




end
