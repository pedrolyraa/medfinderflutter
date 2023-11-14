import 'package:flutter/material.dart';
import 'HistoricoScreen.dart';
import 'ConfiguracaoScreen.dart';
import 'MedicamentosScreen.dart';

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

