import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:url_launcher/url_launcher.dart';

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
}

// Widget untuk App Bar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationPressed;

  const HomeAppBar({
    super.key,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
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
      onPressed: onNotificationPressed,
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

  @override
  Size get preferredSize => const Size.fromHeight(45);
}

// Widget untuk Background
class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
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
}

// Widget untuk Welcome Section
class WelcomeSection extends StatelessWidget {
  final UserData userData;

  const WelcomeSection({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, ${userData.namaUser}!',
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
              '${userData.kampus}!',
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
}

// Widget untuk E-KTM Card
class EktmCard extends StatelessWidget {
  final UserData userData;

  const EktmCard({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
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
                userData.namaUser,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${userData.nim} - ${userData.kelas}',
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
                    'S1 - ${userData.jurusan}',
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
        const LunasBadge(),
      ],
    );
  }
}

// Widget untuk Badge Lunas
class LunasBadge extends StatelessWidget {
  const LunasBadge({super.key});

  @override
  Widget build(BuildContext context) {
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
}

// Widget untuk Kegiatan Section
class KegiatanSection extends StatelessWidget {
  const KegiatanSection({super.key});

  @override
  Widget build(BuildContext context) {
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              KegiatanCard(
                imagePath: "assets/images/Rectangle.png",
                title: "jadwal Perkuliahan",
                subtitle: "Semester 4",
                duration: "6 Hari",
                gradientColors: const [Color(0xFF1E69DD), Color(0xFF57D4D4)],
              ),
              KegiatanCard(
                imagePath: "assets/images/Rectangle2.png",
                title: "Kalender Akademik",
                subtitle: "Universitas BSI",
                duration: "6 Hari",
                gradientColors: const [Color(0xFF57D4D4), Color(0xFF1E69DD)],
              ),
              KegiatanCard(
                imagePath: "assets/images/Rectangle.png",
                title: "jadwal Perkuliahan",
                subtitle: "Semester 4",
                duration: "6 Hari",
                gradientColors: const [Color(0xFF1E69DD), Color(0xFF57D4D4)],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget untuk Kegiatan Card
class KegiatanCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String duration;
  final List<Color> gradientColors;

  const KegiatanCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
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
}

// Widget untuk Data Mahasiswa Section
class DataMahasiswaSection extends StatelessWidget {
  final UserData userData;

  const DataMahasiswaSection({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
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
        DataPersonalCard(userData: userData),
        const SizedBox(height: 20),
        DataAkademikCard(userData: userData),
      ],
    );
  }
}

// Widget untuk Data Personal Card
class DataPersonalCard extends StatelessWidget {
  final UserData userData;

  const DataPersonalCard({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
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
              DataRow(Icons.person, "Nama Lengkap", userData.namaUser),
              DataRow(Icons.view_list_rounded, "Nomor Induk Mahasiswa", userData.nim),
              DataRow(Icons.door_front_door, "Kelas", userData.kelas),
              DataRow(Icons.phone_android_rounded, "Phone", userData.phone),
              DataRow(Icons.email_outlined, "Email", userData.email),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget untuk Data Akademik Card
class DataAkademikCard extends StatelessWidget {
  final UserData userData;

  const DataAkademikCard({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
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
              DataRow(Icons.developer_board, "Fakultas", userData.fakultas),
              DataRow(Icons.school_rounded, "Jurusan", userData.jurusan),
              DataRow(Icons.pin_drop, "Kampus", userData.kampus),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget untuk Data Row
class DataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DataRow(
    this.icon,
    this.label,
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

// Widget untuk Bottom Navigation Bar
class HomeBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HomeBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
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
            ),
            _buildNavItem(
              const Iconify(MaterialSymbols.payments_outline_sharp, color: Color.fromARGB(255, 157, 178, 206)),
              'Info Bayar',
              1,
            ),
            const SizedBox(width: 40),
            _buildNavItem(
              const Iconify(MaterialSymbols.receipt_long_outline, color: Color.fromARGB(255, 157, 178, 206)),
              'Berita',
              2,
            ),
            _buildProfileNavItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(Widget icon, String label, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(color: selectedIndex == index ? Colors.blue : Colors.grey[400]),
            child: icon,
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.blue : Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileNavItem() {
    return GestureDetector(
      onTap: () => onItemTapped(3),
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
              color: selectedIndex == 3 ? Colors.blue : Colors.grey[300],
              fontSize: 12,
            ),
          ),
        ],
      ),
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