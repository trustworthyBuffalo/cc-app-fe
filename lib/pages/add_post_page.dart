import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projek_cp/main_page.dart';
import 'package:projek_cp/model_post.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  List<Post> details = [];
  bool isChecked = false;
  final TextEditingController postController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Future readData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var data = await db.collection("posts").get();

    setState(() {
      details = data.docs.map((doc) => Post.fromDocSnapshot(doc)).toList();
    });
  }

  Future addData(String description, String imageUrl, bool isChecked) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("posts").add({
      'createdAt': Timestamp.now(),
      'description': description,
      'imageUrl': imageUrl,
      'isChecked': isChecked,
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tambah Postingan"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: "Masukkan URL Gambar",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.image),
              ),
            ),

            SizedBox(height: 16),

            TextField(
              controller: postController,
              decoration: InputDecoration(
                labelText: "Tulis sesuatu...",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text("Ads"),
              ],
            ),

            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final description = postController.text.trim();
                  final imageUrl = imageUrlController.text.trim();

                  if (description.isEmpty || imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Deskripsi dan URL gambar wajib diisi!"),
                      ),
                    );
                    return;
                  }

                  await addData(description, imageUrl, isChecked);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Postingan berhasil dikirim!")),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                icon: Icon(Icons.send),
                label: Text("Kirim"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
