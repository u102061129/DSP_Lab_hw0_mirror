close;
clear all;
clc;

%% read image
filename = 'image.jpg';     % image from TA
I = imread(filename);
filename = 'mine.jpg';       % my image
II = imread(filename);
%figure('name', 'source image');
%imshow(I);

%% ----- pre-lab ----- %%
% output = function(input1, input2, ...);
%grey_scale function
I2 = grey_scale(I);
II2 = grey_scale(II);

%% ----- homework lab ----- %%
% flip function
I3 = flip(I,0);
I4 = flip(I,1);
I5 = flip(I,2);
II3 = flip(II,0);
II4 = flip(II,1);
II5 = flip(II,2);

% rotation function
I6 = rotation(I, pi/4);
I7 = rotation(I,pi/2);
I8 = rotation(I,4*pi/5);
II6 = rotation(II, pi/4);
II7 = rotation(II,pi/2);
II8 = rotation(II,4*pi/5);

%% show image
%figure('name', 'grey scale image'),
%imshow(I2);

%% write image
% save image for your report
% grey
filename = 'I_grey.jpg';
imwrite(I2, filename);
filename = 'II_grey.jpg';
imwrite(II2, filename);
% flip
filename = 'I_horizontal_flipping.jpg';
imwrite(I3, filename);
filename = 'I_vertical_flipping.jpg';
imwrite(I4, filename);
filename = 'I_horizontal_vertical_flipping.jpg';
imwrite(I5, filename);
filename = 'II_horizontal_flipping.jpg';
imwrite(II3, filename);
filename = 'II_vertical_flipping.jpg';
imwrite(II4, filename);
filename = 'II_horizontal_vertical_flipping.jpg';
imwrite(II5, filename);
% rotate
filename = 'I_rotate_45.jpg';
imwrite(I6, filename);
filename = 'I_rotate_90.jpg';
imwrite(I7, filename);
filename = 'I_rotate_144.jpg';
imwrite(I8, filename);
filename = 'II_rotate_45.jpg';
imwrite(II6, filename);
filename = 'II_rotate_90.jpg';
imwrite(II7, filename);
filename = 'II_rotate_144.jpg';
imwrite(II8, filename);



