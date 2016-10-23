% rotate image clockwised around center point (1,1), with a radius degrees 
% input1---source image: I
% input2---rotation degrees: radius (ex: pi/3)
% output---rotated image: I_rot

function I_rot = rotation(I, radius)

% RGB channel
R(:,:) = I(:,:,1);
G(:,:) = I(:,:,2);
B(:,:) = I(:,:,3);

% get height, width, channel of image
[height, width, channel] = size(I);

%% create new image
% step1. record image vertex, and use rotation matrix to get new vertex.
matrix = [cos(radius), -sin(radius) ; sin(radius), cos(radius)];
% Rotate the four vertices
vertex(1,:)=[0,0]; % upper left coner
vertex(2,:)=[width-1,0]; % upper right coner
vertex(3,:)=[0,height-1]; % lower left coner
vertex(4,:)=[width-1,height-1]; % lower right coner
% rotate the coner
vertex_new(1,:) = vertex(1,:)*transpose(matrix);
vertex_new(2,:) = vertex(2,:)*transpose(matrix);
vertex_new(3,:) =  vertex(3,:)*transpose(matrix);
vertex_new(4,:) =  vertex(4,:)*transpose(matrix);

% step2. find min x, min y, max x, max y, use "min()" & "max()" function is ok
minx= min(vertex_new(:,1));
miny= min(vertex_new(:,2));
maxx= max(vertex_new(:,1));
maxy= max(vertex_new(:,2));

% step3. consider how much to shift the image to the positive axis
x_shift = -minx;
y_shift = -miny;

% step4. calculate new width and height, if they are not integer, use
% "ceil()" & "floor()" to help get the largest width and height.
 width_new = floor(maxx - minx)+1;
 height_new = floor(maxy -miny)+1;

% step5. initial r,g,b array for the new image
 R_rot = zeros(width_new,height_new);
 G_rot = zeros(width_new,height_new);
 B_rot = zeros(width_new,height_new);

%% back-warping using bilinear interpolation
% for each pixel on the rotation image, find the correspond r,g,b value 
% from the source image, and save to R_rot, G_rot, B_rot.
        % step5. shift the new pixel (x_new, y_new) back, and rotate -radius
        % degree to get (x_old, y_old)
        
matrix2 = [cos(-radius), -sin(-radius) ; sin(-radius), cos(-radius)];
 
for y_new = 1 : height_new
     for x_new = 1 : width_new
          x_before_shifting = x_new - x_shift-1; 
          y_before_shifting= y_new - y_shift-1;
         old =  [double(x_before_shifting), double(y_before_shifting)] * transpose(matrix2);
          x_old = old(1) + 1;
          y_old = old (2)+ 1;
        % step6. using "ceil()" & "floor()" to get interpolation coordinates
        % x1, x2, y1, y2
             x1= floor(x_old);
             x2= ceil(x_old);
             y1= floor(y_old);
             y2= ceil(y_old);
        % step7. if (x_old, y_old) is inside of the source image, 
        % calculate r,g,b by interpolation.
        % else if (x_old, y_old) is outside of the source image, set
        % r,g,b = 0(black).
        if (x1 >= 1) && (x1 <= width) && (x2 >= 1) && (x2 <= width) && ...
            (y1 >= 1) && (y1 <= height)&& (y2 >= 1) && (y2 <= height) % for those on the original picture
            
            % step8. calculate weight wa, wb. Notice that if x1=x2 or y1=y2 ,
            % function "wa=()/(x1-x2)" will be fail. At this situation, you
            % need to assign a value to wa directly.
            if x1 == x2
                wa=0;
            else
                wa = (x_old-x1)/ (x2-x1);
            end
            if y1 == y2
                wb=0;
            else
                wb = (y_old-y1)/ (y2-y1);
            end
            
            % step9. calculate weight w1, w2 w3, w4 for 4 neighbor pixels. 
            w1 = (1-wa)*(1-wb);
            w2 = wa*(1-wb);
            w3 = wa*wb;
            w4 = (1-wa)*wb;
            
            % step10. calculate r,g,b with 4 neighbor point and their weight
            r=I(y1,x1,1)*w1 + I(y1,x2,1)*w2 +I(y2,x2,1)*w3 + I(y2,x1,1)*w4;
            g=I(y1,x1,2)*w1 + I(y1,x2,2)*w2 +I(y2,x2,2)*w3 + I(y2,x1,2)*w4;
            b=I(y1,x1,3)*w1 + I(y1,x2,3)*w2 +I(y2,x2,3)*w3 + I(y2,x1,3)*w4;
            
        else  % set the color black
            r = 0;
            g = 0;
            b = 0;
        end
        R_rot(y_new, x_new) = r;
        G_rot(y_new, x_new) = g;
        B_rot(y_new, x_new) = b;
    end
 end

% save R_rot, G_rot, B_rot to output image
I_rot(:,:,1) =uint8(R_rot(1:height_new,1:width_new));
I_rot(:,:,2) = uint8(G_rot(1:height_new,1:width_new));
I_rot(:,:,3) = uint8(B_rot(1:height_new,1:width_new));

