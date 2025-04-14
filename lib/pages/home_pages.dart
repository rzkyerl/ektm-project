import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background clipper di belakang
            Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: BgClipper(),
                child: Container(
                  width: 430,
                  height: 279,
                  color: Color(0xFF1E69DD),
                ),
              ),
            ),

            // AppBar custom di dalam Stack
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 45, // AppBar default height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Drawer button
                    Builder(
                      builder:
                          (context) => IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                    ),
                    // AppBar actions jika diperlukan
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                          ),

                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),

                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Konten utama di atas background
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    'Welcome, Nihat',
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

                  // Card Mahasiswa
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo_bg.png"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.dstATop,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF57D4D4), // Biru Tua
                              Color(0xFF1E69DD), // Biru Muda
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/logo.png', width: 50),
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
                      // Lunas badge
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
          ],
        ),
      ),
      // Drawer tetap di luar tetapi akan muncul di atas semua elemen
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1E69DD)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      'NH',
                      style: TextStyle(
                        color: Color(0xFF1E69DD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nihat Hasaanto',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    '19230759',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper background (di belakang card)
class BgClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double radius = 40;

    Path path = Path();
    path.lineTo(0, size.height - radius);

    // lengkungan kiri bawah
    path.quadraticBezierTo(0, size.height, radius, size.height);

    // garis bawah ke kanan
    path.lineTo(size.width - radius, size.height);

    // lengkungan kanan bawah
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );

    // garis ke kanan atas
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Badge clipper (untuk kotak "Lunas")
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
