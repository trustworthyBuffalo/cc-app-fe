import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String description;
  final String imageUrl;
  final Timestamp createdAt;
  final bool isChecked;

  Post({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'isChecked': isChecked,
    };
  }

  factory Post.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return Post(
      id: doc.id,
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      isChecked: data['isChecked'] ?? false,
    );
  }
}
