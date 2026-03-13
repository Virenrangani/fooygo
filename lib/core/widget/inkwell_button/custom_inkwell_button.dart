import 'package:flutter/material.dart';


class CustomInkwellButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const CustomInkwellButton({
    super.key,
    required this.text,
    required this.onTap,
     this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Text(
          text,style: textStyle,
        ),
      ),
    );
  }
}