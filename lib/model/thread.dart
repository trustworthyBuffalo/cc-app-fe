import 'package:cobaaja/model/user.dart';
import 'package:cobaaja/tools/datetime.dart';

class Thread {
  final int id;
  final int userId;
  final String title;
  final DateTime createdAt;
  final User user;

  String? body;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Thread({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.user,
    this.body,
    this.updatedAt,
    this.deletedAt,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json["id"],
      userId: json["user_id"],
      title: json["title"],
      createdAt: DateTime.parse(json["created_at"]),
      body: json["body"],
      updatedAt: checkDateTime(json["updated_at"]),
      deletedAt: checkDateTime(json["deleted_at"]),
      user: User.fromJson(json["user"]),
    );
  }
}

List<Thread> threadsFromListJson(List<dynamic> dataList) {
  var data = dataList.map((e) => Thread.fromJson(e)).toList();

  return data;
}
