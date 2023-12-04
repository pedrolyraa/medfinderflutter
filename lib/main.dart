import 'package:flutter/material.dart';
import 'package:medfinderflutter/firebase_api.dart';
import 'package:medfinderflutter/screens/SignInScreen.dart';
import 'package:medfinderflutter/screens/initScreen.dart';
import 'package:medfinderflutter/screens/AceiteScreen.dart'; // Adicione a importação de HistoricoScreen
import 'package:provider/provider.dart';
import 'apis/AuthController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  // Configurando os listeners do Firebase Messaging
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Tratar mensagem quando o app está em primeiro plano
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Navegar para o HistoricoScreen quando o app é aberto a partir de uma notificação
    print('Mensagem Aceita!.');
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => AceiteScreen()));
  });

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
        navigatorKey: navigatorKey, // Certifique-se de usar o navigatorKey aqui
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