import 'package:flutter/material.dart';
import 'package:ektm/components/my_button.dart';
import 'package:ektm/components/my_textfield.dart';
import 'package:ektm/pages/ektm_pages/home_pages.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true; // Untuk show/hide password

  void signIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePages(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset('assets/images/logo.png', width: 150),
                const SizedBox(height: 10),

                // Judul
                const Text(
                  'BSI.ID',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),

                // Input NIM
                MyTextfield(
                  controller: nimController,
                  keyboardType: TextInputType.number,
                  hintText: "Masukkan NIM",
                  labelText: "NIM",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20),

                // Input Password dengan fitur show/hide
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

                // Tombol Login
                MyButton(
                  onTap: () => signIn(context),
                  text: 'Login',
                ),
                const SizedBox(height: 20),

                // Informasi untuk mahasiswa baru
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: const Color.fromARGB(255, 36, 36, 36), fontSize: 10),
                    children: [
                      TextSpan(text: 'Untuk mahasiswa baru menggunakan password '),
                      TextSpan(
                        text: '"ubsi2023"',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '. Standar dan langsung ganti password kamu segera.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
