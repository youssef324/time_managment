class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.createdAt,
  });

  // Convert User to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Copy with method
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
