function heights=SegmentBar(img)
I=img;
img=imadjust(img,[.2 .3 0;.6 .7 1],[]);
img = im2bw(img,0.95);
img = medfilt2(img, [11,11]);
img = edge(img,'canny');
img = bwareaopen(img,200);
img=imfill(img,'holes');
img = bwareaopen(img,500);
[L,n]=bwlabel(img);
heights=zeros(n,1);
stat = regionprops(L,'Area','BoundingBox'); 
for k = 1 : n
    Icropped = imcrop(I,stat(k).BoundingBox);
    [heights(k),~]=size(Icropped);
end
end