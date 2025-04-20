import 'package:flutter/material.dart';
// ignore: unused_import, unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'qr_scanner_pages.dart';
import 'notification_pages.dart';


class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi Scan QR
        },
        backgroundColor: const Color(0xFF1E69DD),
        shape: const CircleBorder(),
        child: const Iconify(
          Mdi.line_scan,
          size: 28,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: _navItem(
                  const Iconify(MaterialSymbols.co_present_outline, color: Colors.white),
                  'E-KTM',
                  _selectedIndex == 0,
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: _navItem(
                  const Iconify(MaterialSymbols.payments_outline_sharp, color: Colors.white),
                  'Info Bayar',
                  _selectedIndex == 1,
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: _navItem(
                  const Iconify(MaterialSymbols.receipt_long_outline, color: Colors.white),
                  'Berita',
                  _selectedIndex == 2,
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(3),
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
                        color: _selectedIndex == 3 ? Colors.blue : Colors.grey[300],
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: ClipPath(
              clipper: BgClipper(),
              child: Container(
                width: 430,
                height: 279,
                color: const Color.fromARGB(255, 89, 169, 235),
              ),
            ),
          ),
          // Konten utama, beri jarak dari atas (biar ga tabrakan dengan AppBar)
          Positioned.fill(
            top: 45,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome, Nihat!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.location_pin, color: Colors.blue, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'UBSI Slipi, Jakarta Barat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/logo_bg.png"),
                            fit: BoxFit.cover,
                            opacity: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF57D4D4),
                              Color(0xFF1E69DD),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/logo_bsi.png', width: 50),
                            const SizedBox(height: 15),
                            const Text(
                              'Nihat Hasaanto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              '19230759 - 19.4A.26',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'S1 - SISTEM INFORMASI',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Maret, 2023',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ClipPath(
                          clipper: RectangleClipper(),
                          child: Container(
                            alignment: Alignment.center,
                            width: 104,
                            height: 40,
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Lunas',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ✅ AppBar di paling atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Iconify(MaterialSymbols.qr_code, color: Colors.white),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const QrScannerPages()),
                            );

                            if (result != null) {
                              // Lakukan sesuatu dengan hasil scan
                              debugPrint("Hasil Scan: $result");
                            }
                          },
                        ),
                        IconButton(
                          icon: const Iconify(MaterialSymbols.notifications, color: Colors.white),
                          onPressed: () {
                            debugPrint("Notifikasi diklik");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationPages()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
          data: IconThemeData(
            color: isActive ? Colors.blue : Colors.grey[400],
          ),
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

// Background biru clipper
class BgClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(0, size.height, 160, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Badge "Lunas"
class RectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
