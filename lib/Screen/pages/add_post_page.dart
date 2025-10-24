import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController postController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Tambah Postingan")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: postController,
              decoration: InputDecoration(
                labelText: "Tulis sesuatu...",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Postingan berhasil dikirim!")),
                );
              },
              icon: Icon(Icons.send),
              label: Text("Kirim"),
            ),
          ],
        ),
      ),
    );
  }
}
