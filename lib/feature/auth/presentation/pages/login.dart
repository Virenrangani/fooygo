import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/constant/border/custom_border_radius.dart';
import 'package:foodygo/core/constant/color/custom_color.dart';
import 'package:foodygo/core/constant/font_size/custom_text_style.dart';
import 'package:foodygo/core/constant/image/app_image/app_image.dart';
import 'package:foodygo/core/constant/padding/custom_padding.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/core/widget/elevated_button/custom_elevated_button.dart';
import 'package:foodygo/core/widget/inkwell_button/custom_inkwell_button.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:foodygo/core/widget/text_form_field/custom_text_form_field.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/widget/custom_card/custom_card.dart';
import '../../../../pages/bottomnav.dart';
import '../../../forget_password/presentation/page/forgetpass.dart';
import '../cubit/auth_state.dart';
import '../cubit/login_cubit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
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
      create: (context) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              CustomSnacksBar.showSuccess(context, CustomString.loginSuccess);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => BottomNav()),
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
                        colors: [
                          CustomColor.primaryLight.withOpacity(0.7),
                          CustomColor.primary,
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
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
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
                        SizedBox(height: screenHeight * 0.05),
                        Padding(
                          padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
                          child: Material(
                            elevation: 10,
                            borderRadius: CustomBorderRadius.cir28,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 20 : 30,
                                vertical: 30,
                              ),
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    CustomString.login,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 28 : 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),

                                  CustomFormField(
                                    labelText: CustomString.email,
                                    hintText: CustomString.emailHint,
                                    controller: emailController,
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (_)=>context.read<LoginCubit>().emailError,
                                    onChanged: (val)=>context.read<LoginCubit>().emailValidation(val),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),

                                  CustomFormField(
                                    labelText: CustomString.password,
                                    hintText: CustomString.passwordHint,
                                    controller: passController,
                                    obscureText: _obscurePassword,
                                    prefixIcon: Icons.password_outlined,
                                    suffixIcon: _obscurePassword
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    onSuffixTap: () => setState(
                                          () => _obscurePassword = !_obscurePassword,
                                    ),
                                    validator: (_)=> context.read<LoginCubit>().passwordError,
                                    onChanged: (val)=>context.read<LoginCubit>().passwordValidation(val),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomInkwellButton(
                                      text: CustomString.forgetPassword,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ForgetPass(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.03),

                                  isLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.deepOrange,
                                  )
                                      : CustomElevatedButton(
                                    text: CustomString.login,
                                    color1: CustomColor.secondary,
                                    color2: CustomColor.primary,
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.05,
                                    onPressed: () {
                                      if (formKey.currentState?.validate() ?? false) {
                                        context.read<LoginCubit>().login(
                                          email: emailController.text.trim(),
                                          password: passController.text,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 3,
                                color: CustomColor.divider,
                              ),
                            ),
                            Padding(
                              padding: CustomPadding.edgeAll12,
                              child: Text(
                                'Or',
                                style: CustomTextStyles.bodyMedium,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 3,
                                color: CustomColor.divider,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.40,
                              child: CustomCard(
                                color1: CustomColor.textSecondary,
                                color2: CustomColor.primary,
                                onTap: isLoading
                                    ? null
                                    : () => context
                                    .read<LoginCubit>()
                                    .signInWithGoogle(),
                                icon: Icons.g_mobiledata,
                                title: CustomString.signInWithGoogle,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.40,
                              child: CustomCard(
                                color1: CustomColor.textSecondary,
                                color2: CustomColor.primary,
                                onTap: isLoading
                                    ? null
                                    : () => context
                                    .read<LoginCubit>()
                                    .signInWithGithub(),
                                icon: Icons.code,
                                title: CustomString.signInWithGithub,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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
                CustomString.notAccount,
                style: CustomTextStyles.bodyMedium,
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Signup()),
                ),
                child: Text(
                  CustomString.signUp,
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