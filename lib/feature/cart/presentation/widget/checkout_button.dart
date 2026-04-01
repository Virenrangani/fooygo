import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_state.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isLoading = state is CheckoutLoading;

        return Container(
          width: sw,
          margin: EdgeInsets.symmetric(
            horizontal: sw * 0.05,
            vertical: sh * 0.02,
          ),
          child: isLoading
              ? const Center(
            child: CircularProgressIndicator(color: Colors.deepOrange),
          )
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding:
              EdgeInsets.symmetric(vertical: sh * 0.018),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
            ),
            onPressed: () => context.read<CartCubit>().checkout(),
            child: Text(
              'CheckOut',
              style: TextStyle(
                color: Colors.white,
                fontSize: sw * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}