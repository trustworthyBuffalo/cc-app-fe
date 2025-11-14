import 'package:cobaaja/model/user.dart';
import 'package:cobaaja/model/wrapper.dart';
import 'package:cobaaja/screen_v2/succes_screen.dart';
import 'package:cobaaja/service/user_service.dart';
import 'package:cobaaja/widget/text_fields.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _phoneC = TextEditingController();
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();

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
                TextFieldNormal(controller: _nameC, name: "name"),
                TextFieldNormal(controller: _phoneC, name: "phone"),
                TextFieldNormal(controller: _emailC, name: "email"),
                TextFieldNormal(controller: _passwordC, name: "password"),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    ApiResult data = await UserService.register(
                      UserRegister(
                        name: _nameC.text,
                        handphone: _phoneC.text,
                        email: _emailC.text,
                        password: _passwordC.text,
                      ),
                    );

                    if (data.isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  SuccessScreen(content: "daftar berhasil"),
                        ),
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
