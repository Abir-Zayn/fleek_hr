import 'package:fl_chart/fl_chart.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';


class AttendenceBarChart extends StatefulWidget {
  final List<double> monthlyAttendence;
  const AttendenceBarChart({super.key, required this.monthlyAttendence});

  @override
  State<AttendenceBarChart> createState() => _AttendenceBarChartState();
}

class _AttendenceBarChartState extends State<AttendenceBarChart> {
  int? selectedBarIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            enabled: true,
            handleBuiltInTouches: false,
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              if (event is FlTapUpEvent &&
                  barTouchResponse != null &&
                  barTouchResponse.spot != null) {
                setState(() {
                  final spotIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                  selectedBarIndex =
                      selectedBarIndex == spotIndex ? null : spotIndex;
                });
              }
            },
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding:
                  EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              tooltipMargin: 8,
              getTooltipColor: (_) => Colors.grey.shade800.withOpacity(0.7),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                // Only show tooltip for the selected bar
                if (selectedBarIndex == groupIndex) {
                  return BarTooltipItem(
                    '${rod.toY.round()}', //Display the number of days attended
                    TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) {
                  const months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                  ];
                  final index = value.toInt();
                  if (index >= 0 && index < months.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: AppTextstyle(
                        text: months[index],
                        style: appStyle(
                          color: selectedBarIndex == index
                              ? Colors.blue.shade900
                              : Colors.black,
                          size: 12,
                          fontWeight: selectedBarIndex == index
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value % 10 == 0) {
                    return AppTextstyle(
                      text: value.toInt().toString(),
                      style: appStyle(
                          size: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: false,
          ),
          alignment: BarChartAlignment.spaceAround,
          maxY: widget.monthlyAttendence.isNotEmpty
              ? widget.monthlyAttendence
                  .map((e) => e.ceilToDouble())
                  .reduce((a, b) => a > b ? a : b)
              : 31,
          barGroups: List.generate(
            widget.monthlyAttendence.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: widget.monthlyAttendence[index],
                  color: selectedBarIndex == index
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                  width: 10,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
              showingTooltipIndicators: selectedBarIndex == index ? [0] : [],
            ),
          ),
        ),
      ),
    );
  }
}
