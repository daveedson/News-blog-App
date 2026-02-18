import 'package:flutter/material.dart';

class PageDots extends StatelessWidget {
  const PageDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(false),
        const SizedBox(width: 6),
        _dot(true),
        const SizedBox(width: 6),
        _dot(false),
      ],
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: active ? 22 : 7,
      height: 7,
      decoration: BoxDecoration(
        color: active
            ? Colors.white
            : Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
