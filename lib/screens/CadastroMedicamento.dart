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
      // Verifique se os campos do formulário estão preenchidos
      if (_nameMedController.text.isEmpty ||
          _descriptionController.text.isEmpty ||
          _quantityController.text.isEmpty ||
          _dailyUseController.text.isEmpty ||
          _totalQuantityController.text.isEmpty ||
          _typeMedController.text.isEmpty) {
        // Exiba uma mensagem ao usuário se algum campo estiver vazio
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Preencha todos os campos antes de cadastrar o medicamento."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Construa um objeto Medicine com os dados do formulário
      Medicine requestData = Medicine(
        name: _nameMedController.text,
        description: _descriptionController.text,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        dailyUse: int.tryParse(_dailyUseController.text) ?? 0,
        totalQuantity: int.tryParse(_totalQuantityController.text) ?? 0,
        type: _typeMedController.text,
      );

      // Chame a API para cadastrar o medicamento
      final response = await ApiService().registerMedication(
        requestData,
        "Seu_Token_Aqui",
      );

      // Verifique o resultado do cadastro
      if (response) {
        // Exiba uma mensagem ao usuário com o resultado do cadastro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Medicamento Cadastrado Com Sucesso!"),
            duration: Duration(seconds: 3),
          ),
        );

        // Limpe os campos do formulário após o cadastro
        _nameMedController.clear();
        _descriptionController.clear();
        _quantityController.clear();
        _dailyUseController.clear();
        _totalQuantityController.clear();
        _typeMedController.clear();
      } else {
        // Exiba uma mensagem ao usuário se houver um erro no cadastro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro durante o cadastro do medicamento. Tente novamente."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Trate os erros conforme necessário
      print('Erro durante o cadastro do medicamento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Medicamento'),
      ),
      body: Container(
        color: Color(0xFF00695c),
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('assets/images/splash.png', width: 100, height: 100),
              Text(
                'Digite as informações do medicamento que deseja cadastrar',
                style: TextStyle(
                  fontSize: 17,
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
                  backgroundColor: MaterialStateProperty.all(Color(0xFF00695c)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text('Cadastrar Medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CadastroMedicamento(),
    theme: ThemeData(
      primaryColor: Color(0xFF00695c),
    ),
  ));
}