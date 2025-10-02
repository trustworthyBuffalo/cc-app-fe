import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cobaaja/Screen/login.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _jaga = true;

  @override
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
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: "Username",
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
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
                                controller: _passwordController,
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
                            SizedBox(height: 20),
                            SizedBox(
                              width: 400,
                              height: 40,
                              child: TextField(
                                controller: _confirmpasswordController,
                                obscureText: _jaga,
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Color(0xFF1867C0),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 85, 85, 85),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "LogIn",
                              style: TextStyle(
                                color: Color.fromARGB(255, 85, 85, 85),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                            ),
                          ),
                        ],
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
