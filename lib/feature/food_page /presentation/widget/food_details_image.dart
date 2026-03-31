import 'package:flutter/material.dart';

class FoodDetailsImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const FoodDetailsImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: imageUrl.isEmpty
          ? Image.asset(
        'assets/image/food.png',
        width: width,
        height: height,
        fit: BoxFit.cover,
      )
          : Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey.shade100,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/image/food.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}