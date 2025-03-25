import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:flutter_application_1/pages/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;
  late AnimationController _textController;
  late Animation<Offset> _textAnimation;
  late AnimationController _backgroundController;
  late Animation<Color?> _backgroundAnimation;

  bool showElements =
      true; // Menampilkan logo & teks sebelum animasi background

  @override
  void initState() {
    super.initState();

    // Animasi Logo
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Dari atas
      end: const Offset(0, 0), // Ke tengah
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _logoController.forward();

    // Animasi Teks muncul setelah logo selesai
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Mulai dari bawah
      end: const Offset(0, 0), // Ke tengah
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.forward();
      }
    });

    // Animasi Perubahan Warna Background
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _backgroundAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.blue[900], // Ubah ke warna biru gelap
    ).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeIn),
    );

    // Mulai perubahan background setelah teks muncul
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showElements =
              false; // Hilangkan logo & teks sebelum background berubah
        });
        _backgroundController.forward();
      }
    });

    // Pindah ke LoginScreen setelah animasi selesai
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            color: _backgroundAnimation.value,
            child: Center(
              child:
                  showElements
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position: _logoAnimation,
                            child: Image.asset('assets/logo.png', height: 100),
                          ),
                          const SizedBox(height: 10),
                          SlideTransition(
                            position: _textAnimation,
                            child: Text(
                              "BSI.ID",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
