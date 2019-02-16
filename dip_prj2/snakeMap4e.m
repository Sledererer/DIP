function emap = snakeMap4e(F,varargin)

if nargin == 1
    %Validate ImageName Argument
    validateattributes(F,{'char'},{'nonempty'})
    
    %Emap is produced without thresholding and without blurring
    inIMG = imread(F);
    %outIMG = edge(inIMG,'Sobel');
    Gmag = imgradient(inIMG,'Sobel');
    
    emap = Gmag;
    
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
    
    %THRESHOLD
    if auto == true
        edthresh = edge(inIMG,'Sobel');
    else
        edthresh = edge(inIMG,'Sobel',threshold);
    end
    
    emap = edthresh;
    
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
        
        %THRESHOLD
        %Check for auto    
        if auto == true
            edbef = edge(blur,'Sobel');
        else
            edbef = edge(blur,'Sobel',threshold);
        end
        
        emap = edbef;
        
    elseif order == "after"
        %gradient -> MOG -> threshold -> blur
           
        %THRESHOLD
        %Check for auto
        if auto == true
            edaft = edge(inIMG,'Sobel');
        else
            edaft = edge(inIMG,'Sobel',threshold);
        end
        
        %BLURRING (Pre)
        % Apply Gaussian Filter
        blur = imfilter(edaft,Gaus);
        
        emap = blur;
        
    elseif order == "both"
        %blur -> gradient -> MOG -> threshold -> blur
        
        %BLURRING 
        % Apply Gaussian Filter
        blur = imfilter(inIMG,Gaus);       
        
        %THRESHOLD
        %Check for auto
        if auto == true
            edboth = edge(blur,'Sobel');
        else
            edboth = edge(blur,'Sobel',threshold);
        end
        
        %BLURRING (Post)
        % Apply Gaussian Filter
        blur = imfilter(edboth,Gaus);
        
        emap = blur;
        
    elseif order == "none"
        %gradient -> MOG -> threshold
    
        %THRESHOLD
        %Check for auto
        if auto == true
            edaft = edge(inIMG,'Sobel');
        else
            edaft = edge(inIMG,'Sobel',threshold);
        end
        
        emap = edaft;
     
    else
        error('Unexpected order')
    end
    
else
    disp('Invalid Number of Arguments Supplied')
end

end