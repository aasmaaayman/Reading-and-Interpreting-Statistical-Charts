function bar_chart(img)
croppedLegend = Legend(img);
barheights=SegmentBar(img);
output= barchartheights(img,barheights);
display(output);
end
