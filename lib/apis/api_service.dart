import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = "http://192.168.0.193:8080/auth";
  static const String baseUrl = "http://10.0.2.2:8080/auth"; // Substitua pelo seu URL base 192.168.0.193
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = baseUrl;
  }

  Future<String?> login(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['token'] as String?;
      } else {
        throw TokenNotRetrievedException("Token não retornado");
      }
    } catch (e) {
      print('Erro durante a solicitação de login: $e');
      return null;
    }
  }

  Future<bool> register(String login, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'login': login, 'password': password, 'role': role}),
      );

      return response.statusCode == 200;
    } catch (e) {
      // Adicione tratamento de erros adequado, por exemplo, log ou relatório de erros
      print('Erro durante a solicitação de registro: $e');
      return false;
    }
  }
}

class TokenNotRetrievedException implements Exception {
  final String message;

  TokenNotRetrievedException(this.message);

  @override
  String toString() {
    return 'TokenNotRetrievedException: $message';
  }
}
