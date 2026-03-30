import 'package:flutter/material.dart';

import '../../constant/border/custom_border_radius.dart';
import '../../constant/color/custom_color.dart';
import '../../constant/font_size/custom_text_style.dart';
import '../../constant/padding/custom_padding.dart';

class CustomCard extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final String? buttonText;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final String? imageUrl;
  final Color? color1;
  final Color? color2;

  const CustomCard({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.buttonText,
    this.onTap,
    this.backgroundColor,
    this.borderRadius = 16,
    this.elevation = 4,
    this.padding,
    this.imageUrl,
    this.color1,
    this.color2
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();

    controller=AnimationController(vsync: this,duration: Duration(seconds: 1));
    colorAnimation=ColorTween(
      begin: widget.color1??CustomColor.general,
      end: widget.color2??CustomColor.general
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleTap() async {
    await controller.forward();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (BuildContext context, Widget? child) {
        return InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap:handleTap,
          child: Card(
            elevation: widget.elevation,
            color: widget.backgroundColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Padding(
              padding: widget.padding ?? CustomPadding.edgeAll8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null)
                    Center(
                      child: Icon(
                        widget.icon,
                        size: 30,
                        color: colorAnimation.value,
                      ),
                    ),
                  SizedBox(width:10,),
                  if (widget.icon != null) const SizedBox(height: 8),

                  if (widget.title != null)
                    Center(
                      child: Text(
                        widget.title!,
                        style: CustomTextStyles.bodyLarge.copyWith(color: colorAnimation.value),
                        overflow:TextOverflow.ellipsis,
                      ),
                    ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorAnimation.value,
                      ),
                    ),
                  if (widget.imageUrl != null)
                    ClipRRect(
                      borderRadius: CustomBorderRadius.cir12,
                      child: Image.network(
                        widget.imageUrl!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
    },
    );
  }
}
