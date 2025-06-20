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
  late UserData _userData;

  @override
  void initState() {
    super.initState();
    _userData = UserData();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userData = UserData.fromSharedPreferences(prefs);
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
      appBar: _buildAppBar(),
      body: _buildBody(),
      extendBody: true,
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
              _buildSupportButton(),
              _buildNotificationButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton() {
    return IconButton(
      icon: const Iconify(
        MaterialSymbols.support_agent_rounded,
        color: Colors.white,
      ),
      onPressed: _openWhatsAppSupport,
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
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
    );
  }

  Future<void> _openWhatsAppSupport() async {
    const phoneNumber = '62895395295511';
    final message = Uri.encodeComponent("Halo Admin, izin bertanya...");
    final url = Uri.parse("https://wa.me/$phoneNumber?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka WhatsApp';
    }
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildBackground(),
        SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(),
                const SizedBox(height: 35),
                _buildEktmCard(),
                const SizedBox(height: 30),
                _buildKegiatanSection(),
                const SizedBox(height: 20),
                _buildDataMahasiswaSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: ClipPath(
        clipper: BgClipper(),
        child: Container(
          width: double.infinity,
          height: 498,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF75ABFF),
                Color.fromARGB(0, 89, 169, 235),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, ${_userData.namaUser}!',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_pin, color: Colors.blue, size: 20),
            const SizedBox(width: 4),
            Text(
              '${_userData.kampus}!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEktmCard() {
    return Stack(
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
                _userData.namaUser,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${_userData.nim} - ${_userData.kelas}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'S1 - ${_userData.jurusan}',
                    style: const TextStyle(
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
        _buildLunasBadge(),
      ],
    );
  }

  Widget _buildLunasBadge() {
    return Positioned(
      top: 0,
      right: 0,
      child: ClipPath(
        clipper: RectangleClipper(),
        child: Container(
          alignment: Alignment.center,
          width: 104,
          height: 40,
          color: Colors.green,
          child: const Row(
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
    );
  }

  Widget _buildKegiatanSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Kegiatan Perkuliahan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Icon(
              Icons.arrow_right_alt,
              color: Colors.black,
              size: 30,
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildKegiatanCarousel(),
      ],
    );
  }

  Widget _buildKegiatanCarousel() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildKegiatanCard(
            "assets/images/Rectangle.png",
            "jadwal Perkuliahan",
            "Semester 4",
            "6 Hari",
            const [Color(0xFF1E69DD), Color(0xFF57D4D4)],
          ),
          _buildKegiatanCard(
            "assets/images/Rectangle2.png",
            "Kalender Akademik",
            "Universitas BSI",
            "6 Hari",
            const [Color(0xFF57D4D4), Color(0xFF1E69DD)],
          ),
          _buildKegiatanCard(
            "assets/images/Rectangle.png",
            "jadwal Perkuliahan",
            "Semester 4",
            "6 Hari",
            const [Color(0xFF1E69DD), Color(0xFF57D4D4)],
          ),
        ],
      ),
    );
  }

  Widget _buildKegiatanCard(
    String imagePath,
    String title,
    String subtitle,
    String duration,
    List<Color> gradientColors,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      width: 212,
      height: 85,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lightbulb,
                    size: 14,
                    color: Colors.yellow,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
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
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.all(4),
                child: Text(
                  duration,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataMahasiswaSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Data Mahasiswa',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Color(0xFF57D4D4), Color(0xFF1E69DD)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              padding: const EdgeInsets.all(8),
              child: const Row(
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
        const SizedBox(height: 10),
        _buildDataPersonalCard(),
        const SizedBox(height: 20),
        _buildDataAkademikCard(),
      ],
    );
  }

  Widget _buildDataPersonalCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Personal',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E69DD), Color(0xFF64B5F6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              _buildDataRow(Icons.person, "Nama Lengkap", _userData.namaUser),
              _buildDataRow(Icons.view_list_rounded, "Nomor Induk Mahasiswa", _userData.nim),
              _buildDataRow(Icons.door_front_door, "Kelas", _userData.kelas),
              _buildDataRow(Icons.phone_android_rounded, "Phone", _userData.phone),
              _buildDataRow(Icons.email_outlined, "Email", _userData.email),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataAkademikCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Akademik',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E69DD), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              _buildDataRow(Icons.developer_board, "Fakultas", _userData.fakultas),
              _buildDataRow(Icons.school_rounded, "Jurusan", _userData.jurusan),
              _buildDataRow(Icons.pin_drop, "Kampus", _userData.kampus),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataRow(IconData icon, String label, String value) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
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
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
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
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      clipBehavior: Clip.antiAlias,
      color: const Color.fromARGB(255, 24, 24, 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              const Iconify(Bx.bxs_id_card, color: Color.fromARGB(255, 157, 178, 206)),
              'E-KTM',
              0,
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePages())),
            ),
            _buildNavItem(
              const Iconify(MaterialSymbols.payments_outline_sharp, color: Color.fromARGB(255, 157, 178, 206)),
              'Info Bayar',
              1,
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => InfoBayarPages())),
            ),
            const SizedBox(width: 40),
            _buildNavItem(
              const Iconify(MaterialSymbols.receipt_long_outline, color: Color.fromARGB(255, 157, 178, 206)),
              'Berita',
              2,
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => BeritaPages())),
            ),
            _buildProfileNavItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(Widget icon, String label, int index, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(color: _selectedIndex == index ? Colors.blue : Colors.grey[400]),
            child: icon,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.blue : Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileNavItem() {
    return GestureDetector(
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
              color: _selectedIndex == 3 ? Colors.blue : Colors.grey[300],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Data class untuk menyimpan data user
class UserData {
  int mahasiswaId;
  String namaUser;
  String kampus;
  String email;
  String nim;
  String password;
  String kelas;
  String phone;
  String fakultas;
  String jurusan;

  UserData({
    this.mahasiswaId = 0,
    this.namaUser = 'User',
    this.kampus = '-',
    this.email = '-',
    this.nim = '-',
    this.password = '-',
    this.kelas = '-',
    this.phone = '-',
    this.fakultas = '-',
    this.jurusan = '-',
  });

  factory UserData.fromSharedPreferences(SharedPreferences prefs) {
    return UserData(
      mahasiswaId: prefs.getInt('mahasiswaId') ?? 0,
      namaUser: prefs.getString('namaUser') ?? 'User',
      kampus: prefs.getString('kampus') ?? '-',
      email: prefs.getString('email') ?? '-',
      nim: prefs.getString('nim') ?? '-',
      password: prefs.getString('password') ?? '-',
      kelas: prefs.getString('kelas') ?? '-',
      phone: prefs.getString('phone') ?? '-',
      fakultas: prefs.getString('fakultas') ?? '-',
      jurusan: prefs.getString('jurusan') ?? '-',
    );
  }
}

// Custom clipper untuk background
class BgClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 40;
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Custom clipper untuk badge lunas
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
