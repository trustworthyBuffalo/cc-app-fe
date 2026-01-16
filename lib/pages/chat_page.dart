import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Pesan"), backgroundColor: Colors.white),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text("Rina"),
            subtitle: Text("Hai, gimana kabarnya?"),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text("Doni"),
            subtitle: Text("Nanti kita coding bareng ya"),
          ),
        ],
      ),
    );
  }
}
