import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://fa7e-114-4-215-152.ngrok-free.app"; // base URL

  static Future<Map<String, dynamic>> loginMahasiswa(
    String nim,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mahasiswa/login'),
      headers: {'Accept': 'application/json'},
      body: {'nim': nim, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Tangani error lebih aman
      try {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Login gagal');
      } catch (_) {
        throw Exception('Login gagal. Status: ${response.statusCode}');
      }
    }
  }
}
