function chartCount= barchartheights(I,heightsBar)
%clear all;
[rows, columns, ~] = size(I) ;
Cropdedimage = I(:,2:floor(columns/10),:);
my_image = imresize(Cropdedimage, 3);
BW = imbinarize(rgb2gray(my_image));
BW1 = imdilate(BW,strel('disk',6));
s = regionprops(BW1,'BoundingBox');
bboxes = vertcat(s(:).BoundingBox);
[~,ord] = sort(bboxes(:,2));
bboxes = bboxes(ord,:);
BW = imdilate(BW,strel('disk',1));
%figure, imshow(~BW);
ocrResults = ocr(~BW,'CharacterSet','.0123456789','TextLayout','Block');
words = [ocrResults(:).Text];
words = deblank(words);
simboles = '\leftarrow';
cleand_numbers = str2num(erase(words,simboles));
n=size(cleand_numbers);
maxD=cleand_numbers(n);
disp(maxD);
[h,~]=size(Cropdedimage);
[nn,~]=size(heightsBar);
chartCount=zeros(nn,1);
for i=1:size(heightsBar)
   x=(maxD *heightsBar(i));
    chartCount(i)=round(x(2)/(h-90),0);
end

end

