import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../domain/use_case/get_wallet_use_case.dart';
import '../../domain/use_case/update_wallet_use_case.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWalletUseCase getWalletUseCase;
  final UpdateWalletUseCase updateWalletUseCase;

  String _userId = '';
  int _currentBalance = 0;

  WalletCubit({
    required this.getWalletUseCase,
    required this.updateWalletUseCase,
  }) : super(WalletInitial());

  Future<void> loadWallet() async {
    emit(WalletLoading());
    try {
      _userId = await SharedPrefService.getUserId() ?? '';
      _currentBalance = await getWalletUseCase(_userId);
      emit(WalletLoaded(_currentBalance));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> addMoney(int amount) async {
    try {
      _currentBalance += amount;
      emit(WalletUpdating(_currentBalance));
      await updateWalletUseCase(_userId, _currentBalance);
      emit(WalletUpdateSuccess(
        balance: _currentBalance,
        addedAmount: amount,
      ));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}