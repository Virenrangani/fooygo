import 'package:foodygo/feature/cart/domain/entity/cart_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartEntity> items;
  final int totalPrice;

  CartLoaded({
    required this.items,
    required this.totalPrice,
  });
}

class CartEmpty extends CartState {}

class CheckoutLoading extends CartState {
  final List<CartEntity> items;
  final int totalPrice;

  CheckoutLoading({
    required this.items,
    required this.totalPrice,
  });
}

class CheckoutSuccess extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}