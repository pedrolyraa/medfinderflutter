import 'package:flutter/material.dart';

class MedicamentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Medicamentos'),
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
        color: Colors.teal[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Meus Medicamentos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Adicione aqui a lista de medicamentos ou qualquer outro conteúdo relacionado aos medicamentos
            ],
          ),
        ),
      ),
    );
  }
}
