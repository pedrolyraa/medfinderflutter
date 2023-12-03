import 'package:flutter/material.dart';
import '../apis/api_service.dart';
import '../apis/medicineApiController.dart';

class MedicationSearchScreen extends StatefulWidget {
  const MedicationSearchScreen({super.key});

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
      appBar: AppBar(
        title: Text('Buscar Medicamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              child: Text('Buscar Medicamento'),
            ),
            SizedBox(height: 20),
            Column(children: [
              Text('Medicine Name: ${selectedMedicamento?.name ?? ''}'),
              Text('Description: ${selectedMedicamento?.description ?? ''}'),
              Text('Quantidade Diaria: ${selectedMedicamento?.dailyUse ?? ''}'),
              Text('Quantidade em ML: ${selectedMedicamento?.quantity ?? ''}'),
              Text('Tipo De remedio: ${selectedMedicamento?.type ?? ''}'),
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
    );
  }
}
