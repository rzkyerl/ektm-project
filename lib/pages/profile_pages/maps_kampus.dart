import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CampusLocation {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String image;
  final String mapsUrl;
  final String? phone;
  final String? email;

  const CampusLocation({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.mapsUrl,
    this.phone,
    this.email,
  });
}

class MapsKampusPage extends StatefulWidget {
  static const List<CampusLocation> allCampuses = [
    CampusLocation(
      name: 'Kampus Kramat 98',
      address: 'Jl. Kramat Raya No.98, Jakarta Pusat',
      latitude: -6.186486,
      longitude: 106.849979,
      image: 'assets/images/kramat98.png',
      mapsUrl: 'https://maps.app.goo.gl/QLJb4hC94D1HmMBt7',
      phone: '0211234567',
      email: 'info.kramat98@ubsi.ac.id',
    ),
    CampusLocation(
      name: 'Kampus Dewi Sartika A',
      address: 'Jl. Dewi Sartika No.1, Jakarta Timur',
      latitude: -6.263265,
      longitude: 106.864601,
      image: 'assets/images/sartikaA.png',
      mapsUrl: 'https://maps.app.goo.gl/vgsUfTf5R8VZpxwY6',
      phone: '0212345678',
      email: 'info.sartikaa@ubsi.ac.id',
    ),
    CampusLocation(
      name: 'Kampus Slipi',
      address: 'Jl. Slipi No.1, Jakarta Barat',
      latitude: -6.200484,
      longitude: 106.797282,
      image: 'assets/images/slipi.png',
      mapsUrl: 'https://maps.app.goo.gl/43e9HKy2ftbV9FB56',
      phone: '0213456789',
      email: 'info.slipi@ubsi.ac.id',
    ),
    CampusLocation(
      name: 'Kampus Dewi Sartika B',
      address: 'Jl. Dewi Sartika No.2, Jakarta Timur',
      latitude: -6.263265,
      longitude: 106.864601,
      image: 'assets/images/sartikaB.png',
      mapsUrl: 'https://maps.app.goo.gl/pT3cNZdksdEvY4wB7',
      phone: '0214567890',
      email: 'info.sartikab@ubsi.ac.id',
    ),
  ];

  const MapsKampusPage({super.key});

  @override
  State<MapsKampusPage> createState() => _MapsKampusPageState();
}

class _MapsKampusPageState extends State<MapsKampusPage> {
  int _currentIndex = 0;
  late final MapController _mapController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _pageController = PageController(viewportFraction: 0.85, initialPage: 0);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      final campus = MapsKampusPage.allCampuses[_currentIndex];
      _mapController.move(LatLng(campus.latitude, campus.longitude), 17);
    });
  }

  void _openGoogleMaps(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _callPhone(String? phone) async {
    if (phone != null) {
      final uri = Uri.parse('tel:$phone');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  void _sendEmail(String? email) async {
    if (email != null) {
      final uri = Uri.parse('mailto:$email');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final campus = MapsKampusPage.allCampuses[_currentIndex];
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(campus.latitude, campus.longitude),
              initialZoom: 17,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.ektm',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(campus.latitude, campus.longitude),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 48,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 48),
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 21,
                      child: ElevatedButton.icon(
                        onPressed: () => _openGoogleMaps(campus.mapsUrl),
                        icon: const Icon(Icons.navigation),
                        label: const Text('Buka di Google Maps'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: MapsKampusPage.allCampuses.length,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, index) {
                            final campus = MapsKampusPage.allCampuses[index];
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: _currentIndex == index ? 0 : 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      bottomLeft: Radius.circular(24),
                                    ),
                                    child: Image.asset(
                                      campus.image,
                                      height: 200,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            campus.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            campus.address,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.phone, color: Colors.blue),
                                                onPressed: () => _callPhone(campus.phone),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.email, color: Colors.blue),
                                                onPressed: () => _sendEmail(campus.email),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
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
}
