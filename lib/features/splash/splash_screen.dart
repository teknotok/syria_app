import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syria_app/features/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          tr('welcome'),
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
      ),
    );
  }
}
