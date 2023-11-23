import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmaciasProxScreen extends StatelessWidget {
  // Função para abrir o Google Maps
  void _openGoogleMaps() async {
    // URL com as coordenadas da localização desejada
    const url = 'https://www.google.com/maps?q=latitude,longitude'; // Substitua latitude e longitude

    // Verifica se é possível abrir a URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Caso não seja possível abrir a URL, exiba uma mensagem de erro
      throw 'Não foi possível abrir o Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmácias Próximas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Conteúdo da tela de Farmácias Próximas'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openGoogleMaps,
              child: Text('Abrir no Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}

