import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Notifikasi"), backgroundColor: Colors.white),
      body: ListView(
        children: [
          ListTile(title: Text("Rina menyukai postinganmu")),
          ListTile(title: Text("Doni mengomentari postinganmu")),
        ],
      ),
    );
  }
}
