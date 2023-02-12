import 'dart:developer';

import 'package:app/provider/add_category_provider.dart';
import 'package:app/provider/main_provider.dart';
import 'package:app/screens/add_category.dart';
import 'package:app/screens/first_screen.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/screens/splash.dart';
import 'package:app/screens/stock_model.dart';
import 'package:app/screens/onbording/landing_page.dart';
import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainProvider()),
    ChangeNotifierProvider(create: (_) => CategoryPorvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  void setData() async {
    var prefs = await SharedPreferences.getInstance();
    bool? isNewUser = prefs.getBool('isNewUser');
    String? data = prefs.getString('data');
    if (data == null) {
      await prefs.setString(
          'data', await rootBundle.loadString('assets/base_data.json'));
    }
    // } else {
    //   await prefs.setString(
    //       'data', await rootBundle.loadString('assets/base_data.json'));
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   builder: (context, child) => SafeArea(child: child!),
      theme: ThemeData(
        primarySwatch: colors.primary_app,
      ),
      home: Splash(),
    );
  }
}
