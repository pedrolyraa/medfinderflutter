import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'SignInScreen.dart';

class InitScreen extends StatefulWidget {
  final PageController controller;
  InitScreen(this.controller);

  @override
  _InitScreenState createState() => _InitScreenState(controller);
}

class _InitScreenState extends State<InitScreen> {
  final PageController pageController;
  _InitScreenState(this.pageController);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController responsibleNumberController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  double displayHeight() => MediaQuery.of(context).size.height;

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.teal, // Cor da borda
        width: 2.0,
      ),
    );
  }

  void navigateToSignInScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignInScreen();
    }));
  }

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final phoneNumberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final responsibleNumberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.teal[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: displayHeight() / 4,
                    decoration: BoxDecoration(
                      color: Colors.teal[700],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 160, // Largura da imagem
                          height: 160, // Altura da imagem
                          child: Image.asset(
                            'assets/images/splash.png', // Caminho para a imagem
                            fit: BoxFit.cover, // Ajuste da imagem
                          ),
                        ),
                        Text(
                          'Faça um pequeno cadastro!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: outlineInputBorder(),
                            focusedBorder: outlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: phoneNumberController,
                          inputFormatters: [phoneNumberFormatter],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Número de Telefone',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: outlineInputBorder(),
                            focusedBorder: outlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: responsibleNumberController,
                          inputFormatters: [responsibleNumberFormatter],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Número do Responsável',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: outlineInputBorder(),
                            focusedBorder: outlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: cpfController,
                          inputFormatters: [cpfFormatter],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'CPF',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: outlineInputBorder(),
                            focusedBorder: outlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Aqui você pode adicionar a lógica para cadastrar os dados
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[900], // Cor de fundo verde mais escura
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(200, 50), // Aumenta o tamanho do botão
                    ),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Aumenta o tamanho da fonte do texto
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: navigateToSignInScreen,
            child: Text(
              'Já tem cadastro? Clique aqui para fazer o login',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
