import 'package:flutter/material.dart';
import 'package:mod3_kel30/screens/home.dart';
import 'package:mod3_kel30/screens/detail.dart';
import 'package:mod3_kel30/screens/splash_screen.dart';
import 'package:mod3_kel30/screens/profiles.dart';

void main() async {
  runApp (AnimeApp());
}

class AnimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => Home(),
        '/detail': (context) => Detail(item:0, title:''),
        '/profiles': (context) => Profiles(),

      },
    );
  }
}
