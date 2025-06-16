import 'package:ektm/components/berita_item_list.dart';
import 'package:ektm/components/carousel_example.dart';
import 'package:ektm/components/carousel_item.dart';
import 'package:ektm/pages/ektm_pages/home_pages.dart';
import 'package:ektm/pages/ektm_pages/notification_pages.dart';
import 'package:ektm/pages/ektm_pages/scanner_pages.dart';
import 'package:ektm/pages/info_bayar_pages/info_bayar_pages.dart';
import 'package:ektm/pages/profile_pages/profile_pages.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:url_launcher/url_launcher.dart';

class BeritaPages extends StatefulWidget {
  const BeritaPages({super.key});

  @override
  _BeritaPagesState createState() => _BeritaPagesState();
}

class _BeritaPagesState extends State<BeritaPages> {
  int _selectedIndex =
      0; // This will keep track of the selected index for bottom navigation

  final List<Map<String, String>> beritaList = [
    {
      "image": "assets/images/berita1.png",
      "title": "Update Seputar Dunia Mahasiswa",
      "desc": "Kabar terbaru tentang perkuliahan, komunit...",
      "time": "10 menit lalu",
    },
    {
      "image": "assets/images/berita2.png",
      "title": "Ada Apa di Kampus Minggu Ini?",
      "desc": "Cek kegiatan yang bisa kamu ikuti",
      "time": "1 jam lalu",
    },
    {
      "image": "assets/images/berita3.png",
      "title": "Beasiswa Terbaru Buat Kamu",
      "desc": "Daftar sekarang sebelum kuotanya habis. Ja...",
      "time": "10 menit lalu",
    },
    {
      "image": "assets/images/berita1.png",
      "title": "Workshop Keterampilan Digital",
      "desc": "Pelatihan untuk meningkatkan soft skill",
      "time": "1 jam lalu",
    },
    {
      "image": "assets/images/berita2.png",
      "title": "Pengumuman Jadwal Ujian",
      "desc": "Jadwal ujian akhir semester akan diumumkan",
      "time": "2 jam lalu",
    },
    {
      "image": "assets/images/berita3.png",
      "title": "Kalender Akademik 2025/2026",
      "desc": "Perubahan kalender akademik tahun 2025/2026",
      "time": "1 jam lalu",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Make sure FAB doesn't overlap the body
      // Floating Action Button (FAB)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScannerPages()),
          );
        },
        backgroundColor: const Color(0xFF1E69DD),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Iconify(Mdi.line_scan, size: 28, color: Colors.white),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        color: const Color.fromARGB(255, 24, 24, 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => HomePages(namaUser: '', kampus: ' '),
                    ),
                  );
                },
                child: _navItem(
                  const Iconify(
                    Bx.bxs_id_card,
                    color: Color.fromARGB(255, 140, 140, 140),
                  ),
                  'E-KTM',
                  _selectedIndex == 0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoBayarPages()),
                  );
                },
                child: _navItem(
                  const Iconify(
                    MaterialSymbols.payments_outline_sharp,
                    color: Color.fromARGB(255, 140, 140, 140),
                  ),
                  'Info Bayar',
                  _selectedIndex == 1,
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BeritaPages()),
                  );
                },
                child: _navItem(
                  const Iconify(
                    MaterialSymbols.receipt_long_outline,
                    color: Color.fromARGB(255, 140, 140, 140),
                  ),
                  'Berita',
                  _selectedIndex == 2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePages()),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color:
                            _selectedIndex == 3
                                ? Colors.blue
                                : Colors.grey[300],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Body Content
      body: Stack(
        children: [
          // Background Gradient
          ClipPath(
            clipper: BgClipper(),
            child: Container(
              width: double.infinity,
              height: 580,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF75ABFF), Color.fromARGB(0, 89, 169, 235)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: kToolbarHeight, // tinggi standar AppBar
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Arrow di kiri mentok
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Iconify(
                              MaterialSymbols.arrow_back_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          HomePages(namaUser: '', kampus: ''),
                                ),
                              );
                            },
                          ),
                        ),

                        // Teks di tengah
                        const Center(
                          child: Text(
                            "Berita",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Content Body
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Berita Terbaru",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      const CarouselExample(),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF0064FF),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              "Semua",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Mahasiswa",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Kegiatan",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Beasiswa",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // List berita
                      ...beritaList.map((berita) {
                        return BeritaItem(
                          image: berita['image']!,
                          title: berita['title']!,
                          desc: berita['desc']!,
                          time: berita['time']!,
                        );
                      }).toList(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(Widget icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme(
          data: IconThemeData(color: isActive ? Colors.blue : Colors.grey[400]),
          child: icon,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class BgClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 40;
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
