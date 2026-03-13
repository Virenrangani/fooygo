import '../../domain/entity/user_entity.dart';
import '../../domain/repository/login_repository.dart';
import '../data_source/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl(this.loginDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final model = await loginDataSource.login(email, password);
    return UserEntity(id: model.id, email: model.email);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    final model = await loginDataSource.signInWithGoogle();
    return UserEntity(id: model.id, email: model.email);
  }

  @override
  Future<UserEntity> signInWithGithub() async {
    final model = await loginDataSource.signInWithGithub();
    return UserEntity(id: model.id, email: model.email);
  }
}
