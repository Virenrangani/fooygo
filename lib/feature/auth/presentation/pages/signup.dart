import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/constant/image/app_image/app_image.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:foodygo/core/widget/text_form_field/custom_text_form_field.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/constant/color/custom_color.dart';
import '../../../../core/constant/font_size/custom_text_style.dart';
import '../../../../core/constant/padding/custom_padding.dart';
import '../../../../core/widget/elevated_button/custom_elevated_button.dart';
import '../cubit/auth_state.dart';
import '../cubit/signup_cubit.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController  = TextEditingController();
  final emailController = TextEditingController();
  final passController  = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

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
    final screenWidth  = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return BlocProvider(
      create: (context) => GetIt.I<SignupCubit>(),
      child: Scaffold(
        body: BlocConsumer<SignupCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              CustomSnacksBar.showSuccess(
                context,
                CustomString.signUpEmailVerify,
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
                    (_) => false,
              );
            } else if (state is AuthFailure) {
              CustomSnacksBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

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
                        topLeft:  Radius.circular(50),
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
                            AppImage.foody,
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
                              horizontal: isSmallScreen ? 20 : 30,
                              vertical: 20,
                            ),
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
                                    CustomString.signUp,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 28 : 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),

                                  CustomFormField(
                                    controller: nameController,
                                    prefixIcon: Icons.person_2_outlined,
                                    labelText: CustomString.name,
                                    hintText: CustomString.nameHint,
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return 'Enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.015),

                                  CustomFormField(
                                    controller: emailController,
                                    labelText: CustomString.email,
                                    hintText: CustomString.emailHint,
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Enter your email';
                                      }
                                      if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$')
                                          .hasMatch(val)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.015),

                                  CustomFormField(
                                    controller: passController,
                                    labelText: CustomString.password,
                                    hintText: CustomString.passwordHint,
                                    obscureText: _obscurePassword,
                                    prefixIcon: Icons.password_outlined,
                                    suffixIcon: _obscurePassword
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    onSuffixTap: () => setState(
                                            () => _obscurePassword = !_obscurePassword),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Password is empty';
                                      }
                                      if (val.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),

                                  isLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.deepOrange,
                                  )
                                      : CustomElevatedButton(
                                    text: CustomString.signUp,
                                    color1: CustomColor.secondary,
                                    color2: CustomColor.primary,
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.05,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<SignupCubit>().signUp(
                                          email: emailController.text.trim(),
                                          password: passController.text,
                                          name: nameController.text.trim(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: CustomPadding.edgeAll20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CustomString.alreadyHaveAccount,
                style: CustomTextStyles.bodyMedium,
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                ),
                child: Text(
                  CustomString.login,
                  style: CustomTextStyles.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}