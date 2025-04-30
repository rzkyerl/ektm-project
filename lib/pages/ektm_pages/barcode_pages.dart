import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BarcodePages extends StatelessWidget {
  const BarcodePages({super.key});
  final String userName = "Nihat Hasannanto";
  final String userId = "19230211";
  final String barcodeData = "19230211";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'), // Ganti sesuai gambar
              radius: 24,
            ),
            SizedBox(height: 8),
            Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(userId, style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 24),
            QrImageView(
              data: barcodeData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 12),
            Text(
              'Gunakan barcode untuk absen kegiatan.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Text('Tap tombol di bawah untuk mulai scan barcode.'),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/scanner'),
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scan'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
