import 'package:ektm/pages/berita_pages/berita_pages.dart';
import 'package:ektm/pages/info_bayar_pages/info_bayar_pages.dart';
import 'package:ektm/pages/profile_pages/profile_pages.dart';
import 'package:ektm/pages/ektm_pages/scanner_pages.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;

  int mahasiswaId = 0;
  String namaUser = '';
  String kampus = '';
  String email = '';
  String nim = '';
  String password = '';
  String kelas = ' ';
  String phone = '';
  String fakultas = '';
  String jurusan = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mahasiswaId = prefs.getInt('mahasiswaId') ?? 0; // <- ambil ID
      namaUser = prefs.getString('namaUser') ?? 'User';
      kampus = prefs.getString('kampus') ?? '-';
      email = prefs.getString('email') ?? '-';
      nim = prefs.getString('nim') ?? '-';
      password = prefs.getString('password') ?? '-';
      kelas = prefs.getString('kelas') ?? '-';
      phone = prefs.getString('phone') ?? '-';
      fakultas = prefs.getString('fakultas') ?? '-';
      jurusan = prefs.getString('jurusan') ?? '-';
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,

      // 1. APP BAR - POSISI PALING ATAS
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 45,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton: Support Agent
                IconButton(
                  icon: const Iconify(
                    MaterialSymbols.support_agent_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    debugPrint("Support Agent diklik");
                    const phoneNumber =
                        '62895395295511'; // Nomor WhatsApp admin (tanpa +)
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

                // IconButton: Notifikasi
                IconButton(
                  icon: const Iconify(
                    MaterialSymbols.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    debugPrint("Notifikasi diklik");
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
        ),
      ),
      // 2 & 3. BACKGROUND + E-KTM CARD
      body: Stack(
        children: [
          // 2. BACKGROUND CLIP
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: ClipPath(
              clipper: BgClipper(),
              child: Container(
                width: double.infinity,
                height: 498,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF75ABFF), // Warna biru
                      const Color.fromARGB(
                        0,
                        89,
                        169,
                        235,
                      ), // Pudar (transparan)
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. ISI E-KTM + BADGE
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, $namaUser!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.blue, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '$kampus!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Stack(
                    children: [
                      Container(
                        width: 466,
                        height: 181,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/card_bg.png"),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF57D4D4), Color(0xFF1E69DD)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$namaUser',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '$nim - $kelas',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'S1 - $jurusan',
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
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kegiatan Perkuliahan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
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
                              image: AssetImage("assets/images/Rectangle.png"),
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
                                      borderRadius: BorderRadius.circular(6),
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
                              image: AssetImage("assets/images/Rectangle2.png"),
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
                                      borderRadius: BorderRadius.circular(6),
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
                              image: AssetImage("assets/images/Rectangle.png"),
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
                                      borderRadius: BorderRadius.circular(6),
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data Mahasiswa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [Color(0xFF57D4D4), Color(0xFF1E69DD)],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16, color: Colors.white),
                            Text(
                              'Update Data',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Data Personal',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color((0xFF1E69DD)), Color(0xFF64B5F6)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Lengkap
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nama Lengkap",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$namaUser",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.white38, thickness: 1),
                        ),
                        // NIM
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.view_list_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nomor Induk Mahasiswa",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$nim",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.white38, thickness: 1),
                        ),
                        // Kelas
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.door_front_door,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kelas",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$kelas",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.white38, thickness: 1),
                        ),
                        // Phone
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.phone_android_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$phone",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.white38, thickness: 1),
                        ),
                        // Email
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Data Akademik',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E69DD), Color(0xFF64B5F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Lengkap
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.developer_board,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fakultas",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$fakultas",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.white38, thickness: 1),
                        ),

                        // Nama Lengkap
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.school_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jurusan",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$jurusan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Colors.white38, thickness: 1),
                        ),

                        // KAMPUS
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Icon(Icons.pin_drop, color: Colors.white),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kampus",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "$kampus",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),

      // 4. FLOATING SCAN QR BUTTON
      extendBody: true,
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

      // 5. NAVIGASI BAWAH
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePages()),
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
                  Navigator.push(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BeritaPages()),
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
                onTap: () {
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

// 2. Background clip
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

// 3. Badge lunas clip
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
