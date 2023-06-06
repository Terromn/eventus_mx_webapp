import 'package:eventus/assets/app_color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final String? _teFont = GoogleFonts.mPlusRounded1c().fontFamily;

class TeAppThemeData {
  // GENERAL THEME DATA //
  static List<BoxShadow> teShadow = const <BoxShadow>[
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
  ];

  static final ThemeData darkTheme = ThemeData(
    // APPBAR //
    appBarTheme: AppBarTheme(
      backgroundColor: TeAppColorPalette.purple,
      foregroundColor: TeAppColorPalette.white,
      elevation: 12,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontFamily: _teFont,
        fontWeight: FontWeight.bold,
      ),
    ),

    // BOTTOM NAV BAR //
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: TeAppColorPalette.purple,
      selectedItemColor: TeAppColorPalette.white,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 42),
      unselectedIconTheme: IconThemeData(size: 32),
      elevation: 12,
    ),

    // ElEVATED BUTTON //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
        backgroundColor:
            MaterialStateProperty.all<Color>(TeAppColorPalette.purple),
        alignment: Alignment.center,
        elevation: MaterialStateProperty.all(12),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    ),

    // SNACK BAR //
     snackBarTheme: const SnackBarThemeData(
      backgroundColor: TeAppColorPalette.black, // Set the desired background color
      contentTextStyle: TextStyle(color: TeAppColorPalette.white), // Set the desired text color
    ),

    // TEXT BUTTON //
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
      ),
    ),

    // CARD //
    cardTheme: CardTheme(
      elevation: 24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: TeAppColorPalette.white,
    ),

    // TEXTFIELD //
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: TeAppColorPalette.white),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: TeAppColorPalette.purple, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),

    splashColor: TeAppColorPalette.purple,
    scaffoldBackgroundColor: TeAppColorPalette.black,

    // GENERAL //
    brightness: Brightness.dark,
    primaryColor: TeAppColorPalette.black,
    fontFamily: _teFont,
    textTheme: TextTheme(
      displayLarge: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: TeAppColorPalette.white),
      displayMedium:
          const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      bodyLarge: const TextStyle(
          fontSize: 20.0,
          color: TeAppColorPalette.white,
          fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey[300]),
    ),
  );
}
