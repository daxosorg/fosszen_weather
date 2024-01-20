import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fosszen_weather/screens/signup_page.dart';
import 'package:fosszen_weather/screens/weather_screen.dart';
import 'package:fosszen_weather/utils/app_toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _signInWithEmailAndPassword();
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            const Text('Don\'t have an account?'),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        // email: _emailController.text.trim(),
        // password: _passwordController.text,
        email: 'a1@m.com',
        password: "00000000",
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherScreen()));
      AppToast.show('User logged in: ${userCredential.user!.email}');
      debugPrint('User logged in: ${userCredential.user!.email}');
    } catch (e) {
      debugPrint('Error during login: $e');
    }
  }
}
