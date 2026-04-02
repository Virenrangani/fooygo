import '../repository/admin_repository.dart';

class AdminLoginUseCase {
  final AdminRepository repository;
  AdminLoginUseCase(this.repository);

  Future<void> call(String id, String password) {
    return repository.login(id, password);
  }
}