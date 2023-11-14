import 'package:flutter/material.dart';

class ConfiguracaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
        color: Colors.teal[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Configursações',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Adicione aqui as configurações e opções de configuração
            ],
          ),
        ),
      ),
    );
  }
}
