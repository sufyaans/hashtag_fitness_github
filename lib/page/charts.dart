// ignore_for_file: unnecessary_new, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class chartScreen extends StatefulWidget {
//   @override
//   PointsLineChart createState() => PointsLineChart();
// }

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd-hh-mm');
  final String formatted = formatter.format(now);

  PointsLineChart(this.seriesList, {this.animate = false});

  factory PointsLineChart.withSampleData(var values, var timeRange) {
    return new PointsLineChart(
      _createSampleData(values, timeRange),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<LinearSales, DateTime>> _createSampleData(
      var values, var timeRange) {
    final List<LinearSales> data = [
      // new LinearSales(0, 5),
      // new LinearSales(1, 25),
      // new LinearSales(2, 100),
      // new LinearSales(3, 75),
    ];
    List<int> maxDate = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (timeRange == "by Month") {
      for (var i = 0; i < values.length; i++) {
        if (now.month == values[i][0].toDate().month) {
          data.add(new LinearSales(
              new DateTime(values[i][0].toDate().year,
                  values[i][0].toDate().month, values[i][0].toDate().day),
              values[i][1]));
        }
      }
    } else if (timeRange == "by Year") {
      for (var i = 0; i < values.length; i++) {
        if (now.year == values[i][0].toDate().year) {
          data.add(new LinearSales(
              new DateTime(values[i][0].toDate().year,
                  values[i][0].toDate().month, values[i][0].toDate().day),
              values[i][1]));
        }
      }
    } else if (timeRange == "by Day") {
      for (var i = 0; i < values.length; i++) {
        if (now.day == values[i][0].toDate().day) {
          data.add(new LinearSales(
              new DateTime(
                values[i][0].toDate().year,
                values[i][0].toDate().month,
                values[i][0].toDate().day,
                values[i][0].toDate().hour,
                values[i][0].toDate().minute,
              ),
              values[i][1]));
        }
      }
    } else if (timeRange == "By Month") {
      var valuesByDate = [];
      for (int i = 0; i < 31; i++) {
        valuesByDate.add(0);
      }
      for (var i = 0; i < values.length; i++) {
        if (now.month == values[i][0].toDate().month) {
          valuesByDate[values[i][0].toDate().day - 1] += values[i][1];
        }
      }
      for (int i = 0; i < maxDate[now.month - 1]; i++) {
        if (valuesByDate[i] != 0)
          data.add(new LinearSales(
              new DateTime(
                values[0][0].toDate().year,
                values[0][0].toDate().month,
                i + 1,
              ),
              valuesByDate[i]));
      }
    }

    return [
      new charts.Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final DateTime time;
  final int sales;

  LinearSales(this.time, this.sales);
}
