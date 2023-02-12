import 'package:app/models/expense_model.dart';
import 'package:app/screens/first_screen.dart';
import 'package:app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constant.dart';
import 'onbording_content.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;
  TextEditingController savingsController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(contents[i].image),
                        height: 370,
                        width: 400,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                  currentIndex == contents.length - 1 ? "Continue" : "Next"),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  _showMyDialog();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => HomePage(),
                  //   ),
                  // );
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                }
              },
              // color: Theme.of(context).primaryColor,
              // textColor: Colors.white,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20),
              // ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Your Savings:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: savingsController,
                  validator: (value) =>
                      value!.isEmpty ? 'Field is required' : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    hintText: '0.0',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text('Save',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (!savingsController.text.isEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                var prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('isNewUser', false);
                                var newExp = Expense(
                                    amount:
                                        double.parse(savingsController.text),
                                    note: "no",
                                    desc: "Savings",
                                    type: "income",
                                    date:
                                        DateTime.now().millisecondsSinceEpoch);
                                final String? listData =
                                    prefs.getString('data');
                                var expenseData;
                                if (listData != null) {
                                  expenseData = expenseDataFromJson(listData);
                                  expenseData.expense.insert(0, newExp);
                                }

                                prefs.setString(
                                    'data', expenseDataToJson(expenseData));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FirstPage(),
                                  ),
                                );
                              }
                            },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
