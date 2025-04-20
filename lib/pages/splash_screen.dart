import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;
  late AnimationController _textController;
  late Animation<Offset> _textAnimation;
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  bool showElements = true; // Menampilkan logo & teks

  @override
  void initState() {
    super.initState();

    // Animasi Logo menggunakan TweenSequence
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Durasi total animasi
    );

    _logoAnimation = TweenSequence<Offset>([
      // Tahap 1: Logo bergerak dari atas (Offset(0, -1)) ke tengah atas (Offset(0, -0.5)) dengan easing cepat
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, -2), 
          end: const Offset(0, -0.5))
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50, // Bobot durasi (50% dari total durasi)
      ),
      // Tahap 2: Logo bergerak dari tengah atas (Offset(0, -0.5)) ke tengah (Offset(0, 0)) dengan easing lambat
      TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0, 0.5), end: const Offset(0, 0))
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50, // Bobot durasi (50% dari total durasi)
      ),
    ]).animate(_logoController);

    _logoController.forward();

    // Animasi Text muncul dari bawah setelah logo selesai
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Mulai dari atas
      end: const Offset(0, 0), // Berhenti di bawah logo
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Memulai animasi teks setelah logo selesai
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.forward();
      }
    });

    // Animasi Pull-in Background Biru
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _backgroundAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _backgroundController, curve: Curves.easeIn));

    // Mulai background pull-in setelah teks muncul
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showElements = false; // Hilangkan logo & teks sebelum background berubah
        });
        _backgroundController.forward();
      }
    });

    // Pindah ke WelcomeScreen setelah animasi selesai
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
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
      body: Stack(
        children: [
          // Background putih ke biru dengan animasi pull-in
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            color: _backgroundAnimation.value == 1 ? Colors.blue[900] : Colors.white,
          ),
          // Logo & teks hanya muncul sebelum background pull-in
          if (showElements)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _logoAnimation,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SlideTransition(
                    position: _textAnimation,
                    child: Text(
                      "BSI E-KTM",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 20, 11, 148),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
