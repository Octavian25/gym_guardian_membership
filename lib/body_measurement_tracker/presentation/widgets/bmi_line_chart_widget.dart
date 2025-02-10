import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/register_body_measurement_tracker/domain/entities/body_measurement_entity.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:collection/collection.dart';

class BMILineChart extends StatefulWidget {
  final List<BodyMeasurementEntity> listData;
  final int selectedIndex;
  const BMILineChart({super.key, required this.listData, this.selectedIndex = 0});

  @override
  State<BMILineChart> createState() => _BMILineChartState();
}

class _BMILineChartState extends State<BMILineChart> {
  List<FlSpot> get spots {
    List<BodyMeasurementEntity> sortedData = List.from(widget.listData)
      ..sort((a, b) => a.inputDate!.compareTo(b.inputDate!));

    var result = sortedData.mapIndexed((i, e) => FlSpot(i.toDouble(), e.bmi ?? 0)).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.5,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: LineChart(
            mainData(),
          ),
        ));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13.spMin,
    );
    if (value.toInt() < 0 || value.toInt() >= widget.listData.length) {
      return Container();
    }
    DateTime? date = widget.listData[value.toInt()].inputDate;
    String formattedDate = date != null ? DateFormat('dd MMM').format(date) : '';

    return SideTitleWidget(
      meta: meta,
      child: Text(
        formattedDate,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(value.toStringAsFixed(1),
        style: bebasNeue.copyWith(fontSize: 17.spMin, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    var lineBarData = LineChartBarData(
      spots: spots,
      isCurved: true,
      barWidth: 2,
      isStrokeCapRound: true,
      color: primaryColor,
      dashArray: [5, 4],
      shadow: Shadow(blurRadius: 6, color: primaryColor, offset: Offset(0, 2)),
      dotData: const FlDotData(
        show: true,
      ),
    );

    return LineChartData(
      showingTooltipIndicators: [widget.selectedIndex].map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            lineBarData,
            0,
            lineBarData.spots[index],
          ),
        ]);
      }).toList(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: Colors.black.withValues(alpha: 0.1), strokeWidth: 1, dashArray: [10, 5]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            minIncluded: false,
            maxIncluded: false,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 40.w,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: (widget.listData.length - 1).toDouble(),
      minY: spots.isNotEmpty ? spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 1 : 0,
      maxY: spots.isNotEmpty ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 1 : 10,
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: false,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => primaryColor,
          tooltipRoundedRadius: 8,
          tooltipPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toString(),
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.spMin),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [lineBarData],
    );
  }
}
