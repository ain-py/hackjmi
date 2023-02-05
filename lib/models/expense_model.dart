// To parse this JSON data, do
//
//     final expenseData = expenseDataFromJson(jsonString);

import 'dart:convert';

ExpenseData expenseDataFromJson(String str) =>
    ExpenseData.fromJson(json.decode(str));

String expenseDataToJson(ExpenseData data) => json.encode(data.toJson());

class ExpenseData {
  ExpenseData({
    required this.expense,
  });

  List<Expense> expense;

  factory ExpenseData.fromJson(Map<String, dynamic> json) => ExpenseData(
        expense:
            List<Expense>.from(json["expense"].map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expense": List<dynamic>.from(expense.map((x) => x.toJson())),
      };
}

class Expense {
  Expense({
    required this.desc,
    required this.amount,
    required this.note,
    required this.type,
    required this.date,
  });

  String desc;
  double amount;
  String note;
  String type;
  int date;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        desc: json["desc"],
        amount: json["amount"]?.toDouble(),
        note: json["note"],
        type: json["type"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "amount": amount,
        "note": note,
        "type": type,
        "date": date,
      };
}
