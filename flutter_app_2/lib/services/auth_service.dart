// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Para Flutter Web - usa localhost:3000
  final String baseUrl = 'http://localhost:3000/api_v1/apiUser';

  Future<Map<String, dynamic>> addApiUser(Map<String, dynamic> userData) async {
    try {
      print('🌐 Intentando conectar a: $baseUrl/register');
      
      final url = Uri.parse('$baseUrl/register');
      print('📍 URL completa: $url');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(userData),
      );

      print('📥 Status code: ${response.statusCode}');
      print('📥 Respuesta: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': 'Error ${response.statusCode}',
          'details': response.body
        };
      }
    } catch (e) {
      print('❌ Error completo: $e');
      return {
        'error': 'Error de conexión',
        'details': e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      print('🌐 Intentando login en: $baseUrl/login');
      
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'api_user': username,
          'api_password': password,
        }),
      );

      print('📥 Login status: ${response.statusCode}');
      print('📥 Login respuesta: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Error ${response.statusCode}'};
      }
    } catch (e) {
      print('❌ Error login: $e');
      return {'error': 'Error de conexión'};
    }
  }
}