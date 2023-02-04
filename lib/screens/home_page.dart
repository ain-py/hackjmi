import 'dart:convert';
import 'dart:io';

import 'package:app/models/expense_model.dart';
import 'package:app/utils/constants.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> readJsonFile(String filePath) async {
    return await File(filePath).readAsString();
  }

  void getExpense() async {
    var expenseData =
        expenseDataFromJson(await rootBundle.loadString('assets/test.json'));
    print(expenseData.expense);
    var newExp =
        Expense(amount: 10, note: "hello", desc: "this is rhe", date: 123333);
    expenseData.expense.add(newExp);
    expenseData.expense.forEach((element) {
      print(element.desc);
    });
    print(expenseDataToJson(expenseData));
  }

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    getExpense();
    return Scaffold(
      backgroundColor: colors.gray,
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: kboxShadow,
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expenses Structure",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Last 30 Days",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "₹ 10,000",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(
                  height: 3,
                ),
                PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.disc,
                  ringStrokeWidth: 32,
                  centerText: "HYBRID",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                  // gradientList: ---To add gradient colors---
                  // emptyColorGradient: ---Empty Color gradient---
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: kboxShadow),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Last records overview",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Last 30 Days",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black54)),
                SizedBox(
                  height: 5,
                ),
                //Item rows

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[300],
                    child: Icon(
                      Icons.dangerous,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Food & Drinks',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16),
                  ),
                  subtitle: Text('Today'),
                  trailing: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("-₹5000",
                          style: TextStyle(color: Colors.red, fontSize: 15)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Yesterday',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.black54, fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Others", style: TextStyle(fontSize: 15)),
                      Spacer(),
                      Text("-129",
                          style: TextStyle(color: Colors.red, fontSize: 15)),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
