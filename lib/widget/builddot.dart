import 'package:flutter/material.dart';

class BuildDot extends StatelessWidget {
  final bool isActive;

  const BuildDot({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey, // Customize colors
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}