import '../../domain/entity/user_entity.dart';
import '../../domain/repository/sign_up_repository.dart';
import '../data_source/sign_up_data_source.dart';

class SignUpRepositoryImpl implements SignUpRepository{
  final SignUpDataSource signUpDataSource;

  SignUpRepositoryImpl(this.signUpDataSource);

  @override
  Future<UserEntity> signUp(String email, String name, String password) async{
    final model= await signUpDataSource.signUp(email, name, password);
    return UserEntity(id: model.id, email: model.email,name: model.name);
  }

}