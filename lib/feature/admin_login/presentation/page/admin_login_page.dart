import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/widget/elevated_button/custom_elevated_button.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:foodygo/core/widget/text_form_field/custom_text_form_field.dart';
import 'package:get_it/get_it.dart';
import '../../../admin_home_page/page/admin_home_page.dart';
import '../cubit/admin_cubit.dart';
import '../cubit/admin_state.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AdminCubit>(),
      child: const _AdminLoginView(),
    );
  }
}

class _AdminLoginView extends StatefulWidget {
  const _AdminLoginView();

  @override
  State<_AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<_AdminLoginView> {
  final _formKey = GlobalKey<FormState>();
  final _idController   = TextEditingController();
  final _passController = TextEditingController();
  final bool _obscurePassword = true;

  @override
  void dispose() {
    _idController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminHomePage()),
            );
            CustomSnacksBar.showSuccess(context, "Login Successfully");
          } else if (state is AdminLoginFailure) {
            CustomSnacksBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AdminLoading;

          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: sh / 2),
                  height: sh,
                  width: sw,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 52, 51, 51),
                        Colors.black,
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: sh * 0.1),
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'WELCOME TO\nADMIN PANEL!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: sw * 0.065,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: sh * 0.04),

                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: sh * 0.03),

                                Container(
                                  padding: EdgeInsets.all(sw * 0.04),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.admin_panel_settings,
                                    color: Colors.white,
                                    size: sw * 0.12,
                                  ),
                                ),
                                SizedBox(height: sh * 0.025),

                                CustomFormField(
                                  controller: _idController,
                                  hintText: 'USERNAME',
                                  prefixIcon: Icons.person_outline,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter your username';
                                    }
                                    return null;
                                  }, labelText: 'Username',
                                ),

                                SizedBox(height: sh * 0.025),

                                CustomFormField(
                                  controller: _passController,
                                  hintText: 'PASSWORD',
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: _obscurePassword,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter your password';
                                    }
                                    return null;
                                  }, labelText: 'Password',
                                ),
                                SizedBox(height: sh * 0.03),

                                CustomElevatedButton(
                                  text: 'Login',
                                  isLoading: isLoading,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AdminCubit>().login(
                                        id: _idController.text.trim(),
                                        password:
                                        _passController.text.trim(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}