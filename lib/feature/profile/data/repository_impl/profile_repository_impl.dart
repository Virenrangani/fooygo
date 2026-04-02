import 'dart:io';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;
  ProfileRepositoryImpl(this.profileDataSource);

  @override
  Future<ProfileEntity> getProfile() {
    return profileDataSource.getProfile();
  }

  @override
  Future<String> uploadProfileImage(File image) {
    return profileDataSource.uploadProfileImage(image);
  }

  @override
  Future<void> signOut() {
    return profileDataSource.signOut();
  }

  @override
  Future<void> deleteAccount() {
    return profileDataSource.deleteAccount();
  }
}