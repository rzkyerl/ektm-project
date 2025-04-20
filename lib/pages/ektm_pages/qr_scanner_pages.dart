import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPages extends StatelessWidget {
  const QrScannerPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? value = barcode.rawValue;
            if (value != null) {
              debugPrint('QR Code: $value');
              Navigator.pop(context, value);
              break;
            }
          }
        },
      ),
    );
  }
}
