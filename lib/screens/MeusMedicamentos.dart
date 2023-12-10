import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:medfinderflutter/apis/RequestPatient.dart';
import 'package:medfinderflutter/apis/medicineApiController.dart';
import '../apis/api_service.dart';

class MeusMedicamentosScreen extends StatefulWidget {
  @override
  _MeusMedicamentosScreenState createState() => _MeusMedicamentosScreenState();
}

class _MeusMedicamentosScreenState extends State<MeusMedicamentosScreen> {
  TextEditingController cpfController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController totalQuantityController = TextEditingController();
  List<String> medicamentos = [];

  double? remainingDaysResult; // Variável para armazenar o resultado

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('assets/images/icon.png', width: 180, height: 180),
              Text(
                'Digite as informações do medicamento que deseja cadastrar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Campo de entrada de texto para CPF
              TextField(
                controller: cpfController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, cpfFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Insira seu CPF',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.teal[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // Defina a cor do texto de dica (quando o campo está vazio) aqui
                  // No exemplo abaixo, a dica será branca
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: _tokenController,
                style: TextStyle(color: Colors.white), // Esta linha define a cor do texto
                decoration: InputDecoration(
                  labelText: 'Token',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.teal[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // Defina a cor do texto de dica (quando o campo está vazio) aqui
                  // No exemplo abaixo, a dica será branca
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),

              // Lista de Medicamentos (exibida somente após clicar no botão)
              if (medicamentos.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Medicamentos:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    for (String medicamento in medicamentos)
                      Text(
                        medicamento,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    SizedBox(height: 20),
                  ],
                ),

              // Botão para calcular dias restantes
              ElevatedButton(
                onPressed: () async {
                  // Ação a ser executada ao pressionar o botão
                  String cpf = cpfController.text;
                  String token = _tokenController.text; // Substitua com a função que retorna o token de autenticação

                  if (token != null) {
                    List<Medicine>? medicationsFound = await ApiService().getPatientMedications(cpf, token);

                    if (medicationsFound != null) {
                      setState(() {
                        // Atualize diretamente a lista de medicamentos no estado
                        medicamentos = medicationsFound.map((medication) => medication.name).toList();
                      });
                    } else {
                      // Trate o caso em que a lista de medicamentos não foi encontrada
                      print('Lista de medicamentos não encontrada');
                    }
                  } else {
                    // Trate o caso em que o token não foi obtido
                    print('Token não obtido');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Buscar Medicamentos'),
              ),
              SizedBox(height: 30),

              Text(
                'Informações do Medicamento:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),
              ),
              SizedBox(height: 8),

              // Campos de entrada para quantidade e quantidade total
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Uso diário',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.teal[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // Defina a cor do texto de dica (quando o campo está vazio) aqui
                  // No exemplo abaixo, a dica será branca
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: totalQuantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Quantidade Total de Unidades',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.teal[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // Defina a cor do texto de dica (quando o campo está vazio) aqui
                  // No exemplo abaixo, a dica será branca
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 30),

              // Botão para chamar a função
              ElevatedButton(
                onPressed: () async {
                  // Ação a ser executada ao pressionar o botão
                  double quantity = double.parse(quantityController.text);
                  double totalQuantity = double.parse(totalQuantityController.text);

                  // Chamar a função para calcular os dias restantes
                  double? remainingDays = await ApiService().calculateRemainingDays(quantity, totalQuantity);

                  setState(() {
                    remainingDaysResult = remainingDays; // Atualizar a variável do estado
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Calcular Dias Restantes'),
              ),

              SizedBox(height: 80),

              // Exibir o resultado
              if (remainingDaysResult != null)
                Text(
                  'Dias restantes do medicamento: $remainingDaysResult dias',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
