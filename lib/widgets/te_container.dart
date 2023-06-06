import 'package:flutter/material.dart';

import '../assets/app_color_palette.dart';

class TeContainer extends StatelessWidget {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final double height;
  final Widget child;

  const TeContainer({
    super.key,
    required this.height,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeft),
                  bottomRight: Radius.circular(bottomRight),
                  topLeft: Radius.circular(topLeft),
                  topRight: Radius.circular(topRight)),
              gradient: const LinearGradient(
                colors: [TeAppColorPalette.purple, TeAppColorPalette.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: TeAppColorPalette.pink,
                  offset: Offset(2, 2),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: TeAppColorPalette.purple,
                  offset: Offset(-2, -2),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          Container(
            margin: topLeft == 0
                ? const EdgeInsets.only(bottom: 4, left: 4, right: 4)
                : const EdgeInsets.only(top: 4, left: 4, right: 4),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 12,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeft),
                  bottomRight: Radius.circular(bottomRight),
                  topLeft: Radius.circular(topLeft),
                  topRight: Radius.circular(topRight),
                ),
                color: TeAppColorPalette.black),
            child: Container(
              margin:
                  const EdgeInsets.only(bottom: 4, left: 4, right: 4, top: 0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                  child: Container(
                    color: TeAppColorPalette.black,
                    child: Center(child: child),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
