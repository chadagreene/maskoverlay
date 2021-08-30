function h = maskoverlay(x,y,tf,varargin)
% maskoverlay overlays a gridded mask. 
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
% maskoverlay(x,y,tf) overlays a mask that is black wherever tf is true and
% transparent wherever tf is false. 
% 
% maskoverlay(...,'color',rgb) colors the mask by an RGB triplet (values in the
% range of 0 to 1.)
%
% maskoverlay(...,'alpha',alpha) sets the mask transparency to a value between 0
% (invisible) to 1 (opaque). 
%
% h = maskoverlay(...) returns a handle h of the image object. 
% 
%% Example: 
% 
% % Plot some data as pseudocolor: 
% pcolor(-3:3,-3:3,magic(7))
%  
% % Load some example data we'll use to create masks: 
% [X,Y,Z] = peaks(500); 
% x = X(1,:); 
% y = Y(:,1); 
% 
% % Overlay an opaque black mask wherever Z is greater than 3: 
% maskoverlay(x,y,Z>3) 
% 
% % Overlay a semitransparent red mask wherever Z is less than -2: 
% maskoverlay(X(1,:),Y(:,1),Z<-2,'color',[1 0 0],'alpha',0.5);
% 
%% Author Info 
% Written by Chad A. Greene of NASA/Jet Propulsion Laboratory 
% August 2021. 
% 
% See also: image and imagesc. 

%% Input checks: 

narginchk(3,Inf)
assert(islogical(tf),'Error: tf must be a logical mask.') 
assert(isvector(x) & isvector(y),'Error: inputs x and y must be 1D vectors.') 
assert(length(x)==size(tf,2) & length(y)==size(tf,1),'Error: dimesions of tf must match x and y.')

% Set defaults: 
alpha = 1; 
color = [0 0 0]; 

% Overwrite defaults: 
if nargin>3 
   tmp = strncmpi(varargin,'alpha',3); 
   if any(tmp)
      alpha = varargin{find(tmp)+1}; 
      assert(isscalar(alpha) & alpha>=0 & alpha<=1,'Input alpha must be a scalar in the range of 0 to 1.') 
   end
   
   tmp = strncmpi(varargin,'color',3); 
   if any(tmp)
      color = varargin{find(tmp)+1}; 
      assert(numel(color)==3,'Input color must be an 3 element array for RGB in the range of 0 to 1.') 
   end
end

%%

% Create a color mask so it doesn't hijack the colormap: 
M = cat(3,...
   uint8(color(1)*255*tf),...
   uint8(color(2)*255*tf),...
   uint8(color(3)*255*tf)); 

hld = ishold; 
hold on
h = image(x,y,M); 
h.AlphaData = alpha*tf; 

%% Clean up: 

% Return hold state: 
if ~hld
   hold off
end

if nargout==0
   clear 
end


end