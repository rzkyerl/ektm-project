import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ektm/pages/ektm_pages/barcode_pages.dart';

class ScannerPages extends StatefulWidget {
  const ScannerPages({super.key});

  @override
  State<ScannerPages> createState() => _ScannerPagesState();
}

class _ScannerPagesState extends State<ScannerPages> {
  String result = '';
  bool isScanned = false;
  bool isFlashOn = false;
  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      controller.toggleTorch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Back button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Scanner',
                        style: TextStyle(
                          color: Color(0xFFE0E0E0),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Placeholder for symmetry
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Teks instruksi atas
            const Text(
              'Scan Barcode Disini',
              style: TextStyle(
                color: Color(0xFFE0E0E0),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            // Area scanner dengan frame sudut
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: CustomPaint(
                        painter: _ScannerFramePainter(),
                      ),
                    ),
                    SizedBox(
                      width: 260,
                      height: 260,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: MobileScanner(
                          controller: controller,
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
                    ),
                  ],
                ),
              ),
            ),
            // Panel bawah
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFBDBDBD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Gunakan barcode untuk absen kegiatan.',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Tombol Barcode
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3A8DFF), Color(0xFF32C5FF)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const BarcodePages()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.qr_code, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'Barcode',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Tombol Flash
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: toggleFlash,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3A8DFF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(16),
                            elevation: 4,
                          ),
                          child: Icon(
                            isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 24,
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
    );
  }
}

// Custom painter untuk frame sudut scanner
class _ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const cornerLength = 32.0;
    const radius = 24.0;

    // Top left
    canvas.drawArc(
      Rect.fromLTWH(0, 0, radius, radius),
      3.14, 1.57, false, paint,
    );
    canvas.drawLine(Offset(0, radius / 2), Offset(0, cornerLength), paint);
    canvas.drawLine(Offset(radius / 2, 0), Offset(cornerLength, 0), paint);

    // Top right
    canvas.drawArc(
      Rect.fromLTWH(size.width - radius, 0, radius, radius),
      -1.57, 1.57, false, paint,
    );
    canvas.drawLine(Offset(size.width, radius / 2), Offset(size.width, cornerLength), paint);
    canvas.drawLine(Offset(size.width - radius / 2, 0), Offset(size.width - cornerLength, 0), paint);

    // Bottom left
    canvas.drawArc(
      Rect.fromLTWH(0, size.height - radius, radius, radius),
      1.57, 1.57, false, paint,
    );
    canvas.drawLine(Offset(0, size.height - radius / 2), Offset(0, size.height - cornerLength), paint);
    canvas.drawLine(Offset(radius / 2, size.height), Offset(cornerLength, size.height), paint);

    // Bottom right
    canvas.drawArc(
      Rect.fromLTWH(size.width - radius, size.height - radius, radius, radius),
      0, 1.57, false, paint,
    );
    canvas.drawLine(Offset(size.width, size.height - radius / 2), Offset(size.width, size.height - cornerLength), paint);
    canvas.drawLine(Offset(size.width - radius / 2, size.height), Offset(size.width - cornerLength, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
