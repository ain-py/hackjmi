import 'package:app/utils/app_constant.dart';
import 'package:flutter/material.dart';

class CategoryPorvider extends ChangeNotifier {
  String type = "expense";
  String? selectedType;
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
  void setSelectedType() {
    selectedType = null;
    notifyListeners();
  }
}
