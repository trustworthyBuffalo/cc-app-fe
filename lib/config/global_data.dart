import 'package:cobaaja/model/user.dart';

class UserGlobalData {
  static User? userData;

  static void loadUserGlobalDdata(User data) {
    userData = data;
  }
}
