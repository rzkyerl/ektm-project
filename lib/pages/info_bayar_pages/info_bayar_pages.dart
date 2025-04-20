import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart'; // contoh dari Material Design Icons


// ignore: use_key_in_widget_constructors
class InfoBayarPage extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMenu = [
    {"icon": Mdi.credit_card_outline, "label": "Biaya Kuliah"},
    {"icon": Mdi.car, "label": "Cuti Akademik"},
    {"icon": Mdi.cash_sync, "label": "Mutasi"},
    {"icon": Mdi.run_fast, "label": "Kegiatan"},
    {"icon": Mdi.medal, "label": "Seminar"},
    {"icon": Mdi.trophy, "label": "Bootcamp"},
    {"icon": Mdi.school_outline, "label": "Wisuda"},
    {"icon": Mdi.file_document_outline, "label": "Ujian HER"},
    {"icon": Mdi.book_open_page_variant_outline, "label": "Skripsi / TA"},
    {"icon": Mdi.cube_outline, "label": "Admin Jaket KIP"},
    {"icon": Mdi.pencil_outline, "label": "TA Perbaikan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Pembayaran'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: paymentMenu.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = paymentMenu[index];
            return GestureDetector(
              onTap: () {
                // aksi ketika diklik
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Iconify(
                      item['icon'],
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['label'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
