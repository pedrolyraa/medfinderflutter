import 'package:flutter/material.dart';

class ConfiguracaoScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _parentPhoneNumberController = TextEditingController();
  TextEditingController _documentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Paciente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nome do Paciente
              Text(
                'Nome do Paciente:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Digite o nome do paciente',
                ),
              ),
              SizedBox(height: 16),

              // Número de Telefone
              Text(
                'Número de Telefone:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Digite o número de telefone',
                ),
              ),
              SizedBox(height: 16),

              // Número de Telefone do Responsável
              Text(
                'Número de Telefone do Responsável:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _parentPhoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Digite o número de telefone do responsável',
                ),
              ),
              SizedBox(height: 16),

              // Documentos
              Text(
                'Documentos:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _documentsController,
                decoration: InputDecoration(
                  hintText: 'Digite os documentos do paciente',
                ),
              ),
              SizedBox(height: 32),

              // Botão
              ElevatedButton(
                onPressed: () {
                  // Ação a ser executada ao pressionar o botão
                  _cadastrarPaciente();
                },
                child: Text('Cadastrar Paciente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cadastrarPaciente() {
    // Lógica para cadastrar o paciente
    String nome = _nameController.text;
    String telefone = _phoneNumberController.text;
    String telefoneResponsavel = _parentPhoneNumberController.text;
    String documentos = _documentsController.text;

    // Você pode implementar a lógica de envio ou armazenamento dos dados aqui
    print('Nome: $nome, Telefone: $telefone, Telefone do Responsável: $telefoneResponsavel, Documentos: $documentos');
  }
}

void main() {
  runApp(MaterialApp(
    home: ConfiguracaoScreen(),
    theme: ThemeData(
      primaryColor: Colors.teal,
    ),
  ));
}
