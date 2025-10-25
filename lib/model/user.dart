import 'package:cobaaja/service/user.dart';
import 'package:cobaaja/tools/datetime.dart';

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
    this.deletedAt
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
      deletedAt: checkDateTime(json['deleted_at'])
    );
  }
}
