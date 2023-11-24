import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class FarmaciasProxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmácias Próximas'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF00695C), // Cor de fundo #00695c
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone de mapa (place) maior
            Icon(
              Icons.place,
              color: Colors.white,
              size: 80.0,
            ),

            // Botão para buscar farmácias próximas no Google Maps
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  _openGoogleMapsForPharmacies();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[900], // Cor de fundo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Buscar Farmácias Próximas',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para abrir o Google Maps e pesquisar farmácias próximas
  void _openGoogleMapsForPharmacies() async {
    String searchQuery = 'farmácias próximas'; // Pesquisa por farmácias próximas
    String googleMapsUrl = 'https://www.google.com/maps/search/$searchQuery';

    // Verifica se o URL pode ser lançado
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      // Se não for possível lançar, exiba uma mensagem de erro
      print('Erro ao abrir o Google Maps');
    }
  }
}
