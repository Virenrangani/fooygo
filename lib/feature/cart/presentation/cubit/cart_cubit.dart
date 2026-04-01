import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../domain/use_case/checkout_use_case.dart';
import '../../domain/use_case/get_cart_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final CheckoutUseCase checkoutUseCase;

  StreamSubscription? _cartSubscription;
  String _userId = '';
  int _walletBalance = 0;

  CartCubit(
     this.getCartUseCase,
     this.checkoutUseCase,
  ) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      _userId = await SharedPrefService.getUserId() ?? '';
      _walletBalance = await SharedPrefService.getWalletBalance();

      _cartSubscription?.cancel();
      _cartSubscription = getCartUseCase(_userId).listen(
            (items) {
          if (items.isEmpty) {
            emit(CartEmpty());
          } else {
            final total = items.fold<int>(
              0,
                  (sum, item) => sum + (int.tryParse(item.total) ?? 0),
            );
            emit(CartLoaded(items: items, totalPrice: total));
          }
        },
        onError: (e) => emit(CartError(e.toString())),
      );
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> checkout() async {
    final current = state;
    if (current is! CartLoaded) return;

    if (_walletBalance < current.totalPrice) {
      emit(CartError('Insufficient wallet balance.'));
      emit(CartLoaded(
        items: current.items,
        totalPrice: current.totalPrice,
      ));
      return;
    }

    emit(CheckoutLoading(
      items: current.items,
      totalPrice: current.totalPrice,
    ));

    try {
      final newBalance = _walletBalance - current.totalPrice;

      await Future.wait([
        checkoutUseCase(_userId, newBalance),
        SharedPrefService.saveWalletBalance(newBalance),
      ]);

      emit(CheckoutSuccess());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}