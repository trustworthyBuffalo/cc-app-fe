import 'package:cobaaja/tools/datetime.dart';

// ====== From server

class User {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;

  // nulabale
  String? nim;
  String? handphone;
  DateTime? updatedAt;
  DateTime? deletedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.nim,
    this.handphone,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      handphone: json['handphone'],
      nim: json['nim'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: checkDateTime(json['updated_at']),
      deletedAt: checkDateTime(json['deleted_at']),
    );
  }
}

//==== Send to server

class UserRegister {
  final String name;
  final String handphone;
  final String email;
  final String password;

  UserRegister({
    required this.name,
    required this.handphone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password,
      "handphone": handphone,
    };

    return data;
  }
}

class UserLogin {
  final String email;
  final String password;

  UserLogin({required this.email, required this.password});

  Map<String, String> toMap() {
    final Map<String, String> data = {"email": email, "password": password};

    return data;
  }
}
