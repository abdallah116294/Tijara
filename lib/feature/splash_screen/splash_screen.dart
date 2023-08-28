import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tijara/feature/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  gotNext() {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const RootScreen()),
      (route) => false);
  }

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
