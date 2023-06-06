import 'package:eventus/screens/auth/auth.dart';
import 'package:eventus/screens/auth/login_register_screen.dart';
import 'package:eventus/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class AuthWidgetTree extends StatefulWidget {
  const AuthWidgetTree({super.key});

  @override
  State<AuthWidgetTree> createState() => AuthWidgetTreeState();
}

class AuthWidgetTreeState extends State<AuthWidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProfileScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
