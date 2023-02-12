import 'dart:convert';
import 'dart:ffi';

import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class StockModel extends StatefulWidget {
  const StockModel({super.key});

  @override
  State<StockModel> createState() => _StockModelState();
}

class _StockModelState extends State<StockModel>
    with SingleTickerProviderStateMixin {
  TextEditingController stockController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat(reverse: false);
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.elasticIn,
  // ));
  String id = '';
  double prediction = 0.0;
  void predictStock() async {
    setState(() {
      isLoading = true;
    });
    var res = await http
        .get(Uri.parse('http://10.0.2.2:5000/predict/${stockController.text}'));
    print(res.body);
    if (res.statusCode == 200) {
      var deco = jsonDecode(res.body);
      id = deco['id'];
      prediction = deco['prediction'];
      setState(() {
        isLoading = false;
        isDataLoaded = true;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  bool isLoading = false;
  bool isDataLoaded = false;
  @override
  void dispose() {
    //   _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.gray,
      appBar: AppBar(
        title: Text('Stock Prediction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Input Company name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: stockController,
                  validator: (value) =>
                      value!.isEmpty ? 'Field is required' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    hintText: 'Note',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text('Search',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('heejndks');
                          predictStock();
                        }
                      },
                    ),
                  ),
                ),
                isDataLoaded
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: kboxShadow,
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        child: Text('${prediction} $id'),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
