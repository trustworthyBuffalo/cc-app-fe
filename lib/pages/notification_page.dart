import 'package:flutter/material.dart';
import 'package:projek_cp/l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;
  final Color primaryColor =  Color(0xFF1867C0);
  final Color bgColor =  Color(0xFFF4F6FA);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          language.notification,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          _NotificationCard(
            name: "Rina",
            message: language.likeNotif,
            time: "2 menit lalu",
          ),
          _NotificationCard(
            name: "Doni",
            message: language.commentNotif,
            time: "1 jam lalu",
          ),
          _NotificationCard(
            name: "Andi",
            message: language.followNotif,
            time: "Kemarin",
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const _NotificationCard({
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text(name[0], style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: " $message"),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(time, style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(language.notification)),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(language.likeNotifSet),
            value: true,
            onChanged: null,
          ),
          SwitchListTile(
            title: Text(language.commentNotifSet),
            value: true,
            onChanged: null,
          ),
          SwitchListTile(
            title: Text(language.followNotifSet),
            value: false,
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
