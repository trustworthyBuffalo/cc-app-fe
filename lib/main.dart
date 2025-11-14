import 'package:cobaaja/config/db.dart';
import 'package:cobaaja/config/global_data.dart';
import 'package:cobaaja/screen_v2/feed_screen.dart';
import 'package:cobaaja/screen_v2/login_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  AnalyticGlobalInstance.analytics = FirebaseAnalytics.instance;

  // Shared preference
  SaveLoginGlobalState.saveLogin = await SharedPreferences.getInstance();

  // sqflite db init
  await DB.dbInit();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget directLogin() {
    bool? isLogin = SaveLoginGlobalState.saveLogin.getBool('saveLogin');

    print(isLogin);
    if (isLogin == null || !isLogin) {
      return LoginScreen();
    }

    return FeedScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: AnalyticGlobalInstance.analytics),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: directLogin(),
    );
  }
}
