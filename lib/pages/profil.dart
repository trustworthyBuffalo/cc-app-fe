import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projek_cp/l10n/app_localizations.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage>
    with SingleTickerProviderStateMixin {
  String? namaUser;
  bool loadingUser = true;

  late TabController _tabController;

  final Color primaryColor =  Color(0xFF1867C0);
  final Color bgColor =  Color(0xFFF4F6FA);

  Future<void> loadUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        namaUser = doc["nama"];
        loadingUser = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadUser();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bgColor,
      drawer: _premiumDrawer(language),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          language.profile,
          style:  TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _premiumHeader(language),
           SizedBox(height: 12),
          _actionButtons(language),
           SizedBox(height: 16),
          _tabBar(language),
           Divider(height: 1),
          Expanded(child: _tabView(language)),
        ],
      ),
    );
  }

  Widget _premiumDrawer(AppLocalizations language) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, const Color(0xFF4A90E2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50),
                ),
                 SizedBox(height: 12),
                Text(
                  loadingUser ? "Loading..." : (namaUser ?? "User"),
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(height: 4),
                 Text(
                  "Software Engineer",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _drawerItem(Icons.person_outline, language.profile),
                _drawerItem(
                  Icons.notifications_outlined,
                  language.notification,
                ),
                _drawerItem(Icons.star_outline, language.vip),
                _drawerItem(Icons.people_outline, language.followers),
                _drawerItem(
                  Icons.settings_outlined,
                  language.setting,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                 Divider(),
                _drawerItem(Icons.help_outline, language.help),
                _drawerItem(Icons.info_outline, language.about),
              ],
            ),
          ),
           Divider(),
          ListTile(
            leading:  Icon(Icons.logout, color: Colors.red),
            title: Text(
              language.logout,
              style: GoogleFonts.inter(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
           SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style:  TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _premiumHeader(AppLocalizations language) {
    return Container(
      margin:  EdgeInsets.all(16),
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow:  [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: primaryColor,
            child:  Icon(Icons.person, color: Colors.white, size: 40),
          ),
           SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loadingUser ? "Loading..." : (namaUser ?? "User"),
                  style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 SizedBox(height: 4),
                 Text(
                  "Computer Science • Mobile Developer",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.verified, color: primaryColor),
        ],
      ),
    );
  }

  Widget _actionButtons(AppLocalizations language) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _filledButton(language.editProfile)),
          const SizedBox(width: 12),
          Expanded(child: _outlineButton(language.share)),
        ],
      ),
    );
  }

  Widget _filledButton(String text) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(text, style:  TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _outlineButton(String text) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: primaryColor)),
    );
  }

  Widget _tabBar(AppLocalizations language) {
    return TabBar(
      controller: _tabController,
      labelColor: primaryColor,
      tabs: [
        Tab(text: language.post),
        Tab(text: language.media),
        Tab(text: language.like),
      ],
    );
  }

  Widget _tabView(AppLocalizations language) {
    return TabBarView(
      controller: _tabController,
      children: [
        Center(child: Text(language.post)),
        Center(child: Text(language.media)),
        Center(child: Text(language.like)),
      ],
    );
  }
}
