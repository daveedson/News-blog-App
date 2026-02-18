import 'package:flutter/material.dart';

class OverlayButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const OverlayButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
