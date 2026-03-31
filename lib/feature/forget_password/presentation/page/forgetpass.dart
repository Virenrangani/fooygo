import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:foodygo/core/widget/text_form_field/custom_text_form_field.dart';
import 'package:foodygo/feature/auth/presentation/pages/login.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:get_it/get_it.dart';
import '../cubit/forget_pass_cubit.dart';
import '../cubit/forget_pass_state.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => GetIt.I<ForgetPassCubit>(),
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: BlocConsumer<ForgetPassCubit, ForgetPassState>(
          listener: (context, state) {
            if (state is ForgetPassSuccess) {
              CustomSnacksBar.showSuccess(
                context,
                CustomString.resetPasswordEmailSent,
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Login()),
                    (_) => false,
              );
            } else if (state is ForgetPassFailure) {
              CustomSnacksBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is ForgetPassLoading;

            return SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.12),
                      child: const Icon(
                        Icons.lock_reset_outlined,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      CustomString.passRecovery,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      CustomString.enterMailToReceiveLink,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                      ),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 30,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomFormField(
                                  controller: emailController,
                                  labelText: CustomString.email,
                                  hintText: CustomString.emailHint,
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (_)=>context.read<ForgetPassCubit>().emailError,
                                  onChanged: (val)=>context.read<ForgetPassCubit>().emailValidation(val),
                                ),
                                SizedBox(height: screenHeight * 0.03),

                                isLoading
                                    ? const CircularProgressIndicator(
                                  color: Colors.deepOrange,
                                )
                                    : SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!
                                          .validate()) {
                                        context
                                            .read<ForgetPassCubit>()
                                            .resetPassword(
                                          emailController.text.trim(),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      CustomString.resetEmail,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                    SizedBox(height: screenHeight * 0.04),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                           CustomString.back,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(width:10,),
                        GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Login(),
                            ),
                                (_) => false,
                          ),
                          child: const Text(
                            CustomString.login,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          CustomString.notAccount,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(width:10,),
                        GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Signup(),
                            ),
                                (_) => false,
                          ),
                          child: const Text(
                            CustomString.signUp,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
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