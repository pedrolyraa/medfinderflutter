import 'package:flutter/material.dart';
import 'package:medfinderflutter/apis/medicineApiController.dart';

import '../apis/api_service.dart';

class CadastroMedicamento extends StatefulWidget {
  @override
  _CadastroMedicamentoState createState() => _CadastroMedicamentoState();
}

class _CadastroMedicamentoState extends State<CadastroMedicamento> {
  TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];
  String selectedMedicamento = '';
  List<String> medicamentosCadastrados = ['Paracetamol', 'Analgésico', 'Pílula do dia seguinte'];

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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLWFwaSIsInN1YiI6IjExMS4xMTEuMTExLTExIiwiZXhwIjoxNzAxNTc2Mjg4fQ.fOmEUDozFkZtTy-HtSGChIvVp5nLXqzD9WRRVi7IoVs",
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
      body: SingleChildScrollView (
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              color: Colors.teal[800],
            ),
            Container(
              color: Colors.teal[800],
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/splash.png', width: 100, height: 100),
                  Text(
                    'Digite o nome do medicamento que deseja cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),

            // Exiba as informações do medicamento se estiver disponível
            if (selectedMedicamento.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informações do Medicamento:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      selectedMedicamento,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Cadastro de Medicamento:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: _nameMedController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Digite o nome do Medicamento',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Quantidade (mL/gramas)',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _dailyUseController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Quantidade diária',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _totalQuantityController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Quantidade total na caixa',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Descrição do Remédio',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _typeMedController,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Comprimido ou Ml',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _cadastrarMedicamento,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text('Cadastrar Medicamento'),
            ),
          ],
        ),
      ),
    );
  }

//   void _navigateToMedicamentoDetails(BuildContext context, String medicamento) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MedicamentoDetailsScreen(medicamento: medicamento),
//       ),
//     );
//   }
// }

// class MedicamentoDetailsScreen extends StatelessWidget {
//   final String medicamento;
//
//   MedicamentoDetailsScreen({required this.medicamento});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalhes do Medicamento'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Detalhes do medicamento: $medicamento'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.teal),
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//               ),
//               child: Text('Voltar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}

void main() {
  runApp(MaterialApp(
    home: CadastroMedicamento(),
    theme: ThemeData(
      primaryColor: Colors.teal,
    ),
  ));
}
