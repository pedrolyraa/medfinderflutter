import 'package:flutter/material.dart';

class MeusMedicamentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Medicamentos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nome do Medicamento
              Text(
                'Nome do Medicamento:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Texto dinâmico ou vindo do banco de dados
              Text(
                'Paracetamol', // Substitua por dados reais
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              // Nome do Paciente
              Text(
                'Nome do Paciente:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Texto dinâmico ou vindo do banco de dados
              Text(
                'João Silva', // Substitua por dados reais
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 32),

              // Botão
              ElevatedButton(
                onPressed: () {
                  // Ação a ser executada ao pressionar o botão
                  print('Botão pressionado');
                },
                child: Text('Ação do Botão'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


