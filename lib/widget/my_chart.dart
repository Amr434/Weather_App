import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/fivedays.dart';
import 'package:whether_app/shared/constant/appcolor.dart';


class MyChart extends GetView<Homecontroler> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(bottom: 20),

      width: MediaQuery.of(context).size.width,
      height: 240,
      child: SfCartesianChart(

        backgroundColor: Colors.transparent,
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries<FiveDays, String>>[
          SplineSeries<FiveDays, String>(
            dataSource: controller.fivedays,
            xValueMapper: (FiveDays f, _) =>
                f.datetime.toString(),
            yValueMapper: (FiveDays f, _) =>
            f.main!.temp,
          ),
        ],
      ),
    );
  }
}
