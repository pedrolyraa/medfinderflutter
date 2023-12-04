import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../apis/AuthController.dart';
import 'initScreen.dart';
import 'menu.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
          body: authController.token != null ? MenuScreen() : InitScreen(pageController),
        ),
      ],
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController cpfController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final phoneNumberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/images/splash.png', // Caminho para a imagem
                    fit: BoxFit.scaleDown, // Ajuste da imagem
                  ),
                ),
                Text(
                  'Faça o login',
                  style: TextStyle(
                    color: Colors.teal[900],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: cpfController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, cpfFormatter],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CPF',
                prefixIcon: Icon(Icons.fingerprint),
                filled: true,
                fillColor: Colors.teal[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, phoneNumberFormatter],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Número de Telefone',
                prefixIcon: Icon(Icons.phone),
                filled: true,
                fillColor: Colors.teal[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final authController = Provider.of<AuthController>(context, listen: false);
                final login = cpfController.text;
                final senha = phoneNumberController.text;

                // Validar entrada
                if (login.isEmpty || senha.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, preencha todos os campos.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return ;
                }

                try {
                  await authController.login(login, senha);

                  if (authController.token != null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const MenuScreen();
                    }));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro de autenticação'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro durante o login: $e'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Entrar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //       return MenuScreen();
            //     }));
            //   },
            //   child: Text(
            //     'Ir para o Menu',
            //     style: TextStyle(
            //       color: Colors.teal[900],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
