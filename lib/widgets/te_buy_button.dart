import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';

class TeBuyButton extends StatelessWidget {
  final Color color1;
  final Color color2;

  final double width;
  final double height;

  final String text;
  final Icon icon;

  final Uri url;

  const TeBuyButton({
    super.key,
    required this.color1,
    required this.color2,
    required this.width,
    required this.height,
    required this.text,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (() {
        js.context.callMethod('open', ['$url', '_blank']);
      }),
      icon: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color1,
                color2,
              ],
            ),
          ),
          child: Center(child: icon)),
    );
  }
}
// Ge