import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mod3_kel30/screens/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.network(
          'https://i2.wp.com/www.electrumitsolutions.com/wp-content/uploads/2021/02/Google-flutter-logo-1-e1613820176765.png'),
    )
    );
  }
}

