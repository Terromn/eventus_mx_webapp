import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      backgroundColor: TeAppColorPalette.black,
      childWidget: SizedBox(
        height: 200,
        child: Image.asset("images/logo.png"),
      ),
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 1000),
      onAnimationEnd: () => debugPrint("On Scale End"),
      defaultNextScreen: const MainScreen(),
    );
  }
}
