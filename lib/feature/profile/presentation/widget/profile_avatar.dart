import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? profileUrl;
  final File? selectedImage;
  final double size;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.profileUrl,
    required this.selectedImage,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(size / 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Stack(
            children: [
              _buildImage(size),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(double size) {
    if (selectedImage != null) {
      return Image.file(
        selectedImage!,
        height: size,
        width: size,
        fit: BoxFit.cover,
      );
    }
    if (profileUrl != null && profileUrl!.isNotEmpty) {
      return Image.network(
        profileUrl!,
        height: size,
        width: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            height: size,
            width: size,
            color: Colors.grey.shade200,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrange,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (_, _, _) => Image.asset(
          'assets/image/boy.jpeg',
          height: size,
          width: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      'assets/image/boy.jpeg',
      height: size,
      width: size,
      fit: BoxFit.cover,
    );
  }
}