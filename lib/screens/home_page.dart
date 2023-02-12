import 'dart:convert';
import 'dart:io';
import 'package:app/models/expense_model.dart';
import 'package:app/provider/main_provider.dart';
import 'package:app/screens/add_category.dart';
import 'package:app/utils/constants.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:app/utils/colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  Color color = Colors.white;
  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];
  @override
  void initState() {
    // TODO: implement initState

    Provider.of<MainProvider>(context, listen: false).getExpense();
    super.initState();
  }

  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.gray,
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text('Home'),
      ),
      floatingActionButton: Consumer<MainProvider>(
        builder: (context, provider, child) => FloatingActionButton(
          onPressed: () async {
            print(provider.expenseData.expense);
            final value = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddCategory(
                        expenseData: provider.expenseData,
                      )),
            );
            setState(() {
              color = color == Colors.white ? Colors.grey : Colors.white;
              provider = Provider.of<MainProvider>(context, listen: false);
              provider.totalIncome = 0;
              provider.totalSpend = 0;
              provider.data();
            });
          },
          child: Icon(Icons.add),
        ),
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
        ],
      ),
      body: Consumer<MainProvider>(
        builder: (context, provider, child) => provider.isLoadingHome
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                          "Account Details",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green[300],
                                  // boxShadow: kboxShadow,
                                ),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(8),
                                child: Column(children: [
                                  Text(
                                    "Savings",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "₹${provider.totalIncome}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red[300],
                                  // boxShadow: kboxShadow,
                                ),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(8),
                                child: Column(children: [
                                  Text(
                                    "Expenses",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "-₹${provider.totalSpend}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blueGrey[400],
                                  // boxShadow: kboxShadow,
                                ),
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(8),
                                child: Column(children: [
                                  Text(
                                    "Remaining",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "₹${provider.totalIncome - provider.totalSpend}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ]),
                              ),
                            )
                          ],
                        ),
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
                          "₹ ${provider.totalSpend.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        PieChart(
                          dataMap: provider.pieData.isEmpty
                              ? {'Add Expenses': 0}
                              : provider.pieData,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 32,
                          // centerText: "Expense",
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
                            // showChartValuesInPercentage: false,
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
                        ExpandablePanel(
                          header: Text('tap to expand the items'),
                          collapsed: collapsedCont(provider.listItems),
                          expanded: Column(children: provider.listItems),
                          theme: ExpandableThemeData(
                              useInkWell: true,
                              tapBodyToCollapse: true,
                              tapBodyToExpand: true,
                              tapHeaderToExpand: true),
                        ),
                      ],
                    ),
                  )
                ],
              )),
      ),
    );
  }

  Widget collapsedCont(List<Widget> list) {
    int count = 0;
    List<Widget> finalList = [];
    for (int i = 0; i < list.length; i++) {
      if (count > 4) {
        break;
      }
      finalList.add(list[i]);
      count++;
    }
    return Column(
      children: finalList,
    );
  }
}
