function pie_chart(img)
croppedLegend = Legend(img);
SegmentedCircle = SegmentCircle(img);
Colors = DetectingColors(croppedLegend);
OutputPercentages = CalculatingPercentages(Colors, SegmentedCircle);
disp(OutputPercentages);
end

