import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../domain/use_case/add_to_cart_use_case.dart';
import 'food_details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final AddToCartUseCase addToCartUseCase;

  int _quantity = 1;
  int _unitPrice = 0;
  String _userId = '';

  DetailsCubit({required this.addToCartUseCase}) : super(DetailsInitial());

  Future<void> init(int unitPrice) async {
    _unitPrice = unitPrice;
    _userId = await SharedPrefService.getUserId() ?? '';
    emit(DetailsQuantityUpdated(
      quantity: _quantity,
      total: _unitPrice,
    ));
  }

  void increment() {
    _quantity++;
    emit(DetailsQuantityUpdated(
      quantity: _quantity,
      total: _quantity * _unitPrice,
    ));
  }

  // ✅ Decrement quantity — min 1
  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      emit(DetailsQuantityUpdated(
        quantity: _quantity,
        total: _quantity * _unitPrice,
      ));
    }
  }

  Future<void> addToCart({
    required String name,
    required String image,
  }) async {
    emit(CartAdding());
    try {
      await addToCartUseCase(
        _userId,
        {
          'Name': name,
          'Quantity': _quantity.toString(),
          'Total': (_quantity * _unitPrice).toString(),
          'Image': image,
        },
      );
      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }
}