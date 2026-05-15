import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/cart/domain/entity/cart_entity.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:foodygo/feature/cart/presentation/cubit/cart_state.dart';
import 'package:foodygo/feature/cart/presentation/widget/thankyou.dart';
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
      backgroundColor: const Color(0xFFF4F4F4),

      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ThankYou(),
              ),
            );
          }

          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                content: Text(state.message),
              ),
            );
          }
        },

        builder: (context, state) {
          final totalPrice =
          state is CartLoaded
              ? state.totalPrice
              : state is CheckoutLoading
              ? state.totalPrice
              : 0;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [

              // ================= APP BAR =================

              SliverAppBar(
                pinned: true,
                expandedHeight: sh * 0.22,
                backgroundColor: Colors.deepOrange,
                elevation: 0,

                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: sw * 0.05,
                    bottom: sh * 0.02,
                  ),

                  title: Text(
                    "Food Cart",
                    style: TextStyle(
                      fontSize: sw * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  background: Stack(
                    fit: StackFit.expand,
                    children: [

                      // GRADIENT BACKGROUND
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF6A00),
                              Color(0xFFFF8E53),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),

                      // GLOW CIRCLE
                      Positioned(
                        top: -40,
                        right: -30,
                        child: Container(
                          width: sw * 0.45,
                          height: sw * 0.45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ================= BODY =================

              SliverToBoxAdapter(
                child: _buildBody(
                  context,
                  state,
                  sw,
                  sh,
                ),
              ),
            ],
          );
        },
      ),

      // ================= BOTTOM CHECKOUT =================

      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {

          if (state is! CartLoaded &&
              state is! CheckoutLoading) {
            return const SizedBox();
          }

          final totalPrice =
          state is CartLoaded
              ? state.totalPrice
              : (state as CheckoutLoading).totalPrice;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: sw * 0.05,
              vertical: sh * 0.02,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 25,
                  offset: const Offset(0, -6),
                ),
              ],
            ),

            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // TOTAL SECTION
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Total Price",
                            style: TextStyle(
                              fontSize: sw * 0.038,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: sh * 0.004),

                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0,
                              end: totalPrice.toDouble(),
                            ),
                            duration: const Duration(
                              milliseconds: 700,
                            ),
                            builder:
                                (context, value, child) {
                              return Text(
                                "\$${value.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: sw * 0.065,
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // ITEM COUNT
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.04,
                          vertical: sh * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Colors.deepOrange,
                              size: sw * 0.05,
                            ),
                            SizedBox(width: sw * 0.02),
                            Text(
                              "5 Items",
                              style: TextStyle(
                                fontWeight:
                                FontWeight.w600,
                                color: Colors.deepOrange,
                                fontSize: sw * 0.038,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: sh * 0.025),

                  // CHECKOUT BUTTON
                  SizedBox(
                    width: sw,
                    height: sh * 0.07,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.deepOrange,
                        elevation: 10,
                        shadowColor:
                        Colors.deepOrange.withOpacity(0.4),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(24),
                        ),
                      ),

                      onPressed: () {
                        context
                            .read<CartCubit>()
                            .checkout();
                      },

                      child: state is CheckoutLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: sw * 0.055,
                          ),

                          SizedBox(width: sw * 0.025),

                          Text(
                            "Secure Checkout",
                            style: TextStyle(
                              fontSize: sw * 0.045,
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

    // ================= LOADING =================

    if (state is CartInitial ||
        state is CartLoading) {
      return SizedBox(
        height: sh * 0.6,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        ),
      );
    }

    // ================= EMPTY =================

    if (state is CartEmpty) {
      return SizedBox(
        height: sh * 0.65,
        child: Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [

              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0.7,
                  end: 1,
                ),
                duration:
                const Duration(milliseconds: 900),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },

                child: Container(
                  padding: EdgeInsets.all(sw * 0.06),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.shade50,
                  ),

                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: sw * 0.2,
                    color: Colors.deepOrange,
                  ),
                ),
              ),

              SizedBox(height: sh * 0.03),

              Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: sw * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: sh * 0.01),

              Text(
                "Looks like you haven’t added\nanything yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sw * 0.038,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ================= ERROR =================

    if (state is CartError) {
      return SizedBox(
        height: sh * 0.6,
        child: Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [

              Icon(
                Icons.error_outline,
                size: sw * 0.16,
                color: Colors.red,
              ),

              SizedBox(height: sh * 0.02),

              Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sw * 0.04,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ================= ITEMS =================

    final items = state is CartLoaded
        ? state.items
        : (state as CheckoutLoading).items;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      padding: EdgeInsets.only(
        top: sh * 0.02,
        left: sw * 0.04,
        right: sw * 0.04,
        bottom: sh * 0.18,
      ),

      itemCount: items.length,

      itemBuilder: (context, index) {

        return TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ),

          duration: Duration(
            milliseconds: 300 + (index * 120),
          ),

          curve: Curves.easeOut,

          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(
                0,
                40 * (1 - value),
              ),

              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },

          child: Padding(
            padding: EdgeInsets.only(
              bottom: sh * 0.02,
            ),

            child: CartItemCard(
              item: items[index],
            ),
          ),
        );
      },
    );
  }
}