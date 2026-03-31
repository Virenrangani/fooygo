import 'package:flutter/material.dart';
import '../../domain/food_entity/food_entity.dart';
import 'food_image.dart';

class FoodCard extends StatelessWidget {
  final FoodEntity food;
  final String? userId;

  const FoodCard({
    super.key,
    required this.food,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => DetailsPage(food: food, userId: userId),
      //   ),
      // ),
      child: Container(
        margin: EdgeInsets.only(bottom: sh * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            FoodImage(
              imageUrl: food.image,
              height: sh * 0.14,
              width: sw * 0.35,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            SizedBox(width: sw * 0.04),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sh * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: TextStyle(
                        fontSize: sw * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: sh * 0.005),
                    Text(
                      food.details,
                      style: TextStyle(
                        fontSize: sw * 0.032,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: sh * 0.01),
                    Text(
                      '\$${food.price}',
                      style: TextStyle(
                        fontSize: sw * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: sw * 0.03),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}