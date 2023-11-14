import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'menu.dart';

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
                    'assets/images/splashGreen.png', // Caminho para a imagem
                    fit: BoxFit.cover, // Ajuste da imagem
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
              onPressed: () {
                // Simule uma autenticação bem-sucedida
                final isAuthenticated = true; // Altere para true se a autenticação for bem-sucedida
                if (isAuthenticated) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return MenuScreen();
                  }));
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
          ],
        ),
      ),
    );
  }
}
