import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/email_validation/email_password_validation.dart';
import '../../domain/use_case/forget_pass_use_case.dart';
import 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  final ForgetPassUseCase forgetPassUseCase;
  ForgetPassCubit(this.forgetPassUseCase) : super(ForgetPassInitial());

  bool emailTouched = false;

  String? emailError;

  void emailValidation(String value) {
    emailTouched=true;
    emailError = validateEmail(value);
    emit(ForgetPassFormValid());
  }

  Future<void> resetPassword(String email) async {
    emit(ForgetPassLoading());
    try {
      await forgetPassUseCase.resetPasswordCall(email);
      emit(ForgetPassSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgetPassFailure(e.toString()));
    } catch (e) {
      emit(ForgetPassFailure(e.toString()));
    }
  }
}