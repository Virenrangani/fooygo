class ProfileEntity {
  final String name;
  final String email;
  final String? profileUrl;

  ProfileEntity({
    required this.name,
    required this.email,
    this.profileUrl,
  });
}