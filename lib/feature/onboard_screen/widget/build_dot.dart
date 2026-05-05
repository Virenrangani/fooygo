import 'package:flutter/material.dart';
import 'package:foodygo/core/constant/border/custom_border_radius.dart';
import 'package:foodygo/core/constant/color/custom_color.dart';
import 'package:foodygo/core/constant/margin/custom_margin.dart';

class BuildDot extends StatelessWidget {
  final bool isActive;

  const BuildDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: CustomMargin.edgeSymmetricHori8,
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? CustomColor.info : CustomColor.textSecondary,
        borderRadius: CustomBorderRadius.cir12,
      ),
    );
  }
}