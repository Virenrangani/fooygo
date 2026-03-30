
import '../repository/forget_pass_repository.dart';

class ForgetPassUseCase {
  final ForgetPassRepository repository;
  ForgetPassUseCase(this.repository);

  Future<void> resetPasswordCall(String email) {
    return repository.resetPassword(email);
  }
}