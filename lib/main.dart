import 'package:flutter/material.dart';
import 'package:medfinderflutter/screens/SignInScreen.dart';
import 'package:medfinderflutter/screens/initScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pageController = PageController(initialPage: 1);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedFinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageView(
        controller: pageController,
        children: <Widget>[
          Scaffold(
            body: SignInScreen(),
          ),
          Scaffold(
            body: InitScreen(pageController),
          ),
        ],
      )
    );

  }
}
