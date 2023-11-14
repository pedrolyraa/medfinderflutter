import 'package:flutter/material.dart';
import 'HistoricoScreen.dart';
import 'ConfiguracaoScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MedicamentosScreen(),
    HistoricoScreen(),
    ConfiguracaoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Medicamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuração',
          ),
        ],
      ),
      extendBody: true,
    );
  }
}

class MedicamentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remova a AppBar da aba "Medicamentos"
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
                  'Olá, bem-vindo ao MedFinder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.teal[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Meus Medicamentos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Adicione a ação desejada para cadastrar um medicamento
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Cadastrar Medicamento',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Adicione a ação desejada para ver os medicamentos
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Meus Medicamentos',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50, // Altura da barra inferior
            color: Colors.teal[800], // Cor da barra inferior
            alignment: Alignment.center,
            child: Text(
              'Olá, bem-vindo ao MedFinder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
