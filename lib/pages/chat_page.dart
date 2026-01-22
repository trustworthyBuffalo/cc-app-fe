import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projek_cp/db_local/db_helper.dart';
import 'package:projek_cp/l10n/app_localizations.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> users = [
    {"id": "user_1", "name": "Rina"},
    {"id": "user_2", "name": "Doni"},
    {"id": "user_3", "name": "Budi"},
    {"id": "user_4", "name": "Siti"},
  ];

  final Color primaryColor = Color(0xFF1867C0);
  final Color bgColor = Color(0xFFF4F6FA);
  Map<String, String> nicknames = {};
  Map<String, String> backgrounds = {};

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    for (var user in users) {
      final setting = await DBHelper.instance.getChatSetting(user["id"]!);

      if (setting != null) {
        if (setting["nickname"] != null) {
          nicknames[user["id"]!] = setting["nickname"] as String;
        }
        if (setting["backgroundPath"] != null) {
          backgrounds[user["id"]!] = setting["backgroundPath"] as String;
        }
      }
    }

    if (mounted) setState(() {});
  }

  void editNickname(String userId, String originalName) {
    TextEditingController controller = TextEditingController(
      text: nicknames[userId] ?? "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ubah nama panggilan"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Contoh: Bestie"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                await DBHelper.instance.saveChatSetting(
                  userId: userId,
                  nickname: controller.text,
                  backgroundPath: backgrounds[userId],
                );

                nicknames[userId] = controller.text;
                if (mounted) setState(() {});
                Navigator.pop(context);
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> pickBackground(String userId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    await DBHelper.instance.saveChatSetting(
      userId: userId,
      nickname: nicknames[userId],
      backgroundPath: image.path,
    );

    backgrounds[userId] = image.path;
    if (mounted) setState(() {});
  }

  void openChat(String userId, String displayName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatRoomPage(
          userId: userId,
          displayName: displayName,
          backgroundPath: backgrounds[userId],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          language.msg,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: users.map((user) {
          final userId = user["id"]!;
          final originalName = user["name"]!;
          final displayName = (nicknames[userId]?.isNotEmpty == true)
              ? nicknames[userId]!
              : originalName;

          return GestureDetector(
            onTap: () => openChat(userId, displayName),
            onLongPress: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text(language.chatNN),
                          onTap: () {
                            Navigator.pop(context);
                            editNickname(userId, originalName);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.image),
                          title: Text(language.chatBg),
                          onTap: () {
                            Navigator.pop(context);
                            pickBackground(userId);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue,
                    child: Text(
                      displayName[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${language.openChat} • ${language.editChat}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ChatRoomPage extends StatelessWidget {
  final String userId;
  final String displayName;
  final String? backgroundPath;

  ChatRoomPage({
    super.key,
    required this.userId,
    required this.displayName,
    this.backgroundPath,
  });

  @override
  Widget build(BuildContext context) {
    DecorationImage? bg;

    if (backgroundPath != null && File(backgroundPath!).existsSync()) {
      bg = DecorationImage(
        image: FileImage(File(backgroundPath!)),
        fit: BoxFit.cover,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(displayName)),
      body: Container(
        decoration: BoxDecoration(image: bg, color: Colors.grey[200]),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(12),
                children: [
                  ChatBubble(text: "Hai apa kabar?", isMe: false),
                  ChatBubble(text: "Baik, kamu gimana?", isMe: true),
                  ChatBubble(text: "Lagi ngapain?", isMe: false),
                  ChatBubble(text: "Lagi ngoding Flutter 😄", isMe: true),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
