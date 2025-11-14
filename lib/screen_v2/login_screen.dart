import 'package:cobaaja/config/global_data.dart';
import 'package:cobaaja/model/user.dart';
import 'package:cobaaja/model/wrapper.dart';
import 'package:cobaaja/screen_v2/feed_screen.dart';
import 'package:cobaaja/service/user_service.dart';
import 'package:cobaaja/widget/text_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();

  // TODO: refactor this function
  Future<void> saveLoginOption(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("simpan login?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await SaveLoginGlobalState.saveLogin.setBool(
                  'seveLogin',
                  false,
                );
                Navigator.pop(context);
              },
              child: Text("n"),
            ),
            ElevatedButton(
              onPressed: () async {
                await SaveLoginGlobalState.saveLogin.setBool('saveLogin', true);
                Navigator.pop(context);
              },
              child: Text("y"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Card(
            color: Colors.amber,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldNormal(controller: _emailC, name: "email"),
                TextFieldNormal(controller: _passwordC, name: "password"),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    ApiResult data = await UserService.login(
                      UserLogin(email: _emailC.text, password: _passwordC.text),
                    );

                    if (data.isSuccess) {
                      // analityc
                      await AnalyticGlobalInstance.analytics.logEvent(
                        name: "login_cc_app",

                        parameters: {"online": "login page"},
                      );

                      await saveLoginOption(context);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FeedScreen()),
                      );
                    }
                  },
                  child: Text("register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
