import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teefi/views/auth/login_screen.dart';
import 'package:teefi/views/admin/admin_dashboard_screen.dart';
import 'package:teefi/views/parent/parent_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final roleId = prefs.getInt('role_id') ?? 0; // ✅

      print("TOKEN: $token");
      print("ROLE ID: $roleId");

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            if (token == null) return const LoginScreen();
            return roleId == 1
                ? const DashboardScreen()
                : const ParentHomeScreen(); // ✅
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}