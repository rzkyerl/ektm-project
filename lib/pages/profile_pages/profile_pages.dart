import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:ektm/pages/login_pages.dart';
import 'package:ektm/pages/ektm_pages/home_pages.dart';
import 'package:ektm/pages/info_bayar_pages/info_bayar_pages.dart';
import 'package:ektm/pages/berita_pages/berita_pages.dart';
import 'package:ektm/pages/profile_pages/kampus_ubsi.dart';
import 'package:ektm/pages/ektm_pages/scanner_pages.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  bool isLightMode = true;
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 366),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          'Menu Lainnya',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // Profile label
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Profile section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            const CircleAvatar(
                              radius: 36,
                              backgroundImage: AssetImage(
                                'assets/images/profile.png',
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              padding: const EdgeInsets.all(3),
                              child: const Iconify(
                                MaterialSymbols.check_circle,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Nihat Hasannanto",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "19230211",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Iconify(
                              MaterialSymbols.edit_square_outline,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // Mode Layar
                    const Text(
                      "Mode Layar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            onTap: () => setState(() => isLightMode = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isLightMode
                                        ? Colors.blue.withOpacity(0.08)
                                        : Colors.transparent,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Iconify(
                                    MaterialSymbols.light_mode,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Light Mode",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Spacer(),
                                  Radio<bool>(
                                    value: true,
                                    groupValue: isLightMode,
                                    activeColor: Colors.blue,
                                    onChanged: (val) {
                                      setState(() {
                                        isLightMode = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                            onTap: () => setState(() => isLightMode = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    !isLightMode
                                        ? Colors.blue.withOpacity(0.08)
                                        : Colors.transparent,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Iconify(
                                    MaterialSymbols.dark_mode,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Dark Mode",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Spacer(),
                                  Radio<bool>(
                                    value: false,
                                    groupValue: isLightMode,
                                    activeColor: Colors.blue,
                                    onChanged: (val) {
                                      setState(() {
                                        isLightMode = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Menu Lainnya
                    const Text(
                      "Menu Lainnya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _menuItem(
                      icon: Mdi.school_outline,
                      label: "Kampus UBSI",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KampusUBSIPages(),
                          ),
                        );
                      },
                    ),
                    _menuItem(
                      icon: Mdi.file_document_outline,
                      label: "Syarat dan Ketentuan",
                      onTap: () {},
                    ),
                    _menuItem(
                      icon: Mdi.information_outline,
                      label: "Tentang BSI.ID",
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    // Logout
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: 320,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 16,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Iconify(
                                        MaterialSymbols.logout,
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 18),
                                      const Text(
                                        'Apakah Anda yakin ingin Logout?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 28),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed:
                                                  () =>
                                                      Navigator.of(
                                                        context,
                                                      ).pop(),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                side: const BorderSide(
                                                  color: Colors.black,
                                                ),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                    ),
                                              ),
                                              child: const Text(
                                                'Tidak',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(
                                                  context,
                                                ).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (_) => LoginScreen(),
                                                  ),
                                                );
                                              },
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.blue,
                                                side: const BorderSide(
                                                  color: Colors.black,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                    ),
                                              ),
                                              child: const Text(
                                                'Iya',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 0,
                        ),
                        child: Row(
                          children: const [
                            Iconify(
                              MaterialSymbols.logout,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // Floating QR Scan Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScannerPages()),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const HomePages(namaUser: '', kampus: ''),
                    ),
                  );
                },
                child: _navItem(
                  const Iconify(
                    Bx.bxs_id_card,
                    color: Color.fromARGB(255, 157, 178, 206),
                  ),
                  'E-KTM',
                  _selectedIndex == 0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InfoBayarPages()),
                  );
                },
                child: _navItem(
                  const Iconify(
                    MaterialSymbols.payments_outline_sharp,
                    color: Color.fromARGB(255, 157, 178, 206),
                  ),
                  'Info Bayar',
                  _selectedIndex == 1,
                ),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BeritaPages(),
                    ),
                  );
                },
                child: _navItem(
                  const Iconify(
                    MaterialSymbols.receipt_long_outline,
                    color: Color.fromARGB(255, 157, 178, 206),
                  ),
                  'Berita',
                  _selectedIndex == 2,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage('assets/images/profile.png'),
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

  Widget _menuItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Row(
          children: [
            Iconify(icon, size: 20),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontSize: 15)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}
