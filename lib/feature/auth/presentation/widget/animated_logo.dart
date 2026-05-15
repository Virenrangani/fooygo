import 'package:flutter/material.dart';
import 'package:foodygo/core/constant/color/custom_color.dart';

import '../../../../core/constant/image/app_image/app_image.dart';

class PremiumLogoAnimation extends StatefulWidget {
  const PremiumLogoAnimation({super.key});

  @override
  State<PremiumLogoAnimation> createState() =>
      _PremiumLogoAnimationState();
}

class _PremiumLogoAnimationState
    extends State<PremiumLogoAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scale;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> blur;
  late Animation<double> move;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    scale = Tween<double>(
      begin: 0.2,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    rotation = Tween<double>(
      begin: -0.7,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.easeOutExpo,
        ),
      ),
    );

    opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.2,
          0.6,
          curve: Curves.easeIn,
        ),
      ),
    );

    blur = Tween<double>(
      begin: 25,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    move = Tween<double>(
      begin: 120,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, move.value),
          child: Opacity(
            opacity: opacity.value,
            child: Transform.scale(
              scale: scale.value,
              child: Transform.rotate(
                angle: rotation.value,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.25),
                        blurRadius: blur.value + 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: "app_logo",
                    child: Image.asset(
                      AppImage.foody,
                      color: CustomColor.background,
                      width: screenWidth / 2.3,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}