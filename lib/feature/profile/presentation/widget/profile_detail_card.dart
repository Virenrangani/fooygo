import 'package:flutter/material.dart';

class ProfileDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Container(
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
                  color: Colors.deepOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.deepOrange,
                  size: sw * 0.055,
                ),
              ),
              SizedBox(width: sw * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: sw * 0.032,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: sw * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}