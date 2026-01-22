import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projek_cp/l10n/app_localizations.dart';
import 'package:projek_cp/main_page.dart';
import 'package:projek_cp/models/model_post.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  List<Post> details = [];

  final Color primaryColor = Color(0xFF1867C0);
  final Color bgColor = Color(0xFFF4F6FA);
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
    final language = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          language.addPost,
          style:  TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          _FormCard(
            child: TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                prefixIcon:  Icon(Icons.image),
                hintText: language.addImageURL,
                border: InputBorder.none,
              ),
            ),
          ),

           SizedBox(height: 12),

          _FormCard(
            child: TextField(
              controller: postController,
              decoration: InputDecoration(
                hintText: language.writePost,
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
          ),

           SizedBox(height: 12),

          _FormCard(
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text(language.ads),
              ],
            ),
          ),

           SizedBox(height: 20),

          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                final description = postController.text.trim();
                final imageUrl = imageUrlController.text.trim();

                if (description.isEmpty || imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(language.desImgRequired)),
                  );
                  return;
                }

                await addData(description, imageUrl, isChecked);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(language.succesSend)));

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              icon: Icon(Icons.send),
              label: Text(language.succesSend),
            ),
          ),
        ],
      ),
    );
  }
}
class _FormCard extends StatelessWidget {
  final Widget child;

  const _FormCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: child,
    );
  }
}
