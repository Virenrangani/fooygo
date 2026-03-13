import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth/auth_state.dart';
import '../cubit/auth/signup_cubit.dart';
import 'bottomnav.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        body: BlocConsumer<SignupCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Account Created Successfully!")),
              );
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=>BottomNav())
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: screenHeight / 2,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.deepOrange.shade200, Colors.deepOrange],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight / 3),
                    height: screenHeight / 2,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.1),
                        child: Center(
                          child: Image.asset(
                            'assets/image/food.png',
                            color: Colors.black,
                            width: screenWidth / (isSmallScreen ? 2 : 3),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 20 : 30, vertical: 20),
                            width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 28 : 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  // Name Field
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) => val!.isEmpty ? 'Enter name' : null,
                                    decoration: InputDecoration(
                                      hintText: 'NAME',
                                      prefixIcon: const Icon(Icons.person_2_outlined, color: Colors.black),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  // Email Field
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) => val!.isEmpty ? 'Enter email' : null,
                                    decoration: InputDecoration(
                                      hintText: 'EMAIL',
                                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  // Password Field
                                  TextFormField(
                                    controller: passController,
                                    obscureText: true,
                                    validator: (val) => val!.length < 6 ? 'Password too short' : null,
                                    decoration: InputDecoration(
                                      hintText: 'PASSWORD',
                                      prefixIcon: const Icon(Icons.password_outlined, color: Colors.black),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  // The Button with State Management
                                  InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<SignupCubit>().signUp(
                                          email: emailController.text,
                                          password: passController.text,
                                          name: nameController.text,
                                        );
                                      }
                                    },
                                    child: Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(25),
                                      child: Container(
                                        height: screenHeight * 0.075,
                                        width: screenWidth * 0.5,
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius: BorderRadius.circular(25)),
                                        child: Center(
                                          child: state is AuthLoading
                                              ? const CircularProgressIndicator(color: Colors.white)
                                              : Text(
                                            'SIGNUP',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isSmallScreen ? 24 : 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())),
                        child: Container(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                          child: Text(
                            'Already sign up ? LOG IN',
                            style: TextStyle(
                                fontSize: isSmallScreen ? 18 : 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}