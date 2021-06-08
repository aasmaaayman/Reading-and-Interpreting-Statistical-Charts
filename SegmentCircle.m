function Circlesegmented=SegmentCircle(img)
I=img;
img=rgb2gray(img);
img= img<225;
img= medfilt2(img, [16,16]);
img= edge(img,'canny');
img = bwareaopen(img,200);
img=imfill(img,'holes');
[L,~]=bwlabel(img);
stat = regionprops(L,'Area','BoundingBox'); 
[~,index] = max([stat.Area]);
Circlesegmented=imcrop(I,stat(index).BoundingBox);
%figure,imshow(Circlesegmented);
end
