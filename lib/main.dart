import 'dart:developer';

import 'package:app/provider/add_category_provider.dart';
import 'package:app/provider/main_provider.dart';
import 'package:app/screens/add_category.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainProvider()),
    ChangeNotifierProvider(create: (_) => CategoryPorvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: colors.primary_app,
      ),
      home: const AddCategory(),
    );
  }
}
