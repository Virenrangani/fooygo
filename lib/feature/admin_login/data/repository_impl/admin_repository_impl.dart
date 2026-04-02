import 'package:foodygo/feature/admin_login/data/data_source/admin_data_source.dart';
import 'package:foodygo/feature/admin_login/domain/repository/admin_repository.dart';

class AdminRepositoryImpl extends AdminRepository{
  final AdminDataSource adminDataSource;

  AdminRepositoryImpl( this.adminDataSource);

  @override
  Future<void> login(String id, String password) async {
    return await adminDataSource.login(id, password);
  }

}