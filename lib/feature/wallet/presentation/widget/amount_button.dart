import 'package:flutter/material.dart';

class AmountButton extends StatelessWidget {
  final String label;
  final int amount;
  final VoidCallback onTap;

  const AmountButton({
    super.key,
    required this.label,
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sw * 0.04,
          vertical: sw * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.deepOrange, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: sw * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}