import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const FoodImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final image = imageUrl.isEmpty
        ? Image.asset(
      'assets/image/food.png',
      height: height,
      width: width,
      fit: BoxFit.cover,
    )
        : Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: height,
          width: width,
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
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}