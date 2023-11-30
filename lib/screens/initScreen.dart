import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../apis/AuthController.dart';
import 'SignInScreen.dart';
import 'menu.dart';

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
                          inputFormatters: [cpfFormatter],
                          decoration: InputDecoration(
                            labelText: 'Login',
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
                            labelText: 'Senha',
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: outlineInputBorder(),
                            focusedBorder: outlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Column(
                  //     children: <Widget>[
                  //       TextField(
                  //         controller: responsibleNumberController,
                  //         inputFormatters: [responsibleNumberFormatter],
                  //         keyboardType: TextInputType.phone,
                  //         decoration: InputDecoration(
                  //           labelText: 'Número do Responsável',
                  //           filled: true,
                  //           fillColor: Colors.white,
                  //           enabledBorder: outlineInputBorder(),
                  //           focusedBorder: outlineInputBorder(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: cpfController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Role',
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
                    onPressed: () async {
                      final authController = Provider.of<AuthController>(context, listen: false);
                      final login = nameController.text;
                      final senha = phoneNumberController.text;
                      final role = cpfController.text; // Você pode precisar ajustar isso dependendo do seu modelo de dados

                      // Validar entrada
                      if (login.isEmpty || senha.isEmpty || role.isEmpty) {
                        // Exibir mensagem de erro ou feedback ao usuário
                        print('Por favor, preencha todos os campos.');
                        return;
                      }

                      try {
                        final success = await authController.register(login, senha, role);

                        if (success) {
                          // Registro bem-sucedido, agora faça o login automaticamente
                          await authController.login(login, senha);



                          // Verifique se o token foi gerado após o login
                          if (authController.token != null) {
                            // Exiba um SnackBar indicando que o cadastro e a autenticação foram bem-sucedidos
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cadastro e autenticação bem-sucedidos!'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            // Navegue para a próxima tela
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return MenuScreen();
                            }));
                          } else {
                            // Trate o erro de autenticação aqui
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Erro de autenticação após o registro.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          // Trate o erro de registro aqui
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Usuário Já cadastrado.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } catch (e) {
                        // Tratamento de erro mais genérico, por exemplo, exibir uma mensagem de erro ao usuário
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro durante o registro: $e'),
                            duration: Duration(seconds: 2), // Ajuste conforme necessário
                          ),
                        );
                      }
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
