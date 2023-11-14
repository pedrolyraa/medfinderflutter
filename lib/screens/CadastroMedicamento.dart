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
  List<String> searchResults = [];
  List<String> medicamentosCadastrados = ['Paracetamol', 'Analgésico', 'Pílula do dia seguinte'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 30, // Altura da barra superior (30 pixels)
            color: Colors.teal[800], // Cor da barra superior
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
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Pesquisar Medicamento',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            // Simulando a pesquisa com resultados fictícios
                            setState(() {
                              searchResults = _performSearch(value);
                            });
                          },
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () {
                              // Navegar para a próxima página com o resultado selecionado
                              _navigateToMedicamentoDetails(context, searchResults[index]);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.teal), // Cor do fundo verde-água
                              foregroundColor: MaterialStateProperty.all(Colors.white), // Cor do texto branco
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Borda arredondada
                              )),
                            ),
                            child: Text(searchResults[index]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _performSearch(String query) {
    // Simulando uma pesquisa fictícia. Substitua isso pela lógica de pesquisa real.
    List<String> results = [];
    for (String medicamento in medicamentosCadastrados) {
      if (medicamento.toLowerCase().contains(query.toLowerCase())) {
        results.add(medicamento);
      }
    }
    return results;
  }

  void _navigateToMedicamentoDetails(BuildContext context, String medicamento) {
    // Navegar para a próxima página e passar o nome do medicamento
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicamentoDetailsScreen(medicamento: medicamento),
      ),
    );
  }
}

class MedicamentoDetailsScreen extends StatelessWidget {
  final String medicamento;

  MedicamentoDetailsScreen({required this.medicamento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Medicamento'),
        backgroundColor: Colors.teal, // Cor de fundo da AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detalhes do medicamento: $medicamento'),
            SizedBox(height: 20), // Espaçamento entre o texto e o botão de voltar
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Ação de voltar para a página anterior
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal), // Cor do fundo verde-água
                foregroundColor: MaterialStateProperty.all(Colors.white), // Cor do texto branco
              ),
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
