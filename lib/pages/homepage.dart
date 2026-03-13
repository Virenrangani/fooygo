import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widget/service.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? foodItemStream;
  bool icecream = false, pizza = true, burger = false, salad = false;

  ontheload() async {
    foodItemStream = await dataBase().getFoodItem('pizza');
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItem() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshots) {
        return snapshots.hasData
            ? ListView.builder(
          itemCount: snapshots.data.docs.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshots.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      detail: ds['details'],
                      image: ds['image'],
                      name: ds['name'],
                      price: ds['price'],
                    ),
                  ),
                );
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02), // Responsive padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            ds['image'],
                            height: MediaQuery.of(context).size.height * 0.2, // Responsive height
                            width: MediaQuery.of(context).size.width * 0.4,  // Responsive width
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        ds['name'],
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055, // Responsive font size
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Responsive SizedBox
                      Text(
                        ds['details'],
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.038), // Responsive font size
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Responsive SizedBox
                      Text(
                        '\$' + ds['price'],
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055, // Responsive font size
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget allItemVertical() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshots) {
        return snapshots.hasData
            ? ListView.builder(
          itemCount: snapshots.data.docs.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshots.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details( // Use responsive Details page
                      detail: ds['details'],
                      image: ds['image'],
                      name: ds['name'],
                      price: ds['price'],
                    ),
                  ),
                );
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015), // Responsive padding
                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05), // Responsive margin
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          ds['image'],
                          height: MediaQuery.of(context).size.height * 0.2, // Responsive height
                          width: MediaQuery.of(context).size.width * 0.4,  // Responsive width
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04), // Responsive SizedBox
                      Expanded( // Use Expanded to take remaining width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds['name'],
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.048, // Responsive font size
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ds['details'],
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035), // Responsive font size
                            ),
                            Text(
                              '\$' + ds['price'],
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.048, // Responsive font size
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : Center(child: CircularProgressIndicator()); // Centered Progress Indicator
      },
    );
  }

  void updateFoodStream(String foodType) async {
    foodItemStream = await dataBase().getFoodItem(foodType);
    setState(() {
      icecream = foodType == 'ice-cream';
      pizza = foodType == 'pizza';
      burger = foodType == 'burger';
      salad = foodType == 'salad';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07, vertical: screenHeight * 0.05), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(screenWidth * 0.04),
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: isSmallScreen ? 24 : 28,
                    ),
                  ),
                ],
              ),
              Text(
                'Delicious Food',
                style: TextStyle(
                  fontSize: isSmallScreen ? 26 : 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Discover and Get Great Food',
                style: TextStyle(fontSize: isSmallScreen ? 16 : 18, color: Colors.black), // Responsive font size
              ),
              SizedBox(height: screenHeight * 0.06), // Responsive SizedBox
              ShowMenuResponsive(
                icecream: icecream,
                pizza: pizza,
                burger: burger,
                salad: salad,
                onMenuTap: updateFoodStream,
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                height: screenHeight * 0.4,
                child: allItem(),
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                height: screenHeight * 0.3,
                child: allItemVertical(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowMenuResponsive extends StatelessWidget {
  final bool icecream, pizza, burger, salad;
  final Function(String) onMenuTap;

  ShowMenuResponsive({
    required this.icecream,
    required this.pizza,
    required this.burger,
    required this.salad,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => onMenuTap('ice-cream'),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: icecream ? Colors.black : Colors.white,
              ),
              padding: EdgeInsets.all(screenWidth * 0.015),
              child: Image.asset(
                'assets/image/icecream.png',
                color: icecream ? Colors.white : Colors.black,
                fit: BoxFit.cover,
                height: screenWidth * 0.12,
                width: screenWidth * 0.12,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onMenuTap('pizza'),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: pizza ? Colors.black : Colors.white,
              ),
              padding: EdgeInsets.all(screenWidth * 0.015), // Responsive padding
              child: Image.asset(
                'assets/image/pizza.png',
                color: pizza ? Colors.white : Colors.black,
                fit: BoxFit.cover,
                height: screenWidth * 0.12, // Responsive image height
                width: screenWidth * 0.12,  // Responsive image width
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onMenuTap('salad'),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: salad ? Colors.black : Colors.white,
              ),
              padding: EdgeInsets.all(screenWidth * 0.015), // Responsive padding
              child: Image.asset(
                'assets/image/salad.png',
                color: salad ? Colors.white : Colors.black,
                fit: BoxFit.cover,
                height: screenWidth * 0.12, // Responsive image height
                width: screenWidth * 0.12,  // Responsive image width
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onMenuTap('burger'),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: burger ? Colors.black : Colors.white,
              ),
              padding: EdgeInsets.all(screenWidth * 0.015), // Responsive padding
              child: Image.asset(
                'assets/image/burger.png',
                color: burger ? Colors.white : Colors.black,
                fit: BoxFit.cover,
                height: screenWidth * 0.12, // Responsive image height
                width: screenWidth * 0.12,  // Responsive image width
              ),
            ),
          ),
        ),
      ],
    );
  }
}