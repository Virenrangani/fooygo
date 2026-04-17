import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/widget/text_form_field/custom_text_form_field.dart';
import '../cubit/add_food_cubit.dart';
import '../cubit/add_food_state.dart';
import '../widget/food_category_dropdown.dart';

class AddFoodPage extends StatelessWidget {
  const AddFoodPage( {super.key,});

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
  final _formKey    = GlobalKey<FormState>();
  final _imageCtrl  = TextEditingController();
  final _nameCtrl   = TextEditingController();
  final _priceCtrl  = TextEditingController();
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

  void _clearForm() {
    _imageCtrl.clear();
    _nameCtrl.clear();
    _priceCtrl.clear();
    _detailCtrl.clear();
    setState(() => _selectedCategory = null);
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(sw * 0.02),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add Food Item',
          style: TextStyle(
            fontSize: sw * 0.055,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<AddFoodCubit, AddFoodState>(
        listener: (context, state) {
          if (state is AddFoodSuccess) {
            CustomSnacksBar.showSuccess(context, "Food item added successfully!");
            _clearForm();
            Navigator.pop(context);
          } else if (state is AddFoodFailure) {
            CustomSnacksBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is AddFoodLoading;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: sw * 0.06,
              vertical: sh * 0.02,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    controller: _imageCtrl,
                    labelText: 'Image URL',
                    hintText: 'Paste image URL here',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter image URL';
                      }
                      if (!val.startsWith('http')) {
                        return 'Enter a valid URL';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sh * 0.025),

                  CustomFormField(
                    controller: _nameCtrl,
                    labelText: 'Item Name',
                    hintText: 'Enter item name',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter item name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sh * 0.02),

                  CustomFormField(
                    controller: _priceCtrl,
                    labelText: 'Item Price',
                    hintText: 'Enter item price',
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter item price';
                      }
                      if (int.tryParse(val) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sh * 0.02),

                  CustomFormField(
                    controller: _detailCtrl,
                    maxLines: 4,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter item detail';
                      }
                      return null;
                    },
                    labelText: 'Item Detail',
                    hintText: 'Enter item description',
                  ),
                  SizedBox(height: sh * 0.02),

                  FoodCategoryDropdown(
                    selectedCategory: _selectedCategory,
                    categories: _categories,
                    onChanged: (val) =>
                        setState(() => _selectedCategory = val),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Select a category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sh * 0.04),

                  isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                        color: Colors.deepOrange),
                  )
                      : SizedBox(
                    width: double.infinity,
                    height: sh * 0.065,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () {
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: sw * 0.02),
                          Text(
                            'Add Food Item',
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
                  SizedBox(height: sh * 0.03),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}