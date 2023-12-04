import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../apis/RequestPatient.dart';
import '../apis/api_service.dart';
import '../apis/medicineApiController.dart';

void main() {
  runApp(MaterialApp(
    home: ConfiguracaoScreen(),
    theme: ThemeData(
      primaryColor: Colors.teal,
    ),
  ));
}

class ConfiguracaoScreen extends StatefulWidget {
  @override
  _ConfiguracaoScreenState createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _parentPhoneNumberController = TextEditingController();
  TextEditingController _documentsController = TextEditingController();

  List<MedicationWidget> _medications = [];

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final phoneNumberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text('Cadastro de Paciente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, phoneNumberFormatter],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Digite o número de telefone',
                ),
              ),
              SizedBox(height: 16),

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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, phoneNumberFormatter],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Digite o número de telefone do responsável',
                ),
              ),
              SizedBox(height: 16),

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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, cpfFormatter],
                decoration: InputDecoration(
                  hintText: 'Digite os documentos do paciente',
                ),
              ),
              SizedBox(height: 32),

              Text(
                'Medicamentos:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: _medications,
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: _adicionarMedicamento,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Adicionar Medicamento'),
              ),

              ElevatedButton(
                onPressed: _cadastrarPaciente,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Cadastrar Paciente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _adicionarMedicamento() {
    setState(() {
      _medications.add(MedicationWidget());
    });
  }

  void _cadastrarPaciente() async {
    try {
      String nome = _nameController.text;
      String telefone = _phoneNumberController.text;
      String telefoneResponsavel = _parentPhoneNumberController.text;
      String documentos = _documentsController.text;

      String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLWFwaSIsInN1YiI6IjExMS4xMTEuMTExLTExIiwiZXhwIjoxNzAxNjY4NDUyfQ.5LHaPWz2wLW3BbwQNtv0Rt44McQ7iVFGOw41U9TaawI";

      List<Medicine> medications =
      _medications.map((medicationWidget) => medicationWidget.getMedication()).toList();

      RequestPatient requestPatient = RequestPatient(
        name: nome,
        phoneNumber: telefone,
        parentPhoneNumber: telefoneResponsavel,
        documents: documentos,
        medication: medications,
      );

      bool registrationSuccessful = await ApiService().registerPatient(token, requestPatient);

      if (registrationSuccessful) {
        print('Paciente registrado com sucesso!');
      } else {
        print('Erro ao registrar paciente. Verifique os dados e tente novamente.');
      }
    } catch (e) {
      print('Erro durante o processo de cadastro do paciente: $e');
    }
  }
}

class MedicationWidget extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _quantityMLController = TextEditingController();
  TextEditingController _dailyUseController = TextEditingController();
  TextEditingController _totalQuantityController = TextEditingController();
  TextEditingController _typeController = TextEditingController();

  Medicine getMedication() {
    return Medicine(
      name: _nameController.text,
      description: _descriptionController.text,
      quantity: int.tryParse(_quantityMLController.text) ?? 0,
      dailyUse: int.tryParse(_dailyUseController.text) ?? 0,
      totalQuantity: int.tryParse(_totalQuantityController.text) ?? 0,
      type: _typeController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Digite o nome do medicamento',
          ),
        ),
        SizedBox(height: 8),

        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: 'Digite a descrição do medicamento',
          ),
        ),
        SizedBox(height: 8),

        TextField(
          controller: _quantityMLController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Digite a quantidade em mL',
          ),
        ),
        SizedBox(height: 8),

        TextField(
          controller: _dailyUseController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Digite a quantidade diária',
          ),
        ),
        SizedBox(height: 8),

        TextField(
          controller: _totalQuantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Digite a quantidade total na caixa',
          ),
        ),
        SizedBox(height: 8),

        TextField(
          controller: _typeController,
          decoration: InputDecoration(
            hintText: 'Digite o tipo (Comprimido ou Ml)',
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

// class Medicine {
//   String name;
//   String description;
//   int quantity;
//   int dailyUse;
//   int totalQuantity;
//   String type;
//
//   Medicine({
//     required this.name,
//     required this.description,
//     required this.quantity,
//     required this.dailyUse,
//     required this.totalQuantity,
//     required this.type,
//   });

