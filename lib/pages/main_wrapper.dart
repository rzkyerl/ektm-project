import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';

// Import halaman-halamanmu
import 'package:ektm/pages/ektm_pages/home_pages.dart';
import 'package:ektm/pages/info_bayar_pages/info_bayar_pages.dart';
// ignore: unused_import
import 'package:ektm/pages/berita_pages/berita_pages.dart';
// ignore: unused_import
import 'package:ektm/pages/profile_pages/profile_pages.dart';

class MainWrapper extends StatefulWidget {
  final int initialIndex;
  const MainWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    HomePages(namaUser: '', kampus: ''),
    InfoBayarPages(),
    // BeritaPages(),
    // ProfilePages(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navItem(Widget icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey[300],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi Scan QR
        },
        backgroundColor: const Color(0xFF1E69DD),
        shape: const CircleBorder(),
        child: const Iconify(Mdi.line_scan, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: const Color.fromARGB(255, 24, 24, 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: _navItem(
                  const Iconify(MaterialSymbols.co_present_outline),
                  'E-KTM',
                  _selectedIndex == 0,
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: _navItem(
                  const Iconify(MaterialSymbols.payments_outline_sharp),
                  'Info Bayar',
                  _selectedIndex == 1,
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: _navItem(
                  const Iconify(MaterialSymbols.receipt_long_outline),
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
    );
  }
}
