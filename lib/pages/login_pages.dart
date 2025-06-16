import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ektm/components/my_button.dart';
import 'package:ektm/components/my_textfield.dart';
import 'package:ektm/pages/ektm_pages/home_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> signIn(BuildContext context) async {
    final nim = nimController.text.trim();
    final password = passwordController.text.trim();

    if (nim.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIM dan Password harus diisi')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
          'https://e26f-114-10-116-161.ngrok-free.app/api/mahasiswa/login',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nim': nim, // backend pakai email / nim
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // Ambil data yang dibutuhkan
        final String namaUser = data['name'];
        final String kampus = data['kampus'];

        // Navigasi sambil bawa data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePages(namaUser: namaUser, kampus: kampus),
          ),
        );
      } else {
        final msg = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login gagal: $msg')));
      }
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan koneksi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 150),
              const SizedBox(height: 10),
              const Text(
                'BSI.ID',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),

              MyTextfield(
                controller: nimController,
                keyboardType: TextInputType.number,
                hintText: "Masukkan NIM",
                labelText: "NIM",
                obscureText: false,
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20),

              MyTextfield(
                controller: passwordController,
                keyboardType: TextInputType.text,
                hintText: "Masukkan Password",
                labelText: "Password",
                obscureText: _obscureText,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),

              MyButton(onTap: () => signIn(context), text: 'Login'),
              const SizedBox(height: 20),

              const Text(
                'Untuk mahasiswa baru menggunakan password "ubsi2023". '
                'Standar dan langsung ganti password kamu segera.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
