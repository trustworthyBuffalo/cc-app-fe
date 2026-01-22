import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projek_cp/models/model_acc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;

  void register() async {
    if (namaController.text.isEmpty ||
        emailController.text.isEmpty ||
        nimController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password dan konfirmasi tidak sama")),
      );
      return;
    }

    try {
      setState(() {
        loading = true;
      });

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      String uid = userCredential.user!.uid;

      UserModel user = UserModel(
        uid: uid,
        nama: namaController.text.trim(),
        email: emailController.text.trim(),
        nim: nimController.text.trim(),
        createdAt: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(user.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrasi berhasil, silakan login")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal daftar: $e")),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    nimController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     Color primaryColor = Color(0xFF1867C0);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title:  Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding:  EdgeInsets.all(16),
        children: [
           SizedBox(height: 12),

          _FormCard(
            child: TextField(
              controller: namaController,
              decoration:  InputDecoration(
                hintText: "Full Name",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),

           SizedBox(height: 12),

          _FormCard(
            child: TextField(
              controller: emailController,
              decoration:  InputDecoration(
                hintText: "Campus Email",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),

           SizedBox(height: 12),

          _FormCard(
            child: TextField(
              controller: nimController,
              decoration:  InputDecoration(
                hintText: "NIM",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.badge),
              ),
            ),
          ),

           SizedBox(height: 12),

          _FormCard(
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                hintText: "Password",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),

      SizedBox(height: 12),

          _FormCard(
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration:  InputDecoration(
                hintText: "Confirm Password",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
          ),

           SizedBox(height: 24),

          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow:  [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: loading ? null : register,
              child: loading
                  ?  SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  :  Text(
                      "Daftar",
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),

           SizedBox(height: 12),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text("Already Have an Account? LogIn"),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final Widget child;

   _FormCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow:  [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: child,
    );
  }
}
