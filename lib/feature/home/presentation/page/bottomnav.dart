import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodygo/feature/cart/presentation/page/cart_page.dart';
import 'package:foodygo/pages/profile.dart';
import 'package:foodygo/feature/wallet/presentation/page/wallet.dart';
import 'homepage.dart';


class BottomNav extends StatefulWidget {
  final int index;
  const BottomNav({super.key, this.index=0});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  late int _tabIndex = widget.index;
  late List<Widget> _pages;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      WalletPage(),
      CartPage(),
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
        animationDuration: Duration(milliseconds:300),
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