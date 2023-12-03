import 'package:flutter/material.dart';
import 'FarmaciasProxScreen.dart';
import 'CadastroMedicamento.dart';
import 'EscolherHorarioScreen.dart';

class MedicamentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CadastroMedicamento()),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EscolherHorarioScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Meus Medicamentos',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Escolher Horário',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FarmaciasProxScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Farmácias Próximas',
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
            height: 50,
            color: Colors.teal[800],
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
