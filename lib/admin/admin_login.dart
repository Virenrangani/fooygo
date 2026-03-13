import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState(); // Renamed State class
}

class _AdminLoginState extends State<AdminLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight / 2.0),
                padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.08, right: screenWidth * 0.08),
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(80),
                        topEnd: Radius.circular(80)),
                    gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 52, 51, 51), Colors.black])
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.1),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Form(key: formKey,
                      child: Column(
                        children: [
                          Text('WELCOME TO ADMIN PANEL!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 26 : 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04,),
                          Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(

                              padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: screenHeight * 0.05),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01), // Responsive padding
                                    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your username';
                                        }
                                        return null;
                                      },
                                      controller: userController,
                                      decoration: InputDecoration(
                                        hintText: 'USERNAME',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your password';
                                        }
                                        return null;
                                      },
                                      controller: passController,
                                      obscureText: true, // Password field
                                      decoration: InputDecoration(
                                        hintText: 'PASSWORD',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      LoginAdmin();
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => adminHome()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                                      height: screenHeight * 0.06,
                                      width: screenWidth * 0.7,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.black
                                      ),
                                      child: Center(
                                        child: Text('LogIn', style: TextStyle(
                                            fontSize: isSmallScreen ? 20 : 23, // Responsive font size
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
              )
            ],
          ),
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((Snapshot) {
      Snapshot.docs.forEach((result) {
        if (result.data()['id'] != userController.text.trim())
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Provided ID is wrong')), // Changed message
          );
        else if (result.data()['password'] != passController.text.trim())
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Provided password is wrong')),
          );
      });
    });
  }
}