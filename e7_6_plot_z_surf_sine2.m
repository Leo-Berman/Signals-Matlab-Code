% file: e7_6_plot_z_surf_sine2.m   
% By David Dorran (david.dorran@dit.ie)
% downloaded from https://dadorran.wordpress.com/?s=zpgui  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all;
%pole_positions_orig=[i -i]; %[-i i] for x[n] = sin(n*pi/2), [1/sqrt(2)+ i/sqrt(2)  1/sqrt(2)- i/sqrt(2)] 
pole_positions_orig=[(1.2+ 1.2i)  (1.2- 1.2i)]; % for x[n] = sin(n*pi/4),  
%pole_positions_orig=[(0.9+ 0.9i)  (0.9- 0.9i)]; % for x[n] = 1.27*sin(n*pi/4),  
%pole_positions_orig=[(0.5+ 0.5i)  (0.5- 0.5i)]; % for x[n] = 0.7*sin(n*pi/4), 

zero_positions_orig = [];
nargin = 0;

surface_display_opts = 2;  %value 0 graphs all points, value 1 shows unit circle
%surface_display_opts = 0;  %value of 2 by mda, sets values outside ROC = NaN
  %value of 3 by mda, sets values outside ROC very high to make a cylinder
if(nargin == 5)
    surface_display_opts = varargin{3};
end
 
%function plot_z_surface(pole_positions_orig, zero_positions_orig, varargin)
surface_limit = 3; % 1.5;  %controls grid resolution on the surface contour
plot_limit =3; %mda -- sets the axis ranges
surface_resolution = 0.02; %0.02;

min_val = -surface_limit;
max_val = surface_limit;
 

%CameraPos=[-1  -1  1.5];
CameraPos=[-3 -3  1];
%CameraUpVec=[-0.1237    0.5153   23.1286];
%CameraUpVec=[1    1   1];
CameraUpVec=[0.1    0.1   0.1];

CameraPos=[-25  -25.7111 39.3541];

CameraUpVec=[-0.1    -0.1   23.1286];

if(nargin >2 )
   CameraPos= varargin{1};
    CameraUpVec=varargin{2}; 
end

%check if any of the poles or zeros fall outside the maximum values
%specified
if length(find(abs(real([pole_positions_orig zero_positions_orig])) > max_val)) || length(find(abs(imag([pole_positions_orig zero_positions_orig])) > max_val))
    error(['the real part of the complex numbers indicating the the positions of the poles and zeros must be less than ' num2str(max_val) ' and greater than -' num2str(max_val) '. Also, the imaginary part of the complex numbers indicating the the positions of the poles and zeros must be less than ' num2str(max_val) 'j and greater than -' num2str(max_val) 'j.']);
 
end
 
%set up the s_plane grid from -5j to 5j along the imaginary axis and -5 to
%5 along the real axis. A resolution of 0.02 provides a visually pleasing
%plot

 
a_vals = min_val:surface_resolution:max_val;
b_vals = a_vals;
grid_len = length(a_vals);
%create a grid of values along the z surface indicating position on
%the z-domain
ones_vector = ones(1, grid_len);
z_grid = ones_vector'*a_vals + (fliplr(b_vals*j))'*ones_vector;
 
%round all the poles and zeros to 1 decimal place because of resolution limitation
%Also, add .01+0.01j to each pole and zero position so that they are positioned in the
%center of a grid square of the z-surface created above. This ensures that
%the all the poles and zeros appear the same on the z-surface given the
%resolution constraints
pole_positions = round(pole_positions_orig*10)/10 + surface_resolution/2+(surface_resolution/2)*j;
zero_positions = round(zero_positions_orig*10)/10 +surface_resolution/2 +(surface_resolution/2)*j;
 
z_surface = zeros(length(a_vals)); % initialise the s_surface
% Since zeros are numerator terms obtain an log s_plane surface for each zero and add each individual plane
%  since a logarithmic addition is equivalent to a multiply i.e.
% log(a.b) = log(a)+log(b)
 
for k = 1 : length(zero_positions)
    z_surface = z_surface + 20*log10(abs(z_grid - zero_positions(k)));
%    transfer_function_numerator = [transfer_function_numerator '(s-' num2str(zero_positions_orig(k)),')'];
end
 
% Since poles are denominator terms obtain an log s_plane surface for each pole and subtract each individual plane
%  since a logarithmic subtraction is equivalent to a divide i.e.
% log(a/b) = log(a)-log(b)
transfer_function_denominator = [];
for k = 1 :length(pole_positions)
    z_surface = z_surface - 20*log10(abs(z_grid - pole_positions(k) ));
 
%    transfer_function_denominator = [transfer_function_denominator '(z-' num2str(pole_positions_orig(k)),')'];
end
 
total_indices = 1:numel(z_grid);
temp_zero = 20*log10(abs(z_grid+.000001));
indices_outside_unit_circle = find(temp_zero > -0.3);

indices_inside_unit_circle = find(temp_zero < 0);
% mda attempt to draw unit circle, failed: indices_inside_unit_circle = find(temp_zero < -1);
indices_on_unit_circle = intersect(indices_outside_unit_circle, indices_inside_unit_circle);
indices_not_on_unit_circle = setdiff( total_indices, indices_on_unit_circle );
positive_imaginary_indices = find(imag(z_grid) > 0 );
negative_inaginary_indices = find(imag(z_grid) < 0 );
positive_indices_outside_unit_circle = intersect(positive_imaginary_indices, indices_outside_unit_circle);
 

mask = ones(size(z_surface));
if(surface_display_opts == 1)
    mask_indices = indices_not_on_unit_circle;
    mask(mask_indices) = NaN;
elseif(surface_display_opts == 2)  %added by mda 2/23/19 to display only ROC
    mask_indices = indices_inside_unit_circle;
    mask(mask_indices) = NaN;
else
    mask_indices = [];
end
%mask(mask_indices) = NaN;

if(surface_display_opts == 3)  %added by mda 2/23/19 to display non-ROC as large #
    z_surface(indices_inside_unit_circle) = 30;
end

colors = z_surface.*5;  %scale colors (mda) (DOESN'T WORK -- colors used by mesh but not surfl()
colors(indices_on_unit_circle) = 50;  %40 is yellow line for circle
%colors(indices_on_unit_circle) = -30;
%masked_surface= z_surface.*mask;
%mesh(a_vals,b_vals,z_surface.*mask, colors)

%surfl(a_vals,b_vals,z_surface.*mask, colors)
surfl(a_vals,b_vals,z_surface.*mask)

set(gca,'YTick',[min_val:max_val])
set(gca,'YTickLabel',[min_val:max_val]')
set(gca,'XTick',[min_val:max_val])
set(gca,'XTickLabel',[min_val:max_val]')
set(gca,'CameraPosition',CameraPos);
set(gca,'CameraUpVector',CameraUpVec);

%colormap and shading apply only for surfl() funtion, not for mesh()
%colormap default  % change color map
%colormap winter  % change color map
shading interp    % interpolate colors across lines and faces

xlh = ylabel('Im');
ylh =xlabel('Re');
zlh = zlabel('|X(z)| dB');

% axis([-1.1 1.1 -1.1 1.1 -30 30]) 
axis([-plot_limit plot_limit -plot_limit plot_limit -30 20]) 
axis square
grid on
box on