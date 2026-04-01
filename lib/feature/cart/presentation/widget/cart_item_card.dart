import 'package:flutter/material.dart';
import 'package:foodygo/feature/cart/domain/entity/cart_entity.dart';

class CartItemCard extends StatelessWidget {
  final CartEntity item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        left: sw * 0.05,
        right: sw * 0.05,
        bottom: sh * 0.015,
      ),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(sw * 0.03),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                height: sh * 0.07,
                width: sw * 0.12,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.1),
                  border: Border.all(color: Colors.deepOrange, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    item.quantity,
                    style: TextStyle(
                      fontSize: sw * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
              SizedBox(width: sw * 0.04),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: item.image.isEmpty
                    ? Image.asset(
                  'assets/image/food.png',
                  height: sh * 0.09,
                  width: sh * 0.09,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  item.image,
                  height: sh * 0.09,
                  width: sh * 0.09,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Image.asset(
                    'assets/image/food.png',
                    height: sh * 0.09,
                    width: sh * 0.09,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: sw * 0.04),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: sw * 0.042,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: sh * 0.005),
                    Text(
                      '\$${item.total}',
                      style: TextStyle(
                        fontSize: sw * 0.038,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}