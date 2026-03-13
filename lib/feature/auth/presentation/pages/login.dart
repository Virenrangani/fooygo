import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/constant/color/custom_color.dart';
import 'package:foodygo/core/constant/font_size/custom_text_style.dart';
import 'package:foodygo/core/constant/padding/custom_padding.dart';
import 'package:foodygo/core/constant/string/custom_string.dart';
import 'package:foodygo/core/widget/elevated_button/custom_elevated_button.dart';
import 'package:foodygo/core/widget/inkwell_button/custom_inkwell_button.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:foodygo/core/widget/text_form_field/custom_text_form_field.dart';
import 'package:foodygo/feature/auth/presentation/pages/signup.dart';
import 'package:get_it/get_it.dart';
import '../../../../pages/bottomnav.dart';
import '../../../../pages/forgetpass.dart';
import '../cubit/auth_state.dart';
import '../cubit/login_cubit.dart';

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
      create: (context) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=>BottomNav())
              );
              CustomSnacksBar.showSuccess(context, CustomString.loginSuccess);

            } else if (state is AuthFailure) {
              CustomSnacksBar.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                                    prefixIcon: Icons.email_outlined,
                                    validator: (val){
                                        if(val==null||val.isEmpty){
                                          return "Enter the mail";
                                        }
                                        return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  CustomFormField(
                                      labelText: CustomString.password,
                                      hintText: CustomString.passwordHint,
                                    suffixIcon:Icons.remove_red_eye_outlined ,
                                    prefixIcon: Icons.password_outlined,
                                    validator: (val){
                                        if(val==null||val.isEmpty){
                                          return "password is empty";
                                        }
                                        return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CustomInkwellButton(
                                        text: CustomString.forgetPassword,
                                        onTap: (){
                                          Navigator.pushReplacement(
                                              context, MaterialPageRoute(
                                              builder: (context)=>ForgetPass()
                                          )
                                          );
                                        }
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.03),
                                  CustomElevatedButton(
                                      text:CustomString.login,
                                      color1: CustomColor.secondary,
                                      color2: CustomColor.primary,
                                      width:screenWidth*0.4,
                                      height: screenHeight*0.05,
                                      onPressed: (){
                                        if (formKey.currentState?.validate() ??false){
                                          context.read<LoginCubit>()
                                              .login(email: email, password: password);
                                        }
                                      })
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
              Text(CustomString.notAccount,style: CustomTextStyles.bodyMedium,),
              InkWell(onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Signup())
                );
              },
              child: Text(CustomString.signUp ,style: CustomTextStyles.bodyLarge,),)
            ],
          ),
        ),
      ),
    );
  }
}