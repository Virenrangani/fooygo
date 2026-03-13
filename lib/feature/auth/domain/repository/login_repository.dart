import '../entity/user_entity.dart';

abstract class LoginRepository {
  Future<UserEntity> login(String email,String password);

  Future<UserEntity> signInWithGoogle();

  Future<UserEntity> signInWithGithub();
}