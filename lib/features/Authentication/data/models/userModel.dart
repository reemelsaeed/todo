class Usermodel {
  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Usermodel({
    required this.id,
    required this.email,
    required this.name,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
