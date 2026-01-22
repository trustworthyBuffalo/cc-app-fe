import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String nama;
  final String email;
  final String nim;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.nama,
    required this.email,
    required this.nim,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "nama": nama,
      "email": email,
      "nim": nim,
      "createdAt": createdAt,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      nama: data["nama"],
      email: data["email"],
      nim: data["nim"],
      createdAt: data["createdAt"],
    );
  }
}
