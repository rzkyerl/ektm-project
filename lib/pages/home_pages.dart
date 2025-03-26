import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // app bar
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Icon(
            //         Icons.notifications_on,
            //         color: const Color.fromARGB(255, 171, 99, 99),
            //       ),
            //       Icon(
            //         Icons.menu,
            //         color: const Color.fromARGB(255, 118, 59, 59),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 34)),
                Text(
                  'Welcome, Nihat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 32)),
                Icon(
                  Icons.location_pin,
                  color: const Color.fromARGB(255, 184, 33, 33),
                  size: 20,
                ),
                Text(
                  'UBSI Slipi, Jakarta Barat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 25),
            Stack(
              children: [
                Container(
                  width: 366,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo_bg.png"),
                      fit: BoxFit.cover,
                      opacity: 30,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF57D4D4), // Biru Tua
                        Color(0xFF1E69DD), // Biru Muda
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Image.asset('assets/logo.png', width: 50)],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Nihat Hasaanto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '19230759 - 19.4A.26',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
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
                              color: Colors.grey[350],
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
                        children: [
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
    );
  }
}

// Custom Clipper untuk Rectangle
class RectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0); // Titik awal kiri atas
    path.lineTo(size.width - 20, 0); // Garis ke kanan atas (20px sebelum ujung)

    // Membuat efek rounded di kanan atas
    path.quadraticBezierTo(
      size.width,
      0, // Titik kontrol (menentukan lengkungan)
      size.width,
      20, // Titik tujuan (dimana lengkungan selesai)
    );

    path.lineTo(size.width, size.height); // Garis ke bawah
    path.lineTo(20, size.height); // Garis ke kiri bawah (20px sebelum ujung)

    // Rounded kiri bawah
    path.quadraticBezierTo(
      0,
      size.height, // Titik kontrol (menentukan lengkungan)
      0,
      size.height - 20, // Titik tujuan (dimana lengkungan selesai)
    );

    path.lineTo(0, 0); // Menutup path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
