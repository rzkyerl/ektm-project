import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPages extends StatefulWidget {
  const ScannerPages({super.key});

  @override
  State<ScannerPages> createState() => _ScannerPagesState();
}

class _ScannerPagesState extends State<ScannerPages> {
  String result = '';
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: MobileScannerController(),
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (!isScanned && barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  setState(() {
                    isScanned = true;
                    result = barcodes.first.rawValue!;
                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                result.isEmpty ? 'Scan Barcode Di Sini' : result,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
