function Numberofconnectedcomp=Checkinput(img)
I = imread(img);
img=rgb2gray(I);
img= img<225;
img= medfilt2(img, [16,16]);
img= edge(img,'canny');
img = bwareaopen(img,200);
[~,Numberofconnectedcomp]=bwlabel(img);
if(Numberofconnectedcomp>1)
bar_chart(I);
else
pie_chart(I);
end
end



