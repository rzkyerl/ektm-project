import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://127.0.0.1:8000/api/mahasiswa/login"; // emulator Android

  static Future<Map<String, dynamic>> loginMahasiswa(
    String nim,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Accept': 'application/json'},
      body: {'nim': nim, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // {"message": ..., "data": {...}}
    } else {
      throw Exception(json.decode(response.body)['message'] ?? 'Login gagal');
    }
  }
}
