import 'dart:async';
import 'package:flutter/material.dart';
import 'carousel_item.dart';
import 'custom_carousel_indicator.dart';

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final PageController _controller = PageController(viewportFraction: 1.0);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> items = [
    {
      'title': 'Yuk, Daftar Beasiswanya\nSekarang!',
      'subtitle': 'Beasiswa terbatas, manfaatnya maksimal.',
      'imageAsset': 'assets/images/carousel_berita_pages1.png',
    },
    {
      'title': 'Untuk Kita Yang Saling\nMendukung!',
      'subtitle': 'Temukan ruang semua langkah dihargai.',
      'imageAsset': 'assets/images/carousel_berita_pages2.png',
    },
    {
      'title': 'Buktikan Potensimu\nLewat Beasiswa',
      'subtitle': 'Jangan lewatkan kesempatan langka ini.',
      'imageAsset': 'assets/images/carousel_berita_pages1.png',
    },
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        int next = (_currentPage + 1) % items.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });

    _controller.addListener(() {
      int next = _controller.page!.round();
      if (_currentPage != next) {
        setState(() => _currentPage = next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _controller,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CarouselItem(
                title: item['title']!,
                subtitle: item['subtitle']!,
                imageAsset: item['imageAsset']!,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        CustomCarouselIndicator(count: items.length, activeIndex: _currentPage),
      ],
    );
  }
}
