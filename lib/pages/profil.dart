import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Color primaryColor = const Color(0xFF1867C0);
  final Color bgColor = const Color(0xFFF4F6FA);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      drawer: _premiumDrawer(),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title:  Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          _premiumHeader(),
           SizedBox(height: 12),
          _actionButtons(),
           SizedBox(height: 16),
          _tabBar(),
           Divider(height: 1),
          Expanded(child: _tabView()),
        ],
      ),
    );
  }

  Widget _premiumDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, Color(0xFF4A90E2)],
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
                  "Boogie Woogie",
                  style: TextStyle(
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
                _drawerItem(
                  Icons.person_outline,
                  "Profil",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDetailPage(),
                      ),
                    );
                  },
                ),
                _drawerItem(
                  Icons.notifications_outlined,
                  "Notifikasi",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationSettingsPage(),
                      ),
                    );
                  },
                ),
                _drawerItem(Icons.star_outline, "Langganan"),
                _drawerItem(Icons.people_outline, "Pengikut"),
                _drawerItem(Icons.settings_outlined, "Pengaturan"),
                Divider(),
                _drawerItem(Icons.help_outline, "Bantuan"),
                _drawerItem(Icons.info_outline, "Tentang"),
              ],
            ),
          ),

          Divider(),
          ListTile(
            leading:  Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Keluar",
              style: GoogleFonts.inter(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap ?? () {},
    );
  }

  Widget _premiumHeader() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileDetailPage()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: Color(0xFF1867C0),
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Boogie Woogie",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _filledButton("Edit Profil")),
          SizedBox(width: 12),
          Expanded(child: _outlineButton("Bagikan")),
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
        child: Text(text, style: TextStyle(color: Colors.white)),
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

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: primaryColor,
      tabs:  [
        Tab(text: "Postingan"),
        Tab(text: "Media"),
        Tab(text: "Suka"),
      ],
    );
  }

  Widget _tabView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _placeholder("Postingan"),
        _placeholder("Media"),
        _placeholder("Suka"),
      ],
    );
  }

  Widget _placeholder(String text) {
    return Center(child: Text(text));
  }
}
class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF1867C0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Detail"),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: primaryColor,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              "Boogie Woogie",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4),
          Center(child: Text("Software Engineer")),
          SizedBox(height: 20),
          Text("About", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            "Isi bio profil pengguna di sini. Bisa berisi informasi tentang latar belakang, minat, dan hal-hal lain yang ingin dibagikan.",
          ),
        ],
      ),
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
     Color primaryColor = Color(0xFF1867C0);

    return Scaffold(
      appBar: AppBar(
        title:  Text("Notifikasi"),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon:  Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        ListTile(
                          leading: Icon(Icons.notifications_off),
                          title: Text("Matikan semua notifikasi"),
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Pengaturan lanjutan"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        children:  [
          SwitchListTile(
            title: Text("Notifikasi Suka"),
            value: true,
            onChanged: null,
          ),
          SwitchListTile(
            title: Text("Notifikasi Komentar"),
            value: true,
            onChanged: null,
          ),
          SwitchListTile(
            title: Text("Notifikasi Pengikut"),
            value: false,
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
