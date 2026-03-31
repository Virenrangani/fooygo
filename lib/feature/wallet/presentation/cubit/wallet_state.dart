abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final int balance;
  WalletLoaded(this.balance);
}

class WalletUpdating extends WalletState {
  final int balance;
  WalletUpdating(this.balance);
}

class WalletUpdateSuccess extends WalletState {
  final int balance;
  final int addedAmount;
  WalletUpdateSuccess({required this.balance, required this.addedAmount});
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}