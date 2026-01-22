import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loading = false;

  void login() async {
    if (loading) return; // cegah double tap

    try {
      setState(() => loading = true);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );

      // ❗ Jangan navigate apa-apa
      // AuthGate yang akan pindahkan otomatis
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "Login gagal";

      if (e.code == "user-not-found") {
        message = "Email tidak terdaftar";
      } else if (e.code == "wrong-password") {
        message = "Password salah";
      } else if (e.code == "invalid-email") {
        message = "Format email salah";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login gagal: $e")));
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1867C0);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),

          // ================= EMAIL =================
          _FormCard(
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ================= PASSWORD =================
          _FormCard(
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ================= LOGIN BUTTON =================
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
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
              onPressed: loading ? null : login,
              child: loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // ================= REGISTER =================
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  RegisterPage()),
                );
              },
              child: const Text("Dont have an account? SignIn"),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// ================= FORM CARD ==========================
// =====================================================

class _FormCard extends StatelessWidget {
  final Widget child;

  const _FormCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: child,
    );
  }
}
