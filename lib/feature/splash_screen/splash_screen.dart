import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tijara/feature/auth/screens/login_screen.dart' show LoginScreen;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  gotNext() => Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false);
  startDely() {
    _timer = Timer(const Duration(milliseconds: 3000), gotNext);
  }

  @override
  void initState() {
    super.initState();
    startDely();
  }

  @override
  void dispose() {
    super.dispose();
    startDely();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/splash.jpg',
        fit: BoxFit.cover,
      )),
    );
  }
}
