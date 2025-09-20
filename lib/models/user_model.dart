class UserModel {
  final String id;
  final String email;
  final String username;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> authUser, Map<String, dynamic> profile) {
    return UserModel(
      id: authUser['id'] as String,
      email: authUser['email'] as String,
      username: profile['fullname'] as String,
    );
  }
}
