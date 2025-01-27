final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id,
    name,
    email,
    password
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String email = 'email';
  static final String password = 'password';
}

class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  User copy({
    int? id,
    String? name,
    String? email,
    String? password,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.name: name,
    UserFields.email: email,
    UserFields.password: password,
  };

  static User fromJson(Map<String, Object?> json) => User(
    id: json[UserFields.id] as int?,
    name: json[UserFields.name] as String,
    email: json[UserFields.email] as String,
    password: json[UserFields.password] as String,
  );
}