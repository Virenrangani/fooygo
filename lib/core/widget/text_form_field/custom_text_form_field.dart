import 'package:flutter/material.dart';

import '../../constant/border/custom_border_radius.dart';
import '../../constant/color/custom_color.dart';
import '../../constant/padding/custom_padding.dart';

class CustomFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Color? borderColor;

  final bool obscureText;
  final int maxLines;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;

  const CustomFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.onSuffixTap,
    this.onChanged,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,

      style: const TextStyle(fontSize: 16),

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,

        prefixIcon:
        prefixIcon != null ? Icon(prefixIcon) : null,

        suffixIcon: suffixIcon != null
            ? IconButton(
          onPressed: onSuffixTap,
          icon: Icon(suffixIcon),
        )
            : null,

        contentPadding:CustomPadding.edgeSymmetricHori16Ver8,

        border: OutlineInputBorder(
          borderRadius: CustomBorderRadius.cir12,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: CustomBorderRadius.cir12,
          borderSide: const BorderSide(color: CustomColor.primarySurface),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: CustomBorderRadius.cir12,
          borderSide:  BorderSide(color:borderColor ??CustomColor.success, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: CustomBorderRadius.cir12,
          borderSide: const BorderSide(color: CustomColor.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: CustomBorderRadius.cir12,
          borderSide: const BorderSide(color: CustomColor.error, width: 2),
        ),
      ),
    );
  }
}