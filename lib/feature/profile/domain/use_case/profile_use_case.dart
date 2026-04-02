import 'dart:io';
import 'package:foodygo/feature/profile/domain/entity/profile_entity.dart';
import 'package:foodygo/feature/profile/domain/repository/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository repository;
  ProfileUseCase(this.repository);

  Future<ProfileEntity> callProfile() {
    return repository.getProfile();
  }

  Future<String> callImageUpload(File image) {
    return repository.uploadProfileImage(image);
  }

  Future<void> callSignOut() {
    return repository.signOut();
  }

  Future<void> callDelete() {
    return repository.deleteAccount();
  }

}
