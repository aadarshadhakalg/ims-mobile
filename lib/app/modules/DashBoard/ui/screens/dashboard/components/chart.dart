import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key key,
    this.data,
  }) : super(
          key: key,
        );

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                ...data['categories'].map((d) {
                  Color _randomColor = Colors
                      .primaries[Random().nextInt(Colors.primaries.length)];
                  return PieChartSectionData(
                    color: _randomColor,
                    value: d.sold.toDouble(),
                    showTitle: false,
                    radius: 20 + d.sold / data['sold'] * 10,
                  );
                }),
                PieChartSectionData(
                  color: primaryColor,
                  value: 15,
                  showTitle: false,
                  radius: 16,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "${data['sold']}",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of ${data['total']} Items")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [];
