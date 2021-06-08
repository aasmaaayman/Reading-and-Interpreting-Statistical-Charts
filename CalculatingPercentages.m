function [Outputpercentages] = CalculatingPercentages(Colors, segmentedCircle)
[H, W, ~] = size(segmentedCircle);
%figure, imshow(segmentedCircle);
I = rgb2gray(segmentedCircle);
I = I < 229;
SE = strel('disk',5);
I = imdilate(I,SE);
SE = strel('disk',5);
I = imerode(I,SE);
%figure, imshow(I);
[L num] = bwlabel(I);
TotalPixels = regionprops(L, 'Area');
TotalPixels = [TotalPixels.Area];
%disp(TotalPixels);
%figure, imshow(I);
[R, C] = size(Colors);
counters = zeros(R,1);
avgs = zeros(R,1);
[L,n]=bwlabel(I);
stat = regionprops(L,'Area','BoundingBox'); 

for i=1: H
    for j=1: W
         if segmentedCircle(i,j,1) >= 220 && segmentedCircle(i,j,2) >= 220 && segmentedCircle(i,j,3) >= 220
            continue;
         end
         redCheckCircle = abs(double(segmentedCircle(i,j,1)) - double(segmentedCircle(i,j,2)));
         greenCheckCircle = abs(double(segmentedCircle(i,j,2)) - double(segmentedCircle(i,j,3)));
         blueCheckCircle = abs(double(segmentedCircle(i,j,1)) - double(segmentedCircle(i,j,3)));
            for k=1: R
                checkArr(k,1) = abs(double(Colors(k,1)) - double(Colors(k,2)));
                checkArr(k,2) = abs(double(Colors(k,2)) - double(Colors(k,3)));
                checkArr(k,3) = abs(double(Colors(k,1)) - double(Colors(k,3)));
            end
            for l=1: R
                checkMin(l,1) = abs(double(redCheckCircle)-double(checkArr(l,1)));
                checkMin(l,2) = abs(double(greenCheckCircle)-double(checkArr(l,2)));
                checkMin(l,3) = abs(double(blueCheckCircle)-double(checkArr(l,3)));
            end
            for z=1: R
                avgs(z) = round(mean(checkMin(z,:)));
            end
         pixMin = min(avgs);
        [row, column]=find(avgs==pixMin);
         
        if double(checkMin(row(1),1)) < 50 && double(checkMin(row(1),2)) < 40 && double(checkMin(row(1),3))<35
        counters(row)=counters(row)+1;
        end
        
    end
Outputpercentages = zeros(R,1);
for i=1: R
   Outputpercentages(i) =round((counters(i)./TotalPixels).*100);
end
end