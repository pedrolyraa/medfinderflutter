import 'package:flutter/material.dart';

class HistoricoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Medicamentos'),
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
        color: Colors.teal[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Histórico de Medicamentos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Adicione aqui a lista de histórico de medicamentos ou qualquer outro conteúdo relacionado ao histórico
            ],
          ),
        ),
      ),
    );
  }
}
