import '../../domain/repository/wallet_repository.dart';
import '../data_source/wallet_data_source.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletDataSource walletDataSource;
  WalletRepositoryImpl(this.walletDataSource);

  @override
  Future<int> getWalletBalance(String userId) {
    return walletDataSource.getWalletBalance(userId);
  }

  @override
  Future<void> updateWalletBalance(String userId, int balance) {
    return walletDataSource.updateWalletBalance(userId, balance);
  }
}