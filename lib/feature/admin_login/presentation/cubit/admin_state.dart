abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoginSuccess extends AdminState {}

class AdminLoginFailure extends AdminState {
  final String message;
  AdminLoginFailure(this.message);
}