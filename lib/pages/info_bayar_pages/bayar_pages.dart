import 'package:flutter/material.dart';

class BayarPages extends StatelessWidget {
  final String status; // 'pending' atau 'success'
  final String bank;
  final String logo;
  final String invoice;
  final String nama;
  final String nim;
  final List<Map<String, String>> rincian;
  final String total;

  const BayarPages({
    Key? key,
    required this.status,
    required this.bank,
    required this.logo,
    required this.invoice,
    required this.nama,
    required this.nim,
    required this.rincian,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSuccess = status == 'success';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                isSuccess ? 'images/frame_sukses.png' : 'images/frame_wait.png',
                width: 255, height: 215,
              ),
              const SizedBox(height: 8),
              const Text('Invoice', style: TextStyle(fontSize: 14, color: Colors.black54)),
              Text(
                invoice,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(nim, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(logo, width: 32, height: 20),
                        const SizedBox(width: 6),
                        Text(bank, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Rincian Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 8),
              ...rincian.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['label']!, style: const TextStyle(color: Colors.black54)),
                    Text(item['value']!, style: const TextStyle(color: Colors.black87)),
                  ],
                ),
              )),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text('Kembali ke E-KTM', style: TextStyle (color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
