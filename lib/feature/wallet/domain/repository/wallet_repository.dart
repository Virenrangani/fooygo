abstract class WalletRepository {
  Future<int> getWalletBalance(String userId);
  Future<void> updateWalletBalance(String userId, int balance);
}