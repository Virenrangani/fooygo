import 'package:flutter/material.dart';

class ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onTap;

  const ProfileActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: sw * 0.05),
        child: Material(
          borderRadius: BorderRadius.circular(14),
          elevation: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: sh * 0.02,
              horizontal: sw * 0.04,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(sw * 0.025),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: sw * 0.055,
                  ),
                ),
                SizedBox(width: sw * 0.04),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: sw * 0.042,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: sw * 0.04,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}