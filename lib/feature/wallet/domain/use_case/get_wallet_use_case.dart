import '../repository/wallet_repository.dart';

class GetWalletUseCase {
  final WalletRepository repository;
  GetWalletUseCase(this.repository);

  Future<int> call(String userId) {
    return repository.getWalletBalance(userId);
  }
}