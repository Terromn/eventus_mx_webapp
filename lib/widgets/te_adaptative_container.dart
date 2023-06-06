import 'package:eventus/assets/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../assets/app_color_palette.dart';

class TeAdaptativeContainer extends StatelessWidget {
  final Widget child;

  const TeAdaptativeContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        gradient: const LinearGradient(
          colors: [TeAppColorPalette.purple, TeAppColorPalette.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: TeAppThemeData.teShadow,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: TeAppColorPalette.black,
        ),
        margin: const EdgeInsets.only(bottom: 0, left: 4, right: 4, top: 4),
        padding: const EdgeInsets.only(bottom: 0, left: 12, right: 12, top: 12),
        child: child,
      ),
    );
  }
}
