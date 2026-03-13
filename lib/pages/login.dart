import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/pages/signup.dart';
import '../cubit/auth/auth_state.dart';
import '../cubit/auth/login_cubit.dart';
import 'bottomnav.dart';
import 'forgetpass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '', password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=>BottomNav())
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login Successful!")));

            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight / 2,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepOrange.shade200,
                            Colors.deepOrange
                          ],
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
                        SizedBox(height: screenHeight * 0.05),
                        Padding(
                          padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 20 : 30,
                                  vertical: 30),
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
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 28 : 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your email';
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        hintText: 'ENTER YOUR EMAIL',
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.black,
                                          size: isSmallScreen ? 30 : 40,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your password';
                                        }
                                        return null;
                                      },
                                      controller: passController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'ENTER YOUR PASSWORD',
                                        prefixIcon: Icon(
                                          Icons.password_outlined,
                                          color: Colors.black,
                                          size: isSmallScreen ? 30 : 40,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: Colors.black,
                                          size: isSmallScreen ? 30 : 40,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.015),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPass(),
                                            ));
                                      },
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 22 : 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    InkWell(
                                      onTap: () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          context
                                              .read<LoginCubit>()
                                              .login(
                                            email: emailController.text,
                                            password: passController.text,
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
                                            borderRadius:
                                            BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: state is AuthLoading
                                                ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                                : Text(
                                              'LOGIN',
                                              style: TextStyle(
                                                fontSize: isSmallScreen
                                                    ? 24
                                                    : 30,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white,
                                              ),
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
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signup(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: screenHeight * 0.05),
                            child: Text(
                              'DON`T HAVE AN ACCOUNT? SIGN UP',
                              style: TextStyle(
                                  fontSize: isSmallScreen ? 18 : 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}