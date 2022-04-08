// ignore_for_file: unnecessary_new, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

// class chartScreen extends StatefulWidget {
//   @override
//   SimpleLineChart createState() => SimpleLineChart();
// }

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate = false});

  factory SimpleLineChart.withSampleData(var values, var timeRange) {
    return new SimpleLineChart(
      _createSampleData(values, timeRange),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }

  static List<charts.Series<LinearSales, int>> _createSampleData(
      var values, var timeRange) {
    final List<LinearSales> data = [
      // new LinearSales(0, 5),
      // new LinearSales(1, 25),
      // new LinearSales(2, 100),
      // new LinearSales(3, 75),
    ];
    if (timeRange == "by Day") {
      for (var i = 0; i < values.length; i++) {
        data.add(new LinearSales(values[i][0].toDate().day, values[i][1]));
      }
    } else if (timeRange == "by Month") {
      for (var i = 0; i < values.length; i++) {
        data.add(new LinearSales(values[i][0].toDate().month, values[i][1]));
      }
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
