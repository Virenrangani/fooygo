import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodygo/pages/profile.dart';
import 'package:foodygo/pages/wallet.dart';
import 'homepage.dart';
import 'order.dart';


class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _tabIndex = 0; // Starting index
  late List<Widget> _pages;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      Wallet(),
      Order(),
      Profile(),
    ];
    _currentPage = _pages[_tabIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(seconds:1),
        onTap: (int index) {
          setState(() {
            _tabIndex = index;
            _currentPage = _pages[_tabIndex];
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.wallet_outlined, color: Colors.white),
          Icon(Icons.shopping_cart_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: _currentPage,
    );
  }
}