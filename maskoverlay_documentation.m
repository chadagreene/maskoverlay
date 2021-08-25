%% |maskoverlay| documentation
% |maskoverlay overlays| a gridded mask. 
% 
%% Syntax 
% 
%  maskoverlay(x,y,tf) 
%  maskoverlay(...,'color',rgb) 
%  maskoverlay(...,'alpha',alpha) 
%  h = maskoverlay(...) 
%
%% Description 
% 
% |maskoverlay(x,y,tf)| overlays a mask that is black wherever |tf| is true and
% transparent wherever |tf| is false. 
% 
% |maskoverlay(...,'color',rgb)| colors the mask by an RGB triplet (values in the
% range of 0 to 1.)
%
% |maskoverlay(...,'alpha',alpha)| sets the mask transparency to a value between 0
% (invisible) to 1 (opaque). 
%
% |h = maskoverlay(...)| returns a handle |h| of the image object. 
% 
%% Example: 
% Plot some data as pseudocolor: 

pcolor(-3:3,-3:3,magic(7))
 
%% 
% Load some example data we'll use to create masks: 

[X,Y,Z] = peaks(500); 
x = X(1,:); 
y = Y(:,1); 

% Overlay an opaque black mask wherever Z is greater than 3: 
maskoverlay(x,y,Z>3) 

%%
% Overlay a semitransparent red mask wherever Z is less than -1: 

maskoverlay(x,y,Z<-1,'color',[1 0 0],'alpha',0.5);

%% Author Info 
% Written by Chad A. Greene of NASA Jet Propulsion Laboratory, August 2021. 