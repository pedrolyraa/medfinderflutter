import 'package:flutter/material.dart';
import 'package:medfinderflutter/screens/MedicationSearchScreen.dart';
import 'package:provider/provider.dart';
import '../apis/AuthController.dart';
import 'ConfiguracaoScreen.dart';
import 'HistoricoScreen.dart';
import 'MedicamentosScreen.dart'; // Importe a classe ApiService para ter acesso ao token
import 'package:flutter/services.dart'; // Importe o pacote services.dart para acessar a área de transferência

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: MaterialApp(
        home: MenuScreen(),
      ),
    ),
  );
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
    final authController = Provider.of<AuthController>(context);

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
            label: '', // Rótulo vazio
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '', // Rótulo vazio
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '', // Rótulo vazio
          ),
        ],
        selectedItemColor: Colors.teal, // Cor dos ícones quando a página está ativa
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (authController.token != null) {
            // Copiar o token para a área de transferência
            Clipboard.setData(ClipboardData(text: authController.token!));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Token copiado para a área de transferência'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.vpn_key),
      ),
    );
  }
}
