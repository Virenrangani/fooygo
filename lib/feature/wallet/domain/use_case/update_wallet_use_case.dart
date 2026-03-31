import '../repository/wallet_repository.dart';

class UpdateWalletUseCase {
  final WalletRepository repository;
  UpdateWalletUseCase(this.repository);

  Future<void> call(String userId, int balance) {
    return repository.updateWalletBalance(userId, balance);
  }
}