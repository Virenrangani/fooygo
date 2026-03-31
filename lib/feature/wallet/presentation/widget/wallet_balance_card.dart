import 'package:flutter/material.dart';

class WalletBalanceCard extends StatelessWidget {
  final int balance;

  const WalletBalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Container(
      width: sw,
      margin: EdgeInsets.all(sw * 0.05),
      padding: EdgeInsets.all(sw * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepOrange, Colors.orangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Wallet',
            style: TextStyle(
              fontSize: sw * 0.04,
              color: Colors.white70,
            ),
          ),
          Text(
            '\$$balance',
            style: TextStyle(
              fontSize: sw * 0.07,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}