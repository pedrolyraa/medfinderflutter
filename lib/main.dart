import 'package:flutter/material.dart';
import 'package:medfinderflutter/screens/SignInScreen.dart';
import 'package:medfinderflutter/screens/initScreen.dart';
import 'package:provider/provider.dart';
import 'apis/AuthController.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MedFinder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(pageController),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final PageController pageController;

  AuthWrapper(this.pageController);

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return PageView(
      controller: pageController,
      children: <Widget>[
        Scaffold(
          body: SignInScreen(),
        ),
        Scaffold(
          body: InitScreen(pageController),
        ),
      ],
    );
  }
}
