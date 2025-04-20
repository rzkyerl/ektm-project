import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ektm/pages/login_pages.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  final List<String> bannerImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  void _launchURL() async {
    final Uri url = Uri.parse("https://www.bsiexplore.com/");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Gagal membuka URL");
    }
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % bannerImages.length;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50), // Ruang untuk status bar

          // HEADER
          const SizedBox(height: 20), //Ruang agar tidak terlalu mepet
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Selamat Datang 👋",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      Text(
                        "Di Universitas Bina Sarana Informatika",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30), // Jarak antara header dan banner

          // BANNER DENGAN PENGATURAN RESPONSIF
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 369, // Sesuaikan tinggi banner
                  width: MediaQuery.of(context).size.width * 0.8, // Lebar proporsional
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: bannerImages.length,
                    itemBuilder: (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        bannerImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // INDIKATOR SLIDER
                SmoothPageIndicator(
                  controller: _pageController,
                  count: bannerImages.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Color.fromARGB(255, 46, 8, 148),
                    dotHeight: 8,
                    dotWidth: 30,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15), // Jarak antara banner dan tombol

          // TOMBOL LOGIN & EXPLORE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40), // Mengurangi space bawah agar lebih seimbang
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ),
                  child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 8), // Mengurangi jarak antara tombol Login & Explore
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue[900]!), // Warna tombol Explore sama dengan Login
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _launchURL,
                  child: Text("Explore", style: TextStyle(color: Colors.blue[900]!, fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
