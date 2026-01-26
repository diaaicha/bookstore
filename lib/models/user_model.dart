class UserModel {
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
