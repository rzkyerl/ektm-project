import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ektm/services/api_service.dart'; // Pastikan baseUrl ada di sini

class SnapBayarPage extends StatelessWidget {
  final String snapToken;

  const SnapBayarPage({super.key, required this.snapToken});

  Future<void> _openSnap(BuildContext context) async {
    final url = Uri.parse(
      '${ApiService.baseUrl}/payments/snap-view?token=$snapToken',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // Buka di browser luar
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuka halaman pembayaran.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lanjut ke Pembayaran')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.payment),
          label: const Text('Bayar Sekarang'),
          onPressed: () => _openSnap(context),
        ),
      ),
    );
  }
}
