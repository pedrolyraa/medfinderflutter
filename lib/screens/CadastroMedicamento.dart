
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CadastroMedicamento(),
    theme: ThemeData(
      primaryColor: Colors.teal, // Cor principal verde-água
    ),
  ));
}

class CadastroMedicamento extends StatefulWidget {
  @override
  _CadastroMedicamentoState createState() => _CadastroMedicamentoState();
}

class _CadastroMedicamentoState extends State<CadastroMedicamento> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _dailyUseController = TextEditingController();
  TextEditingController _totalQuantityController = TextEditingController();

  String selectedMedicamento = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Medicamento'),
      ),
      body: Column(
        children: <Widget>[
          // Parte superior da tela com a lupa e campo de busca
          Container(
            padding: EdgeInsets.all(16.0),
            color: Color(0xFF00695C), // Cor de fundo
            child: Row(
              children: [
                // Ícone de lupa
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(width: 16.0),
                // Campo de busca
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Digite o nome do medicamento',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Parte inferior da tela com os campos de entrada
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Color(0xFF00695C), // Cor de fundo
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Resultado da busca
                  if (selectedMedicamento.isNotEmpty)
                    Text(
                      'Medicamento Selecionado: $selectedMedicamento',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),

                  SizedBox(height: 20.0),

                  // Campos de entrada que ocupam a tela inteira
                  TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Quantidade (mL/gramas)',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  TextField(
                    controller: _dailyUseController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Quantidade diária',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  TextField(
                    controller: _totalQuantityController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Quantidade total na caixa',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  ElevatedButton(
                    onPressed: () {
                      // Implemente a lógica para salvar as informações
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Cor de fundo do botão
                      onPrimary: Colors.teal, // Cor do texto do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Salvar Informações',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
