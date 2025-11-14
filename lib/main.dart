import 'package:cobaaja/config/db.dart';
import 'package:cobaaja/screen_v2/login_screen.dart';
import 'package:cobaaja/screen_v2/register_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  // firebase
  WidgetsFlutterBinding.ensureInitialized();

  // sqflite db init
  await DB.dbInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
