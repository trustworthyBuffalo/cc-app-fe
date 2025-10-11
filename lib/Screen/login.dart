import 'dart:convert';

import 'package:cobaaja/Screen/profil.dart';
import 'package:cobaaja/config/db.dart';
import 'package:cobaaja/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cobaaja/Screen/signin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _jaga = true;
  Future<http.Response?>? fethData;

  var message = false;

  void _tombolpass() {
    setState(() {
      _jaga = !_jaga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xFF96B8FA),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: 24, right: 24),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Belajar dan Berkolaborasi\n",
                              style: GoogleFonts.inter(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1867C0),
                              ),
                            ),
                            TextSpan(
                              text: "Ide\n",
                              style: GoogleFonts.inter(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1867C0),
                              ),
                            ),
                            TextSpan(
                              text: "Forum Diskusi Para Mahasiswa",
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1867C0),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        width: 400,
                        height: 400,
                        child: Image.asset(
                          'pic/login.png',
                          width: 350,
                          height: 350,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "Hi, There!",
                        style: GoogleFonts.pacifico(
                          color: Color(0xFF1867C0),
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                        ),
                      ),
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: Color(0xFF1867C0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 400,
                              height: 40,
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email or Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  prefixIcon: Icon(Icons.person_rounded),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: 400,
                              height: 40,
                              child: TextField(
                                controller: passwordController,
                                obscureText: _jaga,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: _tombolpass,
                                    icon: Icon(
                                      _jaga
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Color(0xFF949494)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {

                            final response = await User.login(emailController.text, passwordController.text);

                            if (response == null) return;

                            final data = json.decode(response.body);
                            if (data["success"]) {
                              
                              final db = await DB.getDB();
                              await db.execute('CREATE TABLE IF NOT EXISTS tokens (id INTEGER PRIMARY KEY, token TEXT)');
                              await db.insert("tokens", {"token": data["data"]["token"]});
                              var token = await db.query('tokens');
                              print(token);

                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage(),));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data["message"] ?? "login gagal"))
                              );
                            }


                          },  
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Color(0xFF1867C0),
                          ),
                          child: Text("login")
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don`t have an account? SignUp",
                          style: TextStyle(color: Color(0xFF949494)),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
