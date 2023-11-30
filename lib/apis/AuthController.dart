import 'package:flutter/material.dart';
import 'api_service.dart';

class AuthController extends ChangeNotifier {
  final ApiService apiService = ApiService();
  String? _token;

  String? get token => _token;

  Future<void> login(String login, String password) async {
    try {
      final newToken = await apiService.login(login, password);
      if (newToken != null) {
        _token = newToken;
        notifyListeners();
      }
    } catch (e) {
      // Tratamento de erro adequado, por exemplo, log ou relatório de erros
      print('Erro durante o login: $e');
    }
  }

  Future<bool> register(String login, String password, String role) async {
    try {
      final success = await apiService.register(login, password, role);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (e) {
      // Tratamento de erro adequado, por exemplo, log ou relatório de erros
      print('Erro durante o registro: $e');
      return false;
    }
  }
}
