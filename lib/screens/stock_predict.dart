import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/line_chart.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class StockPredict extends StatefulWidget {
  const StockPredict({super.key, required this.item});

  final Map<String, String> item;
  @override
  State<StockPredict> createState() => _StockPredictState();
}

class _StockPredictState extends State<StockPredict> {
  late String? symbol = widget.item['symbol'];
  late String? name = widget.item['name'];
  bool isLoading = false;
  bool isDataLoaded = false;
  List prices = [];
  List<FlSpot> coordinate = [];
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  double sumLast = 0;
  double sumPredict = 0;
  void predictStock() async {
    setState(() {
      isLoading = true;
    });
    var res =
        await http.get(Uri.parse('http://10.0.2.2:5000/predict/${symbol}'));
    print(res.body);
    if (res.statusCode == 200) {
      var deco = jsonDecode(res.body);
      prices = deco['preds'];
      for (int i = 0; i < prices.length; i++) {
        if (i < 7)
          sumLast += prices[i];
        else
          sumPredict += prices[i];
      }
      setState(() {
        isLoading = false;
        isDataLoaded = true;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    predictStock();
    return Scaffold(
        backgroundColor: colors.gray,
        appBar: AppBar(
          backgroundColor: colors.primary,
          title: Text('Predict Price'),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     color: Colors.white,
            //     boxShadow: kboxShadow,
            //   ),
            //   padding: EdgeInsets.all(8),
            //   margin: EdgeInsets.all(8),
            //   child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Stack(
            //           children: <Widget>[
            //             AspectRatio(
            //               aspectRatio: 1.70,
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                   right: 18,
            //                   left: 12,
            //                   top: 24,
            //                   bottom: 12,
            //                 ),
            //                 child: LineChart(
            //                   mainData(),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ]),
            // ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: kboxShadow,
              ),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Prediction of $name stock Prices",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Last 7 Days Prices",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Predicted Next 7 Days Prices",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  !isDataLoaded
                      ? CircularProgressIndicator()
                      : Row(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0; i < 7; i++)
                                  Text(prices[i].toStringAsFixed(2)),
                              ]),
                          SizedBox(
                            width: 150,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 7; i < 14; i++)
                                  Text(prices[i].toStringAsFixed(2)),
                              ])
                        ]),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: kboxShadow,
              ),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Final Prediction of $symbol",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    !isDataLoaded
                        ? CircularProgressIndicator()
                        : (sumLast / 7) > (sumPredict / 7)
                            ? Column(
                                children: [
                                  Text(
                                    'There are chances of this stock going down',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image(
                                      image: AssetImage(
                                          'assets/images/nostonk.jpg')),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    'There are chances of this stock going up',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image(
                                      image: AssetImage(
                                          'assets/images/stonk.jpg')),
                                ],
                              )
                  ]),
            ),
          ],
        )));
  }

  LineChartData mainData() {
    return LineChartData(
      // gridData: FlGridData(
      //   show: true,
      //   drawVerticalLine: true,
      //   horizontalInterval: 1,
      //   verticalInterval: 1,
      //   getDrawingHorizontalLine: (value) {
      //     return FlLine(
      //       color: AppColors.mainGridLineColor,
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingVerticalLine: (value) {
      //     return FlLine(
      //       color: AppColors.mainGridLineColor,
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // bottomTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //     reservedSize: 30,
        //     interval: 1,
        //   ),
        // ),
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //     interval: 1,
        //     reservedSize: 42,
        //   ),
        // ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: coordinate,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          //barWidth: 5,
          //  isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
