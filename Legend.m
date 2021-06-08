function imCrop = Legend(I)
Igray =im2bw(I,0.95);
se=strel('square',25);
Imorph=imdilate(Igray,se);
Imorph=imerode(Imorph,se);
[rows, columns, ~] = size(Imorph);
for i=1:rows
    for j=1:columns
       if i<=2 || j<=2
          Igray(i,j)=1;  
       end
       if Imorph(i,j)==0
           Igray(i,j)=1;  
           
       end
    end
end
% Detect black line
BW = Igray < 1;
% Detect rectangle region (inside the line)
BW = imclearborder(~BW);
BW = bwareafilt(BW,1);
% Calculate bounding box
s = regionprops(BW,'BoundingBox');
% Crop the image
imCrop = imcrop(I,s.BoundingBox);
[rows, columns, ~] = size(imCrop);
x = 1; %sort on y
if abs(rows - columns) > 200
    x = 0; %sort on x
end

for i=1:rows
    for j=1:columns
        if i >= rows - 5 || j >= columns - 5 
          imCrop(i,j,1)=255;  
          imCrop(i,j,2)=255;  
          imCrop(i,j,3)=255;  
       end
    end
end
%figure, imshow(imCrop);
imCropBin = im2bw(imCrop,0.94);
imCropBin = imresize(imCropBin, 3);
resizedImg = imresize(imCrop, 3);
orgResImg = resizedImg;
%resizedImg=imCrop;
resizedImg = im2bw(resizedImg, 0.90);
BW = ~resizedImg;
SE = strel('rectangle',[20 20]);
textWithNoise = imerode(BW, SE);
%figure, imshow(textWithNoise);
textWithNoise = imdilate(textWithNoise, SE);
textWithNoise = abs(BW - textWithNoise);
textWithNoise = bwareaopen(textWithNoise,100);
SE = strel('rectangle',[15 18]);
textWithNoise = imdilate(textWithNoise, SE);
[L n]=bwlabel(textWithNoise);
s = regionprops(L,'BoundingBox');
bboxes = vertcat(s(:).BoundingBox);
[~,ordY] = sort(bboxes(:,2));
bboxes = bboxes(ordY,:);

s = regionprops(L,'BoundingBox');
bboxes = vertcat(s(:).BoundingBox);
[~,ordX] = sort(bboxes(:,1));
bboxes = bboxes(ordX,:);

 for k = 1 : n
     %rectangle('position',s(k).BoundingBox,'Edgecolor','g');
     %figure, imshow(textWithNoise);
     if x == 1
         imCropped=imcrop(orgResImg,s(ordY(k)).BoundingBox);
     else 
         imCropped=imcrop(orgResImg,s(ordX(k)).BoundingBox);
     end
     figure, imshow(imCropped);
 end

end
