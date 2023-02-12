import 'package:app/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../utils/colors.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetoHome();
  }

  void _navigatetoHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary_app,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image(
              image: AssetImage('assets/images/logo_final.png'),
            )),
            Text(
              'Paisa Planner',
              style: TextStyle(
                  color: Color.fromARGB(255, 33, 29, 29),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
