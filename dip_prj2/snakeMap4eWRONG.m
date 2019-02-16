function emap = snakeMap4e(F,varargin)

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
    %outIMG = edge(inIMG,'Sobel');
    Gmag = imgradient(inIMG,'Sobel');
    
    imshow(Gmag)
    
elseif nargin == 2
    %Validate ImageName Argument
    validateattributes(F,{'char'},{'nonempty'})
    
    %Validate Threshold Argument
    threshold = str2double(varargin(1));
    if isnan(threshold)
        threshold = string(varargin(1));
        validatestring(threshold,"auto");
        auto = true;
    else
        validateattributes(threshold,{'double'},{'>=',0.0,'<=',1.0})
        auto = false;
    end
       
    % EMAP is thresholded so
    % that,at any point,EMAP=1 if EMAP>T,and it is zero
    % otherwise. If T is the string 'auto', thresholding is done
    % automatically. Otherwise, T is expected to be a number in the
    % range [0,1].
    
    inIMG = imread(F);
    Gmag = imgradient(inIMG,'Sobel');
    
    %THRESHOLD
    if auto == true
        edthresh = edge(Gmag,'Sobel');
    else
        edthresh = edge(Gmag,'Sobel',threshold);
    end
    
    figure, imshow(edthresh) , title('Threshold')
    
elseif nargin == 5
    %Validate ImageName Argument
    validateattributes(F,{'char'},{'nonempty'});
    
    %Validate Threshold Argument
    threshold = str2double(varargin(1));
    
    if isnan(threshold)
        threshold = string(varargin(1));
        validatestring(threshold,"auto");
        auto = true;%boolean for later comparison in order
    else
        validateattributes(threshold,{'double'},{'>=',0.0,'<=',1.0});
        auto = false;
    end
    
    %Validate SIG Argument
    sig = cell2mat(varargin(2));
    validateattributes(sig,{'double'},{'positive','nonzero'});
    
    %Validate NSIG Argument
    nsig = cell2mat(varargin(3));
    validateattributes(nsig,{'double'},{'positive','nonzero'});
    
    %Validate Order Argument
    order = string(varargin(4));
    validatestring(order,["before","after","both", "none"]);
    
    %Input Image
    inIMG = imread(F);
    
    %Gaussian lowpass filter. Not recommended. Use imgaussfilt or imgaussfilt3 instead.
    % Gaussian filter with size = [NSIG*SIG NSIG*SIG] and sigma = SIG
    Gaus = fspecial('gaussian',[nsig*sig, nsig*sig],sig);
    
    if order == "before"
        %blur -> gradient -> MOG -> threshold
   
        %BLURRING 
        % Apply Gaussian Filter (Pre)
        blur = imfilter(inIMG,Gaus);
    
        %MAGNITUDE OF THE GRADIENT (MOG)
        Gmag = imgradient(blur,'Sobel');
        
        %THRESHOLD
        %Check for auto    
        if auto == true
            edbef = edge(Gmag,'Sobel');
        else
            edbef = edge(Gmag,'Sobel',threshold);
        end
        
        figure, imshow(edbef) , title('Before')
        %imshow(Gmag);
        %title('Gradient Magnitude, Gmag')
        
    elseif order == "after"
        %gradient -> MOG -> threshold -> blur
        
        %MAGNITUDE OF THE GRADIENT (MOG)
        Gmag = imgradient(inIMG,'Sobel');
    
        %THRESHOLD
        %Check for auto
        if auto == true
            edaft = edge(Gmag,'Sobel');
        else
            edaft = edge(Gmag,'Sobel',threshold);
        end
        
        %BLURRING (Pre)
        % Apply Gaussian Filter
        blur = imfilter(edaft,Gaus);
        
        figure, imshow(blur) , title('After')
        
    elseif order == "both"
        %blur -> gradient -> MOG -> threshold -> blur
        
        %BLURRING 
        % Apply Gaussian Filter
        blur = imfilter(inIMG,Gaus);       
        
        %MAGNITUDE OF THE GRADIENT (MOG)
        Gmag = imgradient(blur,'Sobel');
        
        %THRESHOLD
        %Check for auto
        if auto == true
            edboth = edge(Gmag,'Sobel');
        else
            edboth = edge(Gmag,'Sobel',threshold);
        end
        
        %BLURRING (Post)
        % Apply Gaussian Filter
        blur = imfilter(edboth,Gaus);
        
        figure, imshow(blur) , title('Both')
        
    elseif order == "none"
        %gradient -> MOG -> threshold
        
         %MAGNITUDE OF THE GRADIENT (MOG)
        Gmag = imgradient(inIMG,'Sobel');
    
        %THRESHOLD
        %Check for auto
        if auto == true
            edaft = edge(Gmag,'Sobel');
        else
            edaft = edge(Gmag,'Sobel',threshold);
        end
        
        figure, imshow(edaft) , title('None')
        
    else
        error('Unexpected order')
    end
    
    %BLURRING 
    % Apply Gaussian Filter (Pre)
    %Pre = imfilter(inIMG,Gaus);
    
    %AUTO THRESHOLDING
    %Edge (no-filter)
    %edno = edge(inIMG,'Sobel');
    
    %edpre = edge(Pre,'Sobel');
    
    %edpost = imfilter(edno,Gaus);
    
    %figure, imshow(edno) , title('No Blur')
    %figure, imshow(edpre), title('Pre-Blur')
    %figure, imshow(edpost) , title('Post-Blur')

    
else
    disp('Invalid Number of Arguments Supplied')
end




end
