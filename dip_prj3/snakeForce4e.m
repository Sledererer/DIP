function [Fx,Fy] = snakeForce4e(emap,mode,mu,niter)
% [Fx,Fy] = SNAKEFORCE4E(EMAP,MODE,MU,NITER) uses input edge 
% map, EMAP, to derive force images Fx and Fy. These images are of 
% the same size as EMAP and contain the x and y force components 
% at ALL points of EMAP. For examnple, Fx(i,j) is the x-component
% of the force at coordinates (i,j) of EMAP. If MODE = 'gradient',
% (the default) force components Fx and Fy of the gradient of
% EMAP is computed (remember, the gradient is a 2-D vector). This 
% mode does not require MU nor NITER. If MODE = 'gvf' then the
% force is based on the gradient vector flow of the edge map [see
% Eqs. (11-55) and (11-56)]. Option 'gvf' requires that MU and the
% number of iterations, NITER, be provided.

% Valid Inputs:
%   EMAP    = an image
%   MODE    = 'gradient' (default), 'gvf'
%   MU      = Only needed if mode is 'gvf'
%   NITER   = number of iterations (only needed if mode = 'gvf')

% Default to 'gradient' mode
    if nargin == 1
        
        [Fx, Fy] = gradient(double(emap));
        Fx = flipud(Fx);
        Fy = flipud(Fy);
        
        figure, imshow(emap)
        figure, quiver(Fx,Fy)

    end

end

