import 'package:flutter/material.dart';
import '../../admin_add_food/presentation/page/add_food_page.dart';
import '../widget/admin_card.dart';
import '../widget/show_logout_diolog.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: sw,
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.06,
                  vertical: sh * 0.03,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Panel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sw * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'FoodyGo Dashboard',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: sw * 0.035,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(sw * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: sw * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sh * 0.03),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'What would you\nlike to do?',
                    style: TextStyle(
                      fontSize: sw * 0.06,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.03),
        
              AdminCard(
                  title: 'Add Food Item',
                  subtitle: 'Add new food to the menu\nwith image, price & details',
                  icon: Icons.restaurant_menu,
                  image: 'assets/image/salad.png',
                  color: Colors.deepOrange,
                  onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFoodPage()),
                ),
              ),
              SizedBox(height: sh * 0.02),
        
              AdminCard(
                  title: 'Add Ice Cream Item',
                  subtitle: 'Add ice cream flavors\nwith image, price & details',
                  icon: Icons.icecream,
                  image: 'assets/image/icecream.png',
                  color: Colors.pink,
                  onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFoodPage()),
                ),
              ),
              SizedBox(height: sh * 0.02),
        
              AdminCard(
                  title: 'Add Pizza Item',
                  subtitle: 'Add new pizza varieties\nwith image, price & details',
                  icon: Icons.local_pizza,
                  image: 'assets/image/pizza.png',
                  color: Colors.amber.shade700,
                  onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFoodPage()),
                ),
              ),
              SizedBox(height: sh * 0.02),
        
              AdminCard(
                title: 'Add Burger Item',
                subtitle: 'Add new burger varieties\nwith image, price & details',
                icon: Icons.lunch_dining,
                image: 'assets/image/burger.png',
                color: Colors.brown,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFoodPage()),
                ),
              ),
              SizedBox(height: sh * 0.03),
        
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.06,
                  vertical: sh * 0.01,
                ),
                child: GestureDetector(
                  onTap: () => showLogoutDialog(context),
                  child: Container(
                    width: sw,
                    padding: EdgeInsets.symmetric(vertical: sh * 0.018),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout,
                            color: Colors.white, size: 20),
                        SizedBox(width: sw * 0.02),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sw * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

