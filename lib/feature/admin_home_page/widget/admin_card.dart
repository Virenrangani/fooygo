import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const AdminCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.image,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: sw * 0.05),
        padding: EdgeInsets.all(sw * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: sh * 0.1,
              width: sh * 0.1,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(sw * 0.02),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  color: color,
                ),
              ),
            ),
            SizedBox(width: sw * 0.04),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: sw * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: sh * 0.006),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: sw * 0.032,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(sw * 0.02),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}