import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bank_app/constants/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static User? get user => FirebaseAuth.instance.currentUser;
  static String? get userid => FirebaseAuth.instance.currentUser?.uid;
  static String? get userEmail => FirebaseAuth.instance.currentUser?.email;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    (SplashScreen.user == null) ? navigateToLogin() : navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (!context.mounted) return;
    context.go(RouteConstants.home);
  }

  navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (!context.mounted) return;
    context.go(RouteConstants.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("images/ss.gif"),
            ),
            TypewriterAnimatedTextKit(
              speed: const Duration(milliseconds: 100),
              text: const ['BANK APP'],
              textStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
