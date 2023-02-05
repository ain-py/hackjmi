import 'package:app/models/expense_model.dart';
import 'package:app/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainProvider extends ChangeNotifier {
  // List<String> expenseCategory = [
  //   ExpenseConstants.BUSINESS_TRIPS,
  // ];
  late ExpenseData _expenseData;
  Map<String, double> pieData = {};
  bool isLoadingHome = true;
  double totalSpend = 0;
  void getExpense() async {
    _expenseData =
        expenseDataFromJson(await rootBundle.loadString('assets/test.json'));
    print(_expenseData.expense);

    var newExp = Expense(
        amount: 10,
        note: "hello",
        desc: "this is rhe",
        type: "expense",
        date: DateTime.now().millisecondsSinceEpoch);
    _expenseData.expense.add(newExp);
    _expenseData.expense.sort((e1, e2) => e2.amount.compareTo(e1.amount));
    _expenseData.expense.forEach((element) {
      if (element.type == "expense") {
        totalSpend += element.amount;
        if (pieData.length != 5) pieData[element.desc] = element.amount;
      }
    });
    print(expenseDataToJson(_expenseData));
    // print(pieData);
    isLoadingHome = false;
    notifyListeners();
  }
}
