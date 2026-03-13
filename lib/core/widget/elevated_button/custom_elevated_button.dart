import 'package:flutter/material.dart';

import '../../constant/color/custom_color.dart';
import '../../constant/font_size/custom_text_style.dart';


class CustomElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color1;
  final Color? color2;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.borderRadius=15,
    this.color1,
    this.color2,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    colorAnimation = ColorTween(
      begin: widget.color1 ?? CustomColor.primary.withOpacity(0.5),
      end: widget.color2 ?? CustomColor.primary,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleTap() async {
    if (widget.isLoading) return;

    await controller.forward();

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : handleTap,
            style: ElevatedButton.styleFrom(
              backgroundColor:colorAnimation.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
              ),
            ),
            child: widget.isLoading
                ? SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: CustomColor.border,
              ),
            )
                : Text(
                widget.text,
                style: CustomTextStyles.button
            ),
          ),
        );
      },
    );
  }
}
