import 'package:foodygo/feature/profile/domain/entity/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  ProfileLoaded(this.profile);
}

class ProfileImageUploading extends ProfileState {
  final ProfileEntity profile;
  ProfileImageUploading(this.profile);
}

class ProfileImageUploaded extends ProfileState {
  final ProfileEntity profile;
  ProfileImageUploaded(this.profile);
}

class ProfileSignedOut extends ProfileState {}

class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}