import 'package:flutter/material.dart';
import 'package:medfinderflutter/custom_firebase_messaging.dart';
import 'package:medfinderflutter/firebase_options.dart';
import 'package:medfinderflutter/screens/SignInScreen.dart';
import 'package:medfinderflutter/screens/initScreen.dart';
import 'package:provider/provider.dart';
import 'apis/AuthController.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await CustomFirebaseMessaging().Inicialize();
    await CustomFirebaseMessaging().getTokenFirebase();


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
