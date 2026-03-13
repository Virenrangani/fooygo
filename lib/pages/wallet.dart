import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/service.dart';
import '../widget/sharedpref.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int value = 100;
  final sharedPrefHelper _sharedPrefHelper = sharedPrefHelper();
  final dataBase _dataBase = dataBase();
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadWalletBalance();
  }

  Future<void> _loadWalletBalance() async {
    userId = await _sharedPrefHelper.getUserId() ?? '';
    int? savedBalance = int.tryParse(await _sharedPrefHelper.getUserWallet() ?? '100');
    if (savedBalance != null) {
      setState(() {
        value = savedBalance;
      });
    }
    //
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(userId).get();
    if (userDoc.exists && userDoc.data() != null) {
      setState(() {
        value = userDoc.get('wallet') ?? savedBalance;
      });
    }
  }

  Future<void> _updateWalletBalance(int amount) async {
    setState(() {
      value += amount;
    });
    await _sharedPrefHelper.saveWalletId(value.toString());
    await _dataBase.updateWalletBalance(userId, value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600; // Breakpoint for small screens

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Material(
                elevation: 10,
                child: Container(
                  color: Colors.white30,
                  margin: EdgeInsets.only(top: screenHeight * 0.08), // Responsive margin
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Responsive padding
                  child: Center(
                    child: Text(
                      'WALLET',
                      style: TextStyle(fontSize: isSmallScreen ? 26 : 30, fontWeight: FontWeight.bold), // Responsive font size
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive SizedBox
              Container(
                width: screenWidth,
                margin: EdgeInsets.all(screenWidth * 0.05), // Responsive margin
                child: Row(
                  children: [
                    Image.asset('assets/image/wallet.png',
                        height: screenHeight * 0.1, width: screenWidth * 0.2, fit: BoxFit.cover), // Responsive image size
                    SizedBox(width: screenWidth * 0.05), // Responsive SizedBox
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Wallet',
                          style: TextStyle(fontSize: isSmallScreen ? 22 : 25), // Responsive font size
                        ),
                        Text(
                          '\$$value',
                          style: TextStyle(
                              fontSize: isSmallScreen ? 22 : 25, fontWeight: FontWeight.bold), // Responsive font size
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive SizedBox
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(13),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0), // Added Padding
                  child: Text(
                    'Add Money',
                    style: TextStyle(fontSize: isSmallScreen ? 24 : 27, fontWeight: FontWeight.bold), // Responsive font size
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive SizedBox
              Material(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAmountButton('\$100', 100, isSmallScreen, screenWidth, screenHeight, context),
                      _buildAmountButton('\$500', 500, isSmallScreen, screenWidth, screenHeight, context),
                      _buildAmountButton('\$1000', 1000, isSmallScreen, screenWidth, screenHeight, context),
                      _buildAmountButton('\$2000', 2000, isSmallScreen, screenWidth, screenHeight, context),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive SizedBox
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.blueAccent,
                  ),
                  margin: EdgeInsets.all(screenWidth * 0.05), // Responsive margin
                  padding: EdgeInsets.all(screenHeight * 0.015), // Responsive padding
                  width: screenWidth,
                  child: Center(
                    child: Text(
                      'ADD MONEY',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildAmountButton(String text, int amount, bool isSmallScreen, double screenWidth, double screenHeight, BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.025), // Responsive padding
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: isSmallScreen ? 18 : 22, fontWeight: FontWeight.w600), // Responsive font size
        ),
      ),
      onTap: () {
        _updateWalletBalance(amount);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$text is added in your wallet',
                style: TextStyle(fontSize: isSmallScreen ? 20 : 24, color: Colors.orange)))); // Responsive font size
      },
    );
  }
}