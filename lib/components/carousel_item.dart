import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;

  const CarouselItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      width: 289,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.left,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
