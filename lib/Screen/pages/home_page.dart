import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/post_data.dart';

class HomePage extends StatelessWidget {
  final Function(Map<String, dynamic>) onOpenDetail;
  const HomePage({super.key, required this.onOpenDetail});

  String formatTime(String dateTimeStr) {
    final dateTime = DateTime.parse(dateTimeStr);
    return DateFormat('dd MMM yyyy • HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            children: [
              TextSpan(text: 'Campus', style: TextStyle(color: Colors.blue)),
              TextSpan(text: 'Collab', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],

        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final post = postList[index];
          final username = post['username'] ?? 'Anonim';
          final nim = post['nim'] ?? '-';
          final content = post['content'] ?? '';
          final imageUrl = post['imageUrl'];
          final time = post['time'] ?? '';
          final comments = post['comments'] as List<dynamic>;
          final likes = post['likes'] ?? 0;
          final isLiked = post['isLiked'] ?? false;

          return Column(
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(username[0].toUpperCase()),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  #$nim\n",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  TextSpan(
                                    text: formatTime(time),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    if (imageUrl != null && imageUrl.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.0),
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 12,
                      ),
                      child: Text(content),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.black,
                                    size: 22,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text('$likes', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            SizedBox(width: 10),

                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => onOpenDetail(post),
                                  child: Icon(
                                    Icons.mode_comment_outlined,
                                    size: 22,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '${comments.length}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),

                            GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.share_outlined, size: 22),
                            ),
                            SizedBox(width: 10),

                            GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.bookmark_border, size: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey, height: 0),
            ],
          );
        },
      ),
    );
  }
}
