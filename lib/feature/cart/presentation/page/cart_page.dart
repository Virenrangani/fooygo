import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/cart/domain/entity/cart_entity.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_state.dart';
import 'package:foodygo/pages/thankyou.dart';
import 'package:get_it/get_it.dart';
import '../widget/cart_item_card.dart';
import '../widget/checkout_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<CartCubit>()..loadCart(),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ThankYou()),
            );
          } else if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  width: sw,
                  padding: EdgeInsets.symmetric(vertical: sh * 0.025),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Food Cart',
                      style: TextStyle(
                        fontSize: sw * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.02),

                Expanded(
                  child: _buildBody(context, state, sw, sh),
                ),

                if (state is CartLoaded || state is CheckoutLoading) ...[
                  const Divider(thickness: 1),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sw * 0.05,
                      vertical: sh * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: sw * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${state is CartLoaded ? state.totalPrice : (state as CheckoutLoading).totalPrice}',
                          style: TextStyle(
                            fontSize: sw * 0.048,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const CheckoutButton(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      CartState state,
      double sw,
      double sh,
      ) {
    if (state is CartInitial || state is CartLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.deepOrange),
      );
    }


    if (state is CartEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined,
                size: sw * 0.2, color: Colors.grey.shade300),
            SizedBox(height: sh * 0.02),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: sw * 0.045,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (state is CartError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text(state.message, textAlign: TextAlign.center),
          ],
        ),
      );
    }

    final items = state is CartLoaded
        ? state.items
        : state is CheckoutLoading
        ? state.items
        : <CartEntity>[];

    return ListView.builder(
      padding: EdgeInsets.only(top: sh * 0.01),
      itemCount: items.length,
      itemBuilder: (context, index) =>
      CartItemCard(item: items[index]),
    );
  }
}