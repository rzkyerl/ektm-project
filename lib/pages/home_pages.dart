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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'E-KTM',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // icon button
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.sunny),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF021ABF), // Biru Tua
                    Color(0xFF4158D0), // Biru Muda
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/logo_students.png', width: 80),
                      Image.asset('assets/logo.png', width: 50),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Mohammad Slltoni',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    '19230759',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '19.4A.26',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        'Tahun Masuk',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'S1/SISTEM INFORMASI',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        '2023/2',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
