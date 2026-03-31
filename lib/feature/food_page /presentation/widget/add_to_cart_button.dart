import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/food_details_cubit.dart';
import '../cubit/food_details_state.dart';

class AddToCartButton extends StatelessWidget {
  final String name;
  final String image;
  final int total;

  const AddToCartButton({
    super.key,
    required this.name,
    required this.image,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        final isAdding = state is CartAdding;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: sw * 0.04,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '\$$total',
                  style: TextStyle(
                    fontSize: sw * 0.065,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: isAdding
                  ? null
                  : () => context.read<DetailsCubit>().addToCart(
                name: name,
                image: image,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.06,
                  vertical: sh * 0.018,
                ),
                decoration: BoxDecoration(
                  color: isAdding ? Colors.grey : Colors.black,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: isAdding
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Row(
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sw * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}