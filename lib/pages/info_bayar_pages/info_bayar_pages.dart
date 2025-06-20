import 'package:ektm/pages/ektm_pages/notification_pages.dart';
import 'package:ektm/pages/info_bayar_pages/biaya_kuliah.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoBayarPages extends StatefulWidget {
  final int? mahasiswaId;
  const InfoBayarPages({super.key, this.mahasiswaId});

  @override
  State<InfoBayarPages> createState() => _InfoBayarPagesState();
}

class _InfoBayarPagesState extends State<InfoBayarPages> {
  int? mahasiswaId;

  @override
  void initState() {
    super.initState();
    _loadMahasiswaId();
  }

  Future<void> _loadMahasiswaId() async {
    if (widget.mahasiswaId != null) {
      setState(() {
        mahasiswaId = widget.mahasiswaId;
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        mahasiswaId = prefs.getInt('mahasiswaId') ?? 0;
      });
    }
  }

  @override
  // lanjut ke UI body-nya...
  @override
  Widget build(BuildContext context) {
    if (mahasiswaId == null || mahasiswaId == 0) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Map<String, dynamic>> menuItems = [
      {
        "label": "Biaya Kuliah",
        "icon": MaterialSymbols.attach_money,
        "route": (context) {
          if (mahasiswaId != null) {
            return BiayaKuliahPage(mahasiswaId: mahasiswaId!);
          } else {
            return const Scaffold(
              body: Center(child: Text('Mahasiswa ID tidak ditemukan')),
            );
          }
        },
      },
      {"label": "Cuti Akademik", "icon": MaterialSymbols.event_busy},
      {"label": "Mutasi", "icon": Mdi.swap_horizontal},
      {"label": "Kegiatan", "icon": Mdi.run},
      {"label": "Seminar", "icon": Mdi.school},
      {"label": "Bootcamp", "icon": Mdi.laptop},
      {"label": "Bootcamp", "icon": Mdi.airline_seat_legroom_normal},
      {"label": "Bootcamp", "icon": Mdi.account_group},
      {"label": "Bootcamp", "icon": Mdi.access_point_plus},
      {"label": "Bootcamp", "icon": Mdi.phone},
      {"label": "Bootcamp", "icon": Mdi.book},
      {"label": "Bootcamp", "icon": Mdi.abc},
      // Tambahkan menu lainnya...
    ];
    return Scaffold(
      backgroundColor: Colors.white,
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

          // Isi Konten
          SafeArea(
            child: Column(
              children: [
                // AppBar Custom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Iconify(
                          MaterialSymbols.support_agent_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          const phoneNumber = '62895395295511';
                          final message = Uri.encodeComponent(
                            "Halo Admin, izin bertanya...",
                          );
                          final url = Uri.parse(
                            "https://wa.me/$phoneNumber?text=$message",
                          );

                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Tidak bisa membuka WhatsApp';
                          }
                        },
                      ),
                      IconButton(
                        icon: const Iconify(
                          MaterialSymbols.notifications,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationPages(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Konten Utama
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Tentang Info Bayar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // CAROUSEL 1
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(12),
                              width: 212,
                              height: 85,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/Rectangle.png",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Padding(padding: EdgeInsets.only(left: 25)),
                                  Text(
                                    'jadwal Perkuliahan',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            size: 14,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            'Semester 4',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF1E69DD),
                                              Color(0xFF57D4D4),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '6 Hari',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // CAROUSEL 2
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(12),
                              width: 212,
                              height: 85,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/Rectangle2.png",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Padding(padding: EdgeInsets.only(left: 25)),
                                  Text(
                                    'Kalender Akademik',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            size: 14,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            'Universitas BSI',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF57D4D4),
                                              Color(0xFF1E69DD),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '6 Hari',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // CAROUSEL 3
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(12),
                              width: 212,
                              height: 85,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/Rectangle.png",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Padding(padding: EdgeInsets.only(left: 25)),
                                  Text(
                                    'jadwal Perkuliahan',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            size: 14,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            'Semester 4',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF1E69DD),
                                              Color(0xFF57D4D4),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          '6 Hari',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Menu Pembayaran",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children:
                            menuItems.map((item) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => item['route'](
                                            context,
                                          ), // <--- panggil fungsi
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Iconify(
                                        item['icon'],
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item['label'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
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
