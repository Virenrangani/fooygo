import 'package:flutter/material.dart';

class FoodCategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final List<String> categories;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const FoodCategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: TextStyle(
            fontSize: sw * 0.042,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: sh * 0.008),
        DropdownButtonFormField<String>(
          initialValue: selectedCategory,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFf5f5f5),
            contentPadding: EdgeInsets.symmetric(
              horizontal: sw * 0.04,
              vertical: sh * 0.015,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Colors.deepOrange,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          hint: Text(
            'Select Category',
            style: TextStyle(
              color: Colors.grey,
              fontSize: sw * 0.038,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.deepOrange,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          items: categories
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(
                    _categoryIcon(item),
                    color: Colors.deepOrange,
                    size: sw * 0.05,
                  ),
                  SizedBox(width: sw * 0.03),
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: sw * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'pizza':
        return Icons.local_pizza;
      case 'burger':
        return Icons.lunch_dining;
      case 'salad':
        return Icons.eco;
      case 'ice-cream':
        return Icons.icecream;
      default:
        return Icons.fastfood;
    }
  }
}