function [Colors] = DetectingColors(img)
org = img;
size = 0;
img = rgb2gray(img);
I = imbinarize(img,0.9);
I = ~I;
SE = strel('square',6);
I = imerode(I, SE);
[L,n]=bwlabel(I);
stat = regionprops(L,'Area','BoundingBox'); 
for k=1:n
    color = imcrop(org,stat(k).BoundingBox);
    %figure, imshow(color);
    r = color(1,1,1);
    g = color(1,1,2);
    b = color(1,1,3); 
    if r == 0 && g == 0 && b == 0
        continue;
    end
    if r >= 220 && g >= 220 && b >= 220
        continue;
    end
     size = size + 1;
end
redMean = zeros(n,1);
greenMean = zeros(n,1);
blueMean = zeros(n,1);
for k=1:n
    color = imcrop(org,stat(k).BoundingBox);
    r = color(:,:,1);
    g = color(:,:,2);
    b = color(:,:,3);
    %disp(r);
    redMean(k) = round(mean(r(:)));
    greenMean(k) = round(mean(g(:)));
    blueMean(k) = round(mean(b(:)));
end
%disp(redMean);
Colors = zeros(size,3);
i = 0;
for k=1:n
    r = redMean(k);
    g = greenMean(k);
    b = blueMean(k);
     if r == 0 && g == 0 && b == 0
        continue;
     end
     if r >= 220 && g >= 220 && b >= 220
        continue;
    end
     i = i +1;
    Colors(i,1) = r;
    Colors(i,2) = g;
    Colors(i,3) = b;
end
%disp(Colors);
end


