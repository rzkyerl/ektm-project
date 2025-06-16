import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String badge;

  const CarouselItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.badge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      width: 212,
      height: 85,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageAsset), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.lightbulb, size: 14, color: Colors.yellow),
                  const SizedBox(width: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E69DD), Color(0xFF57D4D4)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  badge,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
