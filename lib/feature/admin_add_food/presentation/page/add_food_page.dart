import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widget/text_form_field/custom_text_form_field.dart';
import '../cubit/add_food_cubit.dart';
import '../cubit/add_food_state.dart';
import '../widget/food_category_dropdown.dart';

class AddFoodPage extends StatelessWidget {
  const AddFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AddFoodCubit>(),
      child: const _AddFoodView(),
    );
  }
}

class _AddFoodView extends StatefulWidget {
  const _AddFoodView();

  @override
  State<_AddFoodView> createState() => _AddFoodViewState();
}

class _AddFoodViewState extends State<_AddFoodView> {
  final _formKey = GlobalKey<FormState>();

  final _imageCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _detailCtrl = TextEditingController();

  String? _selectedCategory;

  static const List<String> _categories = [
    'pizza',
    'burger',
    'salad',
    'ice-cream',
  ];

  @override
  void dispose() {
    _imageCtrl.dispose();
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _detailCtrl.dispose();
    super.dispose();
  }

  Widget buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Colors.deepOrange,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.deepOrange,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Add Food",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocConsumer<AddFoodCubit, AddFoodState>(
        listener: (context, state) {
          if (state is AddFoodSuccess) {
            CustomSnacksBar.showSuccess(
              context,
              "Food item added successfully!",
            );

            Navigator.pop(context);
          }

          if (state is AddFoodFailure) {
            CustomSnacksBar.showError(
              context,
              state.message,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddFoodLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  /// IMAGE PREVIEW
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      image: _imageCtrl.text.isNotEmpty
                          ? DecorationImage(
                        image: NetworkImage(_imageCtrl.text),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: _imageCtrl.text.isEmpty
                        ? const Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 70,
                        color: Colors.deepOrange,
                      ),
                    )
                        : null,
                  ),

                  SizedBox(height: sh * 0.03),

                  buildField(
                    controller: _imageCtrl,
                    hint: "Paste Image URL",
                    icon: Icons.image_outlined,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter image URL';
                      }
                      return null;
                    },
                  ),

                  buildField(
                    controller: _nameCtrl,
                    hint: "Food Name",
                    icon: Icons.restaurant_menu,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter food name';
                      }
                      return null;
                    },
                  ),

                  buildField(
                    controller: _priceCtrl,
                    hint: "Food Price",
                    icon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter food price';
                      }
                      return null;
                    },
                  ),

                  buildField(
                    controller: _detailCtrl,
                    hint: "Food Description",
                    icon: Icons.description_outlined,
                    maxLines: 4,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter food description';
                      }
                      return null;
                    },
                  ),

                  FoodCategoryDropdown(
                    selectedCategory: _selectedCategory,
                    categories: _categories,
                    onChanged: (val) {
                      setState(() {
                        _selectedCategory = val;
                      });
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Select category';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: sh * 0.04),

                  isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddFoodCubit>().addFood(
                          imageUrl: _imageCtrl.text.trim(),
                          name: _nameCtrl.text.trim(),
                          price: _priceCtrl.text.trim(),
                          detail: _detailCtrl.text.trim(),
                          category: _selectedCategory!,
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 62,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.deepOrange,
                            Colors.orange,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Add Food Item",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: sh * 0.04),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}