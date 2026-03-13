import '../entity/user_entity.dart';
import '../repository/sign_up_repository.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;
  SignUpUseCase(this.signUpRepository);

  Future<UserEntity> signUpCall(String email,String name,String password){
    return signUpRepository.signUp(email, name, password);
  }
}