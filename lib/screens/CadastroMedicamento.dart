import 'package:flutter/material.dart';
import 'package:medfinderflutter/apis/medicineApiController.dart';
import '../apis/api_service.dart';

class CadastroMedicamento extends StatefulWidget {
  @override
  _CadastroMedicamentoState createState() => _CadastroMedicamentoState();
}

class _CadastroMedicamentoState extends State<CadastroMedicamento> {
  TextEditingController _nameMedController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _dailyUseController = TextEditingController();
  TextEditingController _totalQuantityController = TextEditingController();
  TextEditingController _typeMedController = TextEditingController();

  void _cadastrarMedicamento() async {
    try {
      if (_nameMedController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _quantityController.text.isEmpty ||
          _dailyUseController.text.isEmpty ||
          _totalQuantityController.text.isEmpty ||
          _typeMedController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Preencha todos os campos antes de cadastrar o medicamento."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      Medicine requestData = Medicine(
        name: _nameMedController.text,
        description: _descriptionController.text,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        dailyUse: int.tryParse(_dailyUseController.text) ?? 0,
        totalQuantity: int.tryParse(_totalQuantityController.text) ?? 0,
        type: _typeMedController.text,
      );

      final response = await ApiService().registerMedication(
        requestData,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLWFwaSIsInN1YiI6IjExMS4xMTEuMTExLTExIiwiZXhwIjoxNzAxODcwMzk0fQ.8YOo292qkQz19Snm4uJJGbNY4SHxHU64hf8vjAYZH0o",
      );

      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Medicamento Cadastrado Com Sucesso!"),
            duration: Duration(seconds: 3),
          ),
        );

        _nameMedController.clear();
        _descriptionController.clear();
        _quantityController.clear();
        _dailyUseController.clear();
        _totalQuantityController.clear();
        _typeMedController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro durante o cadastro do medicamento. Tente novamente."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Erro durante o cadastro do medicamento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[900],
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('assets/images/splash.png', width: 100, height: 100),
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
              TextField(
                controller: _nameMedController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nome do Medicamento',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade (mL/gramas)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _dailyUseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade diária',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _totalQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantidade total na caixa',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Descrição do Remédio',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _typeMedController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Tipo (Comprimido ou mL)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cadastrarMedicamento,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                child: Text('Cadastrar Medicamento'),

              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}
