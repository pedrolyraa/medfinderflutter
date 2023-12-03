import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'RequestPatient.dart';
import 'medicineApiController.dart';

class ApiService {
  // static const String baseUrl = "http://192.168.0.193:8080/auth";
  static const String baseUrl = "http://10.0.2.2:8080/auth"; // Substitua pelo seu URL base 192.168.0.193



  final Dio _dio = Dio();

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



  Future<Medicine?> findMedicine(String medicineName, String token) async {
    try {
      final Uri url = Uri.parse('http://10.0.2.2:8080/medicine/find');

      final response = await http.get(
        url.replace(queryParameters: {'name': medicineName}),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final medicineJson = json.decode(response.body) as Map<String, dynamic>;
        final medicine = Medicine.fromJson(medicineJson);

        print('Medicine Name: ${medicine.name}');
        print('Description: ${medicine.description}');
        print('Quantidade Diaria: ${medicine.dailyUse}');
        print('Quantidade em ML: ${medicine.quantity}');
        print('Tipo De remedio: ${medicine.type}');

        // Adicione outras impressões conforme necessário

        return medicine;
      } else {
        print('Código de status diferente de 200: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
    }
  }





  Future<bool> registerMedication(Medicine data, String token) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/medicine/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': data.name,
          'description': data.description,
          'quantityML': data.quantity,
          'dailyUse': data.dailyUse,
          'totalQuantity': data.totalQuantity,
          'type': data.type,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      // Adicione tratamento de erros adequado, por exemplo, log ou relatório de erros
      print('Erro durante a solicitação de registro de medicamento: $e');
      return false;
    }
  }




  Future<bool> registerPatient(String token, RequestPatient data) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/patient/register'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': data.name,
          'phoneNumber': data.phoneNumber,
          'parentPhoneNumber': data.parentPhoneNumber,
          'documents': data.documents,
          'medication': data.medication.map((medication) => {
            'name': medication.name,
            'description': medication.description,
            'quantityML': medication.quantity,
            'dailyUse': medication.dailyUse,
            'totalQuantity': medication.totalQuantity,
            'type': medication.type,
          }).toList(),
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Log error details, and consider checking the response body for more information
        print('Erro durante a solicitação de registro de paciente. Status Code: ${response.statusCode}, Response Body: ${response.body}');
        return false;
      }
    } catch (e) {
      // Log or report the error
      print('Erro durante a solicitação de registro de paciente: $e');
      return false;
    }
  }


  Future<List<Medicine>?> getPatientMedications(String cpf, String token) async {
    try {
      final Uri url = Uri.parse('http://10.0.2.2:8080/patient/medications');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'documents': cpf}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> medicationsJson = json.decode(response.body);
        final List<Medicine> medications = medicationsJson
            .map((medicationJson) => Medicine.fromJson(medicationJson as Map<String, dynamic>))
            .toList();

        return medications;
      } else {
        print('Código de status diferente de 200: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
    }
  }


  Future<double?> calculateRemainingDays(double dailyUse, double totalQuantity) async {
    try {
      final Uri url = Uri.parse('http://10.0.2.2:8080/medicine/remaining');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'dailyUse': dailyUse,
          'totalQuantity': totalQuantity,
        }),
      );

      if (response.statusCode == 200) {
        final double remainingDays = json.decode(response.body) as double;
        return remainingDays;
      } else {
        print('Código de status diferente de 200: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
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
