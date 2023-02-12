import 'package:app/models/expense_model.dart';
import 'package:app/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryPorvider extends ChangeNotifier {
  String type = "expense";
  String? selectedType;
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  late ExpenseData expenseData;
  List<String> expenseItems = [
    ExpenseConstants.BUSINESS_TRIPS,
    ExpenseConstants.FOOOD_DRINKS,
    ExpenseConstants.SHOPPING,
    ExpenseConstants.HOUSING,
    ExpenseConstants.TRANSPORTATION,
    ExpenseConstants.VEHICLE,
    ExpenseConstants.LIFE_ENTERTAINMENT,
    ExpenseConstants.COMMUNICATION_PC,
    ExpenseConstants.FINANCIAL,
    ExpenseConstants.INVESTMENT,
    ExpenseConstants.OTHERS
  ];
  List<String> incomeItems = [
    IncomeConstants.OTHERS,
    IncomeConstants.CHECKS_COUPONS,
    IncomeConstants.CHILD_SUPPORT,
    IncomeConstants.DUES_GRANTS,
    IncomeConstants.GIFTS,
    IncomeConstants.INTREST,
    IncomeConstants.LENDING,
    IncomeConstants.REFUNDS,
    IncomeConstants.RENTAL,
    IncomeConstants.SALE,
    IncomeConstants.WAGE,
  ];
  List<String> finalItem = [
    ExpenseConstants.BUSINESS_TRIPS,
    ExpenseConstants.FOOOD_DRINKS,
    ExpenseConstants.SHOPPING,
    ExpenseConstants.HOUSING,
    ExpenseConstants.TRANSPORTATION,
    ExpenseConstants.VEHICLE,
    ExpenseConstants.LIFE_ENTERTAINMENT,
    ExpenseConstants.COMMUNICATION_PC,
    ExpenseConstants.FINANCIAL,
    ExpenseConstants.INVESTMENT,
    ExpenseConstants.OTHERS
  ];
  void setSelectedType() {
    selectedType = null;
    notifyListeners();
  }

  void addCat() async {
    var newExp = Expense(
        amount: double.parse(amountController.text),
        note: noteController.text,
        desc: selectedType!,
        type: type,
        date: DateTime.now().millisecondsSinceEpoch);
    expenseData.expense.insert(0, newExp);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('data', expenseDataToJson(expenseData));
    print(expenseData.expense);
    amountController.clear();
    noteController.clear();
    selectedType = null;
  }
}
