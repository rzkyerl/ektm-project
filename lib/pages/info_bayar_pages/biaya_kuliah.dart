import 'package:flutter/material.dart';
import 'info_bayar_pages.dart';
import 'bayar_pages.dart';

class BiayaKuliahPage extends StatefulWidget {
  const BiayaKuliahPage({Key? key}) : super(key: key);

  @override
  State<BiayaKuliahPage> createState() => _BiayaKuliahPageState();
}

class _BiayaKuliahPageState extends State<BiayaKuliahPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InfoBayarPages()),
            );
          },
        ),
        title: const Text(
          'Rincian Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('images/profile.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nihat Hasannanto',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '19230211',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: _showAllPaymentMethods,
                  child: const Text('Lihat Semua', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            ...List.generate(3, (index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Image.asset(paymentMethods[index]['logo']!, width: 40, height: 30),
                  title: Text(
                    paymentMethods[index]['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Radio<int>(
                    value: index,
                    groupValue: _selectedPayment,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      setState(() {
                        _selectedPayment = val;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _selectedPayment = index;
                    });
                  },
                ),
              );
            }),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Rincian Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Biaya Kuliah Pokok', 'Rp2.580.000'),
            _buildDetailRow('Tambahan Jurusan', 'Rp700.000'),
            _buildDetailRow('Biaya Praktikum', 'Rp1.200.000'),
            _buildDetailRow('Biaya Ujian', 'Rp300.000'),
            _buildDetailRow('Biaya Kegiatan Mahasiswa', 'Rp400.000'),
            const Divider(),
            _buildDetailRow('Total', 'Rp3.280.000', isTotal: true),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payments, color: Colors.white),
                label: Text(
                  'Bayar Sekarang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedPayment != null ? Colors.white : Colors.grey[400],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedPayment != null ? Colors.blue : Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: _selectedPayment != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BayarPages(
                              status: 'pending',
                              bank: paymentMethods[_selectedPayment!]['name']!,
                              logo: paymentMethods[_selectedPayment!]['logo']!,
                              invoice: '1234567890954322376',
                              nama: 'Nihat Hasannanto',
                              nim: '19230211',
                              rincian: [
                                {'label': 'Biaya Kuliah Pokok', 'value': 'Rp2.580.000'},
                                {'label': 'Tambahan Jurusan', 'value': 'Rp700.000'},
                                {'label': 'Biaya Praktikum', 'value': 'Rp1.200.000'},
                                {'label': 'Biaya Ujian', 'value': 'Rp300.000'},
                                {'label': 'Biaya Kegiatan Mahasiswa', 'value': 'Rp400.000'},
                              ],
                              total: 'Rp3.280.000',
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showAllPaymentMethods() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Semua Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(paymentMethods.length, (index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: Image.asset(paymentMethods[index]['logo']!, width: 40, height: 24),
                      title: Text(
                        paymentMethods[index]['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Radio<int>(
                        value: index,
                        groupValue: _selectedPayment,
                        activeColor: Colors.blue,
                        onChanged: (val) {
                          setState(() {
                            _selectedPayment = val;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _selectedPayment = index;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),
                const SizedBox(height: 16),
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

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.black54,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 15,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.black87,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 22 : 15,
            ),
          ),
        ],
      ),
    );
  }
}
