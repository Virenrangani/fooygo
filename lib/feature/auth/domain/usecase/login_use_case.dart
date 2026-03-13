import '../entity/user_entity.dart';
import '../repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;
  LoginUseCase(this.repository);

  Future<UserEntity> loginCall(String email,String password){
    return repository.login(email, password);
  }

  Future<UserEntity> googleCall(){
    return repository.signInWithGoogle();
  }

  Future<UserEntity> githubCall(){
    return repository.signInWithGithub();
  }
}