import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medfinderflutter/screens/menu.dart';
import 'dart:convert';
import 'dart:async';

class AceiteScreen extends StatefulWidget {
  @override
  _AceiteScreenState createState() => _AceiteScreenState();
}

class _AceiteScreenState extends State<AceiteScreen> {
  bool _aceiteRealizado = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/splashGreen.png', // Caminho para a imagem
                fit: BoxFit.cover, // Ajuste da imagem
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Você tomou seu medicamento?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _pararTimer();
                _realizarAceite();
                _navegarParaMenu();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'Aceite',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Confirme acima apenas se tomou o seu medicamento. Caso não clique, em 30 minutos enviaremos um SMS para o número do seu responsável.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _realizarAceite() {
    setState(() {
      _aceiteRealizado = true;
    });
  }

  void _pararTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  void _navegarParaMenu() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MenuScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(minutes: 30), () {
      if (!_aceiteRealizado) {
        _enviarSolicitacao();
        _navegarParaMenu();
      }
    });
  }

  @override
  void dispose() {
    _pararTimer();
    super.dispose();
  }

  void _enviarSolicitacao() async {
    final url = Uri.parse('http://localhost:3030/send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': 'Medicamento Tomado', 'number': 'seu-numero'}),
    );

    // Não é necessário mais retornar para a tela do menu aqui
    // Navigator.pop(context);
  }
}
