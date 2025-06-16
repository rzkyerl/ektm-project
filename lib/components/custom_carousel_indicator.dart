import 'package:flutter/material.dart';

class CustomCarouselIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;

  const CustomCarouselIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 36 : 4,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.brown.shade400,
            borderRadius: BorderRadius.circular(30),
          ),
        );
      }),
    );
  }
}
