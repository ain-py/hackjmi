import 'package:app/models/expense_model.dart';
import 'package:app/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainProvider extends ChangeNotifier {
  List<String> expenseCategory = [
    ExpenseConstants.BUSINESS_TRIPS,
  ];
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
    data();
  }

  List<Widget> listItems = [];
  void data() {
    _expenseData.expense.forEach((element) {
      var icon, color;
      switch (element.desc) {
        case ExpenseConstants.BUSINESS_TRIPS:
          icon = FontAwesomeIcons.businessTime;
          color = const Color(0xff0984e3);
          break;
        case ExpenseConstants.COMMUNICATION_PC:
          icon = FontAwesomeIcons.laptopCode;
          color = const Color(0xfffdcb6e);
          break;
        case ExpenseConstants.FINANCIAL:
          icon = FontAwesomeIcons.coins;
          color = const Color(0xfffd79a8);
          break;
        case ExpenseConstants.FOOOD_DRINKS:
          icon = FontAwesomeIcons.bowlFood;
          color = const Color(0xffe17055);
          break;
        case ExpenseConstants.HOUSING:
          icon = FontAwesomeIcons.houseChimney;
          color = const Color(0xff6c5ce7);
          break;
        case ExpenseConstants.INVESTMENT:
          icon = FontAwesomeIcons.moneyBillTrendUp;
          color = const Color(0xff0984e3);
          break;
        case ExpenseConstants.LIFE_ENTERTAINMENT:
          icon = FontAwesomeIcons.clapperboard;
          color = const Color(0xfffdcb6e);
          break;
        case ExpenseConstants.OTHERS:
          icon = FontAwesomeIcons.plus;
          color = const Color(0xfffd79a8);
          break;
        case ExpenseConstants.SHOPPING:
          icon = FontAwesomeIcons.cartShopping;
          color = const Color(0xffe17055);
          break;
        case ExpenseConstants.TRANSPORTATION:
          icon = FontAwesomeIcons.train;
          color = const Color(0xff6c5ce7);
          break;
        case ExpenseConstants.VEHICLE:
          icon = FontAwesomeIcons.car;
          color = const Color(0xff6c5ce7);
          break;
        case IncomeConstants.CHECKS_COUPONS:
          icon = FontAwesomeIcons.moneyBill;
          color = const Color(0xff0984e3);
          break;
        case IncomeConstants.CHILD_SUPPORT:
          icon = FontAwesomeIcons.child;
          color = const Color(0xfffdcb6e);
          break;
        case IncomeConstants.DUES_GRANTS:
          icon = FontAwesomeIcons.handHoldingDollar;
          color = const Color(0xfffd79a8);
          break;
        case IncomeConstants.GIFTS:
          icon = FontAwesomeIcons.gifts;
          color = const Color(0xffe17055);
          break;
        case IncomeConstants.INTREST:
          icon = FontAwesomeIcons.moneyBillTrendUp;
          color = const Color(0xff6c5ce7);
          break;
        case IncomeConstants.LENDING:
          icon = FontAwesomeIcons.handHoldingDollar;
          color = const Color(0xff0984e3);
          break;
        case IncomeConstants.OTHERS:
          icon = FontAwesomeIcons.plus;
          color = const Color(0xfffdcb6e);
          break;
        case IncomeConstants.RENTAL:
          icon = FontAwesomeIcons.commentDollar;
          color = const Color(0xfffd79a8);
          break;
        case IncomeConstants.REFUNDS:
          icon = FontAwesomeIcons.commentDollar;
          color = const Color(0xffe17055);
          break;
        case IncomeConstants.SALE:
          icon = FontAwesomeIcons.commentDollar;
          color = const Color(0xff6c5ce7);
          break;
        case IncomeConstants.WAGE:
          icon = FontAwesomeIcons.commentDollar;
          color = const Color(0xff6c5ce7);
          break;
        default:
          icon = FontAwesomeIcons.commentDollar;
          color = const Color(0xff6c5ce7);
      }
      var item = ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          element.desc,
          // s,
          // style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
        ),
        subtitle: Text('Today'),
        trailing: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
                element.type == 'expense'
                    ? "-₹${element.amount}"
                    : "+₹${element.amount}",
                style: TextStyle(
                    color:
                        element.type == 'expense' ? Colors.red : Colors.green,
                    fontSize: 15)),
            SizedBox(
              height: 5,
            ),
            Text(
              'Yesterday',
              // style: Theme.of(context)
              //     .textTheme
              //     .labelMedium!
              //     .copyWith(color: Colors.black54, fontSize: 14),
            )
          ],
        ),
      );
      listItems.add(item);
    });
    print(listItems);
  }
}
