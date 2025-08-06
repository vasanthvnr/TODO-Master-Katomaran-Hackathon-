import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/auth_service.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$');
    return emailRegex.hasMatch(email);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage("Email and password cannot be empty.");
      return;
    }

    if (!isValidEmail(email)) {
      showMessage("Please enter a valid email address.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/users/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["status"] == "success") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        } else {
          showMessage("Invalid email or password.");
        }
      } else {
        showMessage("Login failed. Server error.");
      }
    } catch (e) {
      showMessage("Login failed. Please check your connection.");
    }
  }

  Future<void> handleGoogleLogin() async {
    final userCred = await AuthService.signInWithGoogle();
    if (userCred != null) {
      final email = userCred.user?.email;
      final name = userCred.user?.displayName;
      final photoUrl = userCred.user?.photoURL;

      try {
        final response = await http.post(
          Uri.parse("http://10.0.2.2:8080/api/users/google-login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "name": name,
            "photoUrl": photoUrl,
          }),
        );

        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        } else {
          showMessage("Google login failed.");
        }
      } catch (e) {
        showMessage("Error connecting to server.");
      }
    } else {
      print("Google Sign-In failed or cancelled.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed:
                            () => setState(
                              () => isPasswordVisible = !isPasswordVisible,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "or login with",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _iconSocialButton(
                        "Google",
                        Icons.g_mobiledata,
                        Colors.red,
                        handleGoogleLogin,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        children: [
                          TextSpan(text: "Don't have an account? click "),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _iconSocialButton(
  String label,
  IconData icon,
  Color iconColor,
  VoidCallback onPressed,
) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 2,
    ),
    icon: Icon(icon, color: iconColor, size: 24),
    label: Text(label, style: TextStyle(color: Colors.black)),
    onPressed: onPressed,
  );
}
