import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodygo/pages/thankyou.dart';

import '../widget/service.dart';
import '../widget/sharedpref.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id, wallet;
  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      amount2 = total;
      setState(() {});
    });
  }

  Future<void> getSharedpref() async {
    id = await sharedPrefHelper().getUserId();
    wallet = await sharedPrefHelper().getUserWallet();
    setState(() {});
  }

  Future<void> onLoad() async {
    await getSharedpref();
    foodStream = await dataBase().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    onLoad();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                total = total + int.parse(ds["Total"]);
                return Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05, // Responsive margin
                      right: MediaQuery.of(context).size.width * 0.04, // Responsive margin
                      bottom: MediaQuery.of(context).size.height * 0.01), // Responsive margin
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03), // Responsive padding
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12, // Responsive height
                            width: MediaQuery.of(context).size.width * 0.12, // Responsive width
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(ds["Quantity"],
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05, // Responsive SizedBox
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  height: MediaQuery.of(context).size.height * 0.12, // Responsive height
                                  width: MediaQuery.of(context).size.height * 0.12, // Responsive width
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05, // Responsive SizedBox
                          ),
                          Expanded( // Use Expanded to take remaining width
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ds["Name"],
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis, // Handle long names
                                ),
                                Text(
                                  "\$" + ds["Total"],
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600; // Breakpoint for small screens

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: screenHeight * 0.08), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.015), // Responsive padding
                    child: Center(
                        child: Text(
                          "Food Cart",
                          style: TextStyle(fontSize: isSmallScreen ? 26 : 30, fontWeight: FontWeight.bold), // Responsive font size
                        )))),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
                height: screenHeight / 2, // Responsive height
                child: foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Total Price",
                      style: TextStyle(fontSize: isSmallScreen ? 24 : 26, fontWeight: FontWeight.bold) // Responsive font size
                  ),
                  Text(
                      "\$" + total.toString(),
                      style: TextStyle(fontSize: isSmallScreen ? 21 : 23, fontWeight: FontWeight.w500) // Responsive font size
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            GestureDetector(
              onTap: () async {
                int amount = int.parse(wallet!) - total;
                await dataBase().updateWalletBalance(id!, amount);
                await sharedPrefHelper().saveWalletId(amount.toString());
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => ThankYou()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015), // Responsive padding
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.025), // Responsive margin
                child: Center(
                    child: Text(
                      "CheckOut",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 18 : 20.0, // Responsive font size
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}