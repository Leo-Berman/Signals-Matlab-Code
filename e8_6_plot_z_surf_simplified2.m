% e8_6_plot_z_surf_simplified2.m
% By David Dorran (david.dorran@dit.ie)
% downloaded from https://dadorran.wordpress.com/?s=zpgui 2/22/19
% modified 8/3/20 
% plot some 2-sided discrete geometrics
% both the inverse bilateral z transform of z/(z-2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all; set(0,'defaultAxesFontSize',14);
pole_positions_orig = [2];  
zero_positions_orig = [0];
nargin = 0; 
surface_display_opts = 0;  %value of 2 by mda, sets values outside ROC = NaN
if(nargin == 5)
    surface_display_opts = varargin{3};
end
 
%function plot_z_surface(pole_positions_orig, zero_positions_orig, varargin)
surface_limit = 3; % 1.5;  %controls grid resolution on the surface contour
plot_limit = 3; %mda -- sets the axis ranges

min_val = -surface_limit;
max_val = surface_limit;
 
%check if any of the poles or zeros fall outside the maximum values
if length(find(abs(real([pole_positions_orig zero_positions_orig])) > max_val)) || length(find(abs(imag([pole_positions_orig zero_positions_orig])) > max_val))
    error(['the real part of the complex numbers indicating the the positions of the poles and zeros must be less than ' num2str(max_val) ' and greater than -' num2str(max_val) '. Also, the imaginary part of the complex numbers indicating the the positions of the poles and zeros must be less than ' num2str(max_val) 'j and greater than -' num2str(max_val) 'j.']);
end
 
%set up the s_plane grid from -5j to 5j along the imaginary axis and -5 to
%5 along the real axis. 
surface_resolution = 0.06; %0.02;
 
a_vals = min_val:surface_resolution:max_val;
b_vals = a_vals;
grid_len = length(a_vals);
%create a grid of values along the z surface indicating position in the z-domain
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
end
 
% Since poles are denominator terms obtain an log s_plane surface for each pole and subtract each individual plane
%  since a logarithmic subtraction is equivalent to a divide i.e.
% log(a/b) = log(a)-log(b)
for k = 1 :length(pole_positions)
    z_surface = z_surface - 20*log10(abs(z_grid - pole_positions(k) ));
end

 
total_indices = 1:numel(z_grid);
temp_zero = 20*log10(abs(z_grid+.000001));
indices_outside_unit_circle = find(temp_zero > -0.2);

indices_inside_unit_circle = find(temp_zero < 0.2);
indices_on_unit_circle = intersect(indices_outside_unit_circle, indices_inside_unit_circle);
indices_not_on_unit_circle = setdiff( total_indices, indices_on_unit_circle );
positive_imaginary_indices = find(imag(z_grid) > 0 );
negative_inaginary_indices = find(imag(z_grid) < 0 );
positive_indices_outside_unit_circle = intersect(positive_imaginary_indices, indices_outside_unit_circle);
 
 
mask = ones(size(z_surface));
if(surface_display_opts == 1)
    mask_indices = indices_not_on_unit_circle;
elseif  (surface_display_opts == 2)  %added by mda 2/23/19 to display only ROC
    mask_indices = indices_inside_unit_circle;
else
    mask_indices = [];
end
mask(mask_indices) = NaN;
colors = z_surface;
%colors(indices_on_unit_circle) = 40;
%colors(indices_on_unit_circle) = 80;
mesh(a_vals,b_vals,z_surface.*mask, colors)
%surfl(a_vals,b_vals,z_surface.*mask), colormap(spring); %, colors);
%sl.EdgeColor = 'none';
set(gca,'YTick',[min_val:max_val])
set(gca,'YTickLabel',[min_val:max_val]')
set(gca,'XTick',[min_val:max_val])
set(gca,'XTickLabel',[min_val:max_val]')

xlh = ylabel('Im');
ylh =xlabel('Re');
zlh = zlabel('|X(z)| (dB) ');

axis([-plot_limit plot_limit -plot_limit plot_limit -30 30]) 
axis square,grid on%,box on