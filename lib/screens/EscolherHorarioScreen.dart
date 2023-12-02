import 'package:flutter/material.dart';

class EscolherHorarioScreen extends StatefulWidget {
  @override
  _EscolherHorarioScreenState createState() => _EscolherHorarioScreenState();
}

class _EscolherHorarioScreenState extends State<EscolherHorarioScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800], // Cor da barra superior
        title: Text(
          'Escolher Horário',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Horário Selecionado para Tomar o Remédio: ${_selectedTime.format(context)}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Selecionar Horário'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[900], // Cor de fundo
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
