import 'package:cobaaja/model/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGlobalData {
  static User? userData;

  static void loadUserGlobalDdata(User data) {
    userData = data;
  }
}

class AnalyticGlobalInstance {
  static late FirebaseAnalytics analytics;
}

class SaveLoginGlobalState {
  static late SharedPreferences saveLogin;
}
