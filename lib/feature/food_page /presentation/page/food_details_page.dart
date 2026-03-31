import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../home/domain/food_entity/food_entity.dart';
import '../cubit/food_details_cubit.dart';
import '../cubit/food_details_state.dart';
import '../widget/add_to_cart_button.dart';
import '../widget/food_details_image.dart';
import '../widget/quantity_controls.dart';

class DetailsPage extends StatelessWidget {
  final FoodEntity food;

  const DetailsPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<DetailsCubit>()
        ..init(int.tryParse(food.price) ?? 0),
      child: _DetailsView(food: food),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final FoodEntity food;

  const _DetailsView({required this.food});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepOrange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Food added to cart!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
            Navigator.pop(context);
          } else if (state is CartFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final quantity = state is DetailsQuantityUpdated
              ? state.quantity
              : 1;
          final total = state is DetailsQuantityUpdated
              ? state.total
              : int.tryParse(food.price) ?? 0;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: sh * 0.02,
                    left: sw * 0.05,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(sw * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.02),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                  child: FoodDetailsImage(
                    imageUrl: food.image,
                    width: sw,
                    height: sh / 2.5,
                  ),
                ),
                SizedBox(height: sh * 0.02),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                food.name,
                                style: TextStyle(
                                  fontSize: sw * 0.055,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            QuantityControls(quantity: quantity),
                          ],
                        ),
                        SizedBox(height: sh * 0.02),

                        Text(
                          food.details,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: sw * 0.038,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: sh * 0.02),

                        Row(
                          children: [
                            const Icon(
                              Icons.alarm,
                              color: Colors.deepOrange,
                              size: 20,
                            ),
                            SizedBox(width: sw * 0.02),
                            Text(
                              '30 min delivery',
                              style: TextStyle(
                                fontSize: sw * 0.038,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        AddToCartButton(
                          name: food.name,
                          image: food.image,
                          total: total,
                        ),
                        SizedBox(height: sh * 0.02),
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