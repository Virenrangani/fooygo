import '../entity/user_entity.dart';

abstract class SignUpRepository{
  Future<UserEntity> signUp(String email,String name,String password);
}