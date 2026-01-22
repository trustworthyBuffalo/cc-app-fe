import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projek_cp/l10n/app_localizations.dart';
import 'package:projek_cp/locale_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notifEnabled = true;
  String currentLanguage = "id";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool("darkMode") ?? false;
      notifEnabled = prefs.getBool("notif") ?? true;
      currentLanguage = prefs.getString("language") ?? "id";
    });
  }

  Future<void> _saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", value);
    setState(() {
      isDarkMode = value;
    });
  }

  Future<void> _saveNotif(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notif", value);
    setState(() {
      notifEnabled = value;
    });
  }

  Future<void> _saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", langCode);

    setState(() {
      currentLanguage = langCode;
    });
    LocaleNotifier.setLocale(Locale(langCode));
  }

  void _showLanguageDialog() {
    final language = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(language.chooseLang),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:  Text("🇮🇩", style: TextStyle(fontSize: 20)),
                title: Text(language.indonesia),
                trailing: currentLanguage == "id"
                    ?  Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  _saveLanguage("id");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:  Text("🇺🇸", style: TextStyle(fontSize: 20)),
                title: Text(language.english),
                trailing: currentLanguage == "en"
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  _saveLanguage("en");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     Color primaryColor = Color(0xFF1867C0);
    final language = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(language.setting),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
           SizedBox(height: 8),

          SwitchListTile(
            title: Text(language.dark),
            value: isDarkMode,
            onChanged: (value) {
              _saveDarkMode(value);
            },
          ),

          SwitchListTile(
            title: Text(language.notification),
            value: notifEnabled,
            onChanged: (value) {
              _saveNotif(value);
            },
          ),

           Divider(),

          ListTile(
            leading:  Icon(Icons.language),
            title: Text(language.language),
            subtitle: Text(currentLanguage == "id" ? "Indonesia" : "English"),
            trailing:  Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showLanguageDialog,
          ),

          ListTile(
            leading: Icon(Icons.lock),
            title: Text(language.privacy),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(language.aboutApk),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
