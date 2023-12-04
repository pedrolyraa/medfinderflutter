import 'package:flutter/material.dart';
import '../apis/api_service.dart';
import '../apis/medicineApiController.dart';

class MedicationSearchScreen extends StatefulWidget {
  const MedicationSearchScreen({Key? key}) : super(key: key);

  @override
  _MedicationSearchScreenState createState() => _MedicationSearchScreenState();
}

class _MedicationSearchScreenState extends State<MedicationSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();
  Medicine? selectedMedicamento;
  String errorMessage = '';

  void _searchMedication() async {
    String medicineName = _searchController.text;
    String token = _tokenController.text;

    try {
      final result = await ApiService().findMedicine(medicineName, token);

      setState(() {
        selectedMedicamento = result;
        errorMessage = '';
      });
    } catch (e) {
      print('Erro durante a busca do medicamento: $e');

      setState(() {
        selectedMedicamento = null;
        errorMessage = 'Erro durante a busca do medicamento: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Set the background color of the screen
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  height: 40, // Height of the custom bar
                  color: Colors.teal[900], // Color of the custom bar
                ),
                Container(
                  color: Colors.teal[900],
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/splash.png', width: 300, height: 100),
                      Text(
                        'Olá, bem-vindo ao MedFinder',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                // Separate column for the center elements
                Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Nome do Medicamento',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _tokenController,
                      decoration: InputDecoration(
                        labelText: 'Token',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _searchMedication();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[900], // Defina a cor desejada aqui
                      ),
                      child: Text('Buscar Medicamento'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Medicine Name: ${selectedMedicamento?.name ?? ''}',
                      style: TextStyle(fontSize: 18), // Defina o tamanho da fonte desejado
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description: ${selectedMedicamento?.description ?? ''}',
                      style: TextStyle(fontSize: 18), // Defina o tamanho da fonte desejado
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Quantidade Diaria: ${selectedMedicamento?.dailyUse ?? ''}',
                      style: TextStyle(fontSize: 18), // Defina o tamanho da fonte desejado
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Quantidade em ML: ${selectedMedicamento?.quantity ?? ''}',
                      style: TextStyle(fontSize: 18), // Defina o tamanho da fonte desejado
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Tipo De remedio: ${selectedMedicamento?.type ?? ''}',
                      style: TextStyle(fontSize: 18), // Defina o tamanho da fonte desejado
                    ),
                  ],
                ),

                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
