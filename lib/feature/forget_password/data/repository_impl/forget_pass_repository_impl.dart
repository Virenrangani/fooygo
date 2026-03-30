import '../../domain/repository/forget_pass_repository.dart';
import '../data_source/forget_pass_data_source.dart';

class ForgetPassRepositoryImpl implements ForgetPassRepository {
  final ForgetPassDataSource forgetPassDataSource;
  ForgetPassRepositoryImpl(this.forgetPassDataSource);

  @override
  Future<void> resetPassword(String email) async {
    await forgetPassDataSource.resetPassword(email);
  }
}