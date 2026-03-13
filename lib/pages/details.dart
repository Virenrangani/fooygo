import 'package:flutter/material.dart';
import '../widget/service.dart';
import '../widget/sharedpref.dart';


class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
          {required this.detail,
        required this.image,
        required this.name,
        required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;

  getthesharedpref() async {
    id = await sharedPrefHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: screenHeight * 0.06, left: screenWidth * 0.05, right: screenWidth * 0.05), // Responsive margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: isSmallScreen ? 28 : 32,
                )),
            SizedBox(height:screenHeight * 0.04,),
            ClipRRect(
              borderRadius:BorderRadius.circular(30),
              child: Image.network(
                widget.image,
                width: screenWidth,
                height: screenHeight / 2.5,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.name,
                        style:TextStyle(fontSize: isSmallScreen ? 20 : 23,fontWeight:FontWeight.bold)
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.remove,size: isSmallScreen ? 26 : 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Text(
                    a.toString(),
                    style: TextStyle(fontSize: isSmallScreen ? 22 : 25,fontWeight:FontWeight.w500)
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.add,size: isSmallScreen ? 26 : 30,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.025,
            ),
            Text(
                widget.detail,
                maxLines: 4,
                style: TextStyle(fontSize: isSmallScreen ? 20 : 23,fontWeight:FontWeight.w500) // Responsive font size
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Row(
              children: [
                Text(
                    "Delivery Time",
                    style: TextStyle(fontSize: isSmallScreen ? 20 : 23,fontWeight:FontWeight.bold) // Responsive font size
                ),
                SizedBox(
                  width: screenWidth * 0.06,
                ),
                Icon(
                  Icons.alarm,size: isSmallScreen ? 28 : 32,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: screenWidth * 0.015,
                ),
                Text(
                    "30 min",
                    style: TextStyle(fontSize: isSmallScreen ? 20 : 23,fontWeight:FontWeight.w400)
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Total Price",
                          style: TextStyle(fontSize: isSmallScreen ? 26 : 30,fontWeight:FontWeight.bold)
                      ),
                      Text(
                          "\$" + total.toString(),
                          style: TextStyle(fontSize: isSmallScreen ? 20 : 23,fontWeight:FontWeight.w500)
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };
                      await dataBase().addFoodCart(addFoodtoCart,id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Food Added to Cart",
                            style: TextStyle(fontSize: 18.0),
                          )));
                    },
                    child: Container(
                      width: screenWidth / 2.5,
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 14 : 16.0,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(
                            width: screenWidth * 0.03,
                          ),
                          Container(
                            padding: EdgeInsets.all(screenWidth * 0.005),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: isSmallScreen ? 18 : 24,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}