i=78
FILE1=/tmp/ui.xml
FILE2=/tmp/savesrch.txt
FILE3=/tmp/viewstate.txt
cat /tmp/files | while read line

do
i=`expr $i + 1`
echo "
<row>
    <chart>
      <searchName>$line</searchName>
        <title>$line</title>
      <option name="charting.chart">line</option>
      </chart>
    </row>
" >> $FILE1

echo "
[flashtimeline:hdtis5lc${i}]
AxisScaleFormatter_0_19_0.default = log
ButtonSwitcher_0_9_0.selected = splIcon-results-chart
ChartTypeFormatter_0_14_0.default = line
Count_0_8_1.default = 50
DataOverlay_0_14_0.dataOverlayMode = none
DataOverlay_0_14_0.default = none
FieldPicker_0_6_0.fields = host,sourcetype,source
FieldPicker_0_6_0.sidebarDisplay = True
FlashTimeline_0_4_1.height = 95px
FlashTimeline_0_4_1.minimized = False
JSChart_0_14_1.height = 300px
LegendFormatter_0_20_0.default = right
MaxLines_0_14_0.default = 10
MaxLines_0_14_0.maxLines = 10
NullValueFormatter_0_19_0.default = gaps
RowNumbers_0_13_0.default = true
RowNumbers_0_13_0.displayRowNumbers = true
RowNumbers_1_13_0.default = true
RowNumbers_1_13_0.displayRowNumbers = true
Segmentation_0_15_0.default = full
Segmentation_0_15_0.segmentation = full
SoftWrap_0_12_0.enable = True
SplitModeFormatter_0_18_0.default = false
StackModeFormatter_0_17_0.default = none
XAxisTitleFormatter_0_16_1.default = Bamboo Build Number
YAxisTitleFormatter_0_16_2.default = Number of Tests
" >> $FILE2
echo "
[$line]
action.email.reportServerEnabled = 0
alert.suppress = 0
alert.track = 0
dispatch.earliest_time = 0
displayview = flashtimeline
request.ui_dispatch_view = flashtimeline
search = | dbquery testlink limit=1000 \"select * from BUILDRESULTSUMMARY where ( BUILD_KEY like '$line' and LIFE_CYCLE_STATE='Finished' and  (BUILD_COMPLETED_DATE BETWEEN CURDATE() - INTERVAL 30 DAY AND CURDATE()));\" | chart sum(BROKEN_TEST_COUNT), sum(SUCCESS_TEST_COUNT),sum(FAILURE_TEST_COUNT),sum(TOTAL_TEST_COUNT) by   BUILD_NUMBER
vsid = hdtis5lc${i}
" >> $FILE3

done
