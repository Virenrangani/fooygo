import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/food_details_cubit.dart';

class QuantityControls extends StatelessWidget {
  final int quantity;

  const QuantityControls({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Row(
      children: [
        GestureDetector(
          onTap: () => context.read<DetailsCubit>().decrement(),
          child: Container(
            padding: EdgeInsets.all(sw * 0.02),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: sw * 0.06,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: sw * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => context.read<DetailsCubit>().increment(),
          child: Container(
            padding: EdgeInsets.all(sw * 0.02),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: sw * 0.06,
            ),
          ),
        ),
      ],
    );
  }
}