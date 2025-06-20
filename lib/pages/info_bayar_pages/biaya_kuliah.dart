import 'dart:convert';
import 'package:ektm/services/api_service.dart';
import 'package:ektm/services/snap_bayar_pages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BiayaKuliahPage extends StatefulWidget {
  const BiayaKuliahPage({super.key, required int mahasiswaId});

  @override
  State<BiayaKuliahPage> createState() => _BiayaKuliahPageState();
}

class _BiayaKuliahPageState extends State<BiayaKuliahPage> {
  int? mahasiswaId;
  int? paymentId;
  String nama = '';
  String nim = '';
  int biayaPokok = 0;
  int biayaJurusan = 0;
  int biayaPraktikum = 0;
  int biayaUjian = 0;
  int biayaKegiatan = 0;
  int totalBiaya = 0;
  int? _selectedPayment;

  final List<Map<String, String>> paymentMethods = [
    {"logo": "images/bca.png", "name": "BCA"},
    {"logo": "images/bni.png", "name": "BNI"},
    {"logo": "images/bri.png", "name": "BRI"},
    {"logo": "images/mandiri.png", "name": "Mandiri"},
    {"logo": "images/cimb.png", "name": "CIMB"},
    {"logo": "images/permata.png", "name": "Permata"},
  ];

  @override
  void initState() {
    super.initState();
    getMahasiswaData();
  }

  Future<void> getMahasiswaData() async {
    final prefs = await SharedPreferences.getInstance();
    mahasiswaId = prefs.getInt('mahasiswaId');
    nama = prefs.getString('namaUser') ?? '';
    nim = prefs.getString('nim') ?? '';

    if (mahasiswaId != null) {
      final url = Uri.parse(
        '${ApiService.baseUrl}/api/get-payment/$mahasiswaId',
      );

      try {
        final response = await http.get(
          url,
          headers: {
            'Accept': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            biayaPokok = double.parse(data['biaya_pokok']).toInt();
            biayaJurusan = double.parse(data['biaya_tambahan_jurusan']).toInt();
            biayaPraktikum = double.parse(data['biaya_praktikum']).toInt();
            biayaUjian = double.parse(data['biaya_ujian']).toInt();
            biayaKegiatan = double.parse(data['biaya_kegiatan']).toInt();
            totalBiaya = double.parse(data['total']).toInt();
          });
        }
      } catch (e) {
        print('HTTP ERROR: $e');
      }
    }
  }

  String formatRupiah(int value) {
    return 'Rp' +
        value.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Rincian Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildMahasiswaHeader(),
            const SizedBox(height: 24),
            _buildPaymentSelection(),
            const SizedBox(height: 16),
            const Divider(),
            _buildPaymentDetails(),
            const Spacer(),
            _buildPayButton(context, mahasiswaId ?? 0),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMahasiswaHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 32,
          backgroundImage: AssetImage('images/profile.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              nim,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pilih Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              onPressed: _showAllPaymentMethods,
              child: const Text('Lihat Semua'),
            ),
          ],
        ),
        ...List.generate(3, (index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Image.asset(
                paymentMethods[index]['logo']!,
                width: 40,
                height: 30,
              ),
              title: Text(
                paymentMethods[index]['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Radio<int>(
                value: index,
                groupValue: _selectedPayment,
                onChanged: (val) => setState(() => _selectedPayment = val),
              ),
              onTap: () => setState(() => _selectedPayment = index),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rincian Pembayaran',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Biaya Kuliah Pokok', formatRupiah(biayaPokok)),
        _buildDetailRow('Tambahan Jurusan', formatRupiah(biayaJurusan)),
        _buildDetailRow('Biaya Praktikum', formatRupiah(biayaPraktikum)),
        _buildDetailRow('Biaya Ujian', formatRupiah(biayaUjian)),
        _buildDetailRow(
          'Biaya Kegiatan Mahasiswa',
          formatRupiah(biayaKegiatan),
        ),
        const Divider(),
        _buildDetailRow('Total', formatRupiah(totalBiaya), isTotal: true),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 15,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 22 : 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(BuildContext context, int mahasiswaId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.payments),
        label: Text(
          'Bayar Sekarang',
          style: TextStyle(
            color: _selectedPayment != null ? Colors.white : Colors.grey[400],
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedPayment != null ? Colors.blue : Colors.grey[400],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // ✅ Kirim context & mahasiswaId ke fungsi
        onPressed:
            _selectedPayment != null
                ? () => _bayarSekarang(context, mahasiswaId)
                : null,
      ),
    );
  }

  Future<void> _bayarSekarang(BuildContext context, int mahasiswaId) async {
    final apiUrl = '${ApiService.baseUrl}/api/snap-token';
    final selectedBank = paymentMethods[_selectedPayment!]['name']!;
    final selectedMethod = 'bank'; // karena kamu sedang pakai bank

    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/api/snap-token'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'mahasiswa_id': mahasiswaId,
          'payment_method': selectedMethod,
          'bank': selectedBank, // misalnya 'BCA'
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true && data['snap_token'] != null) {
          final snapToken = data['snap_token'];
          final snapUrl =
              'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken';

          if (await canLaunchUrl(Uri.parse(snapUrl))) {
            await launchUrl(
              Uri.parse(snapUrl),
              mode: LaunchMode.externalApplication,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tidak bisa membuka halaman pembayaran.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal mengambil Snap Token dari server.'),
            ),
          );
        }
      } else {
        print('Gagal mendapatkan Snap Token: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal terhubung ke server.')),
        );
      }
    } catch (e) {
      print('Error saat pembayaran: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan saat memproses pembayaran.'),
        ),
      );
    }
  }

  void _showAllPaymentMethods() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Semua Metode Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...List.generate(paymentMethods.length, (index) {
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        paymentMethods[index]['logo']!,
                        width: 40,
                      ),
                      title: Text(paymentMethods[index]['name']!),
                      trailing: Radio<int>(
                        value: index,
                        groupValue: _selectedPayment,
                        onChanged: (val) {
                          setState(() => _selectedPayment = val);
                          Navigator.pop(context);
                        },
                      ),
                      onTap: () {
                        setState(() => _selectedPayment = index);
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
