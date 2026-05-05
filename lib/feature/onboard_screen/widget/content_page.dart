import 'package:flutter/material.dart';
import 'package:foodygo/core/constant/padding/custom_padding.dart';

class ContentPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double screenWidth;
  final double screenHeight;

  const ContentPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.edgeAll20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}