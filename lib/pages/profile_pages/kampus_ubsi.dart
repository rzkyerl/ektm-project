import 'package:flutter/material.dart';
import 'maps_kampus.dart';

class KampusUBSIPages extends StatelessWidget {
  const KampusUBSIPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF75ABFF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.05, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Kampus UBSI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kampus Utama',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _kampusCard(
                          context,
                          image: 'assets/images/kramat98.png',
                          label: 'Rektorat',
                          labelColor: Colors.blue,
                          name: 'UBSI Kramat 98',
                          address: 'Jl. Kramat Raya No.98, RT.2/RW.9, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10450',
                          mapsUrl: 'https://maps.app.goo.gl/QLJb4hC94D1HmMBt7',
                        ),
                        const SizedBox(height: 16),
                        _kampusCard(
                          context,
                          image: 'assets/images/sartikaA.png',
                          label: 'Kantor Pusat UBSI',
                          labelColor: Colors.blue,
                          name: 'UBSI Dewi Sartika A',
                          address: 'Jl. Dewi Sartika Blok, Jl. H. Abdul Hamid No.77, RT.8/RW.4, Cawang, Kramat Jati, Jakarta Timur, Jakarta 13630',
                          mapsUrl: 'https://maps.app.goo.gl/vgsUfTf5R8VZpxwY6',
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Kampus Lainnya',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _kampusCard(
                          context,
                          image: 'assets/images/slipi.png',
                          label: '',
                          labelColor: Colors.transparent,
                          name: 'UBSI Slipi',
                          address: 'Jl. Kemanggisan Utama, RT.3/RW.2, Slipi, Kec. Palmerah, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11480',
                          mapsUrl: 'https://maps.app.goo.gl/43e9HKy2ftbV9FB56',
                        ),
                        const SizedBox(height: 16),
                        _kampusCard(
                          context,
                          image: 'assets/images/sartikaB.png',
                          label: '',
                          labelColor: Colors.transparent,
                          name: 'UBSI Dewi Sartika B',
                          address: 'Jl. Dewi Sartika No.2, RT.8/RW.4, Cawang, Kramat Jati, Jakarta Timur, Jakarta 13630',
                          mapsUrl: 'https://maps.app.goo.gl/pT3cNZdksdEvY4wB7',
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kampusCard(
    BuildContext context, {
    required String image,
    required String label,
    required Color labelColor,
    required String name,
    required String address,
    required String mapsUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MapsKampusPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    image,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (label.isNotEmpty)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: labelColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                    ),
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
