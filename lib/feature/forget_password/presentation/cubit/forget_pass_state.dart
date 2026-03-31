abstract class ForgetPassState {}

class ForgetPassInitial extends ForgetPassState {}

class ForgetPassLoading extends ForgetPassState {}

class ForgetPassSuccess extends ForgetPassState {}

class ForgetPassFailure extends ForgetPassState {
  final String message;
  ForgetPassFailure(this.message);
}

class ForgetPassFormValid extends ForgetPassState{}