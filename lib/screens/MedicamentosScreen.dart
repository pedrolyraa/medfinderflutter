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
              ElevatedButton(
                onPressed: () {
                  // Adicione a ação desejada ao pressionar o botão
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[900], // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Borda arredondada
                  ),
                ),
                child: Text(
                  'Adicionar Medicamento',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
